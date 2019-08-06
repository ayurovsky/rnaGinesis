# Creates centroids representing average gene expression profile for each cell type
makeCentroid <- function(data) {
  # Creates matrix with centroid of each cell type from expression matrix aka avg alpha cell gene expression profile, avg beta cell gene expression profile, etc.
  x <- as.data.frame(t(data$ex))
  b <- as.character(data$sampInfo$cell_type)
  centroid <- t(stats::aggregate(x = x, by = list(type = b), FUN = mean))
  cell_types <- centroid[1,]
  centroid <- centroid[2:nrow(centroid),]
  
  # assigns colnames of centroid to the cell types names 
  colnames(centroid) <- as.matrix(cell_types)
  
  class(centroid) <- "numeric"
  return(centroid)
}