#' generate_data_set_list
#'
#' @export
#' @import plyr
#' @import ggplot2
#' @import reshape2

pull_exprs_and_GEP <- function(data = parsed_projects, gene = c("PHGDH", "PSAT1", "PSPH")){
   BigData <- NULL
   for (i in names(data)){
      this_proj <- data[[i]]
      index <- which(this_proj[[7]]$GeneSymbol %in% gene)
      
      melted.gep <- reshape2::melt(this_proj[[7]][index,], value.name = "GEP")
      melted.stderr <- reshape2::melt(this_proj[[6]][index,], value.name = "stderr")
      
      fracs <- this_proj[[1]][,-1]
      fracs <- colSums(as.matrix(fracs))
      
      melted.fracs <- data.frame(GeneSymbol = "NA",
                                 variable = names(fracs),
                                 fracs = fracs)
      melted.fracs <- subset(melted.fracs,
                             !(variable %in% c("P-value",
                                             "Correlation",
                                             "RMSE")))
      
      melted <- plyr::join(melted.gep, melted.stderr)
      melted <- plyr::join(melted,melted.fracs,type="full")
      
   
      
      melted$source <- i
      if (is.null(BigData)){
         BigData = melted
      }
      else{
         BigData = rbind(BigData, melted)
         print(dim(BigData))
      }
   }
   summary(BigData)
   g <- ggplot(data = subset(BigData,!(is.na(GEP))), aes(x = source, y = GEP, ymin = GEP, ymax = GEP + 1.96*stderr, color = source)) + 
      geom_pointrange() + facet_grid(rows = vars(GeneSymbol), 
                                     cols = vars(variable), 
                                     scales = "free_y") + scale_y_log10()
   g <- g + theme(axis.text.x = element_text(angle = 45, hjust = 1))
   print(g)
   
   g <- ggplot(data = subset(BigData,!(is.na(fracs))), aes(x = source, y = fracs, color = source)) + 
      geom_point() + facet_wrap(facets = vars(variable))
   g <- g + theme(axis.text.x = element_text(angle = 45, hjust = 1))
   print(g)
}