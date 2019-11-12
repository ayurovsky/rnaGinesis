#' generate_data_set_list
#'
#' @export
#' @import plyr
#' @import ggplot2
#' @import reshape2

plot_GEPxFrac <- function(data = parsed_projects, gene = c("PHGDH", "IL27")){
  BigData <- NULL
  for (i in names(data)){
    this_proj <- data[[i]]

    index <- which(this_proj[[7]]$GeneSymbol %in% gene)
    
    melted.gep <- reshape2::melt(this_proj[[7]][index,], value.name = "GEP")
    melted.gep <- melted.gep[order(melted.gep$GeneSymbol),]

    fracs <- this_proj[[1]][,-1]
    fracs <- colMeans(as.matrix(fracs))
    
    
    #cleaner plot names
    proj_name <- strsplit(i,split = "_")[[1]]
    proj_name <- paste0(proj_name[2],"_",proj_name[3])
    
    temp <- data.frame(cell_type = melted.gep$variable,
                       GEPxFRAC = log(1 + fracs[1:7]*melted.gep$GEP),
                       source = proj_name,
                       SYMBOL = melted.gep$GeneSymbol)
    rownames(temp) <- NULL
    if (is.null(BigData)){
      BigData = temp
    }
    else{
      BigData = rbind(BigData, temp)
      print(dim(BigData))
    }

  }
  summary(BigData)
  
  g <- ggplot(data = BigData, aes(x = source, y = GEPxFRAC, color = source)) + 
    geom_point() + facet_grid(rows = vars(SYMBOL),
                              cols = vars(cell_type),
                              scales = "free_y") + scale_y_log10()
  g <- g + theme(axis.text.x = element_text(angle = 45, hjust = 1))
  print(g)

}