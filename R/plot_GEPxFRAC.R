#' generate_data_set_list
#'
#' @export
#' @import plyr
#' @import ggplot2
#' @import reshape2

plot_GEPxFrac <- function(data = parsed_projects){
  BigData <- NULL
  for (i in names(data)){
    this_proj <- data[[i]]

    melted.gep <- reshape2::melt(this_proj[[7]], value.name = "GEP")
    melted.gep <- aggregate(melted.gep[,3],
                            list(melted.gep$variable),
                            sum)

    fracs <- this_proj[[1]][,-1]
    fracs <- colMeans(as.matrix(fracs))
    
    #cleaner plot names
    proj_name <- strsplit(i,split = "_")[[1]]
    proj_name <- paste0(proj_name[2],"_",proj_name[3])
    
    temp <- data.frame(cell_type = melted.gep$Group.1,
                       GEPxFRAC = log(1 + fracs[1:7]*melted.gep$x),
                       source = proj_name)
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
    geom_point() + facet_wrap(facets = vars(cell_type),
                              ncol = 4, 
                              scales = "free_y") + scale_y_log10()
  g <- g + theme(axis.text.x = element_text(angle = 45, hjust = 1))
  print(g)
  
  g <- ggplot(data = subset(BigData,!(is.na(fracs))), aes(x = source, y = fracs, color = source)) + 
    geom_point() + facet_wrap(facets = vars(variable))
  g <- g + theme(axis.text.x = element_text(angle = 45, hjust = 1))
  print(g)
}