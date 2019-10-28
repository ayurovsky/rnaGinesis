#' generate_data_set_list
#'
#' @export
#' @import ggplot2
#' @import reshape2

pull_exprs_and_GEP <- function(data = parsed_projects, gene = c("PHGDH", "PSAT1", "PSPH")){
   BigData <- NULL
   for (i in names(data)){
      this_proj <- data[[i]]
      index <- which(this_proj[[7]]$GeneSymbol %in% gene)
      
      melted.gep <- melt(this_proj[[7]][index,], value.name = "GEP")
      melted.stderr <- melt(this_proj[[6]][index,], value.name = "stderr")
      
      melted <- join(melted.gep, melted.stderr)
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
   g <- ggplot(data = BigData, aes(x = source, y = GEP, ymin = GEP, ymax = GEP + 1.96*stderr, color = source)) + 
      geom_pointrange() + facet_grid(rows = vars(GeneSymbol), 
                                     cols = vars(variable), 
                                     scales = "free_y") + scale_y_sqrt()
   g <- g + theme(axis.text.x = element_text(angle = 45, hjust = 1))
   g
}