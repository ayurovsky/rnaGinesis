# Obtains cell-type specific gene expression profiles of X most common cell-types in data from centroid

subsetCentroid <- function(data, centroid, numTypes) {
  # obtains counts of each cell type
  cellTypeCounts <- as.data.frame((summary(factor(data$metadata$celltype))))
   
  # orders cellTypeCounts in descending order
  cellTypeCounts <- cellTypeCounts[order(cellTypeCounts, decreasing = T),, drop = F]
   
  # Obtains names of X most common cell types
  orderedCellTypes <- as.matrix(rownames(cellTypeCounts))
  mostCommon <- orderedCellTypes[1:numTypes,]
  
  # Subsets centroid to contain gene expression profiles corresponding to X most common cell types
  centroid_subset <- centroid[,which(colnames(centroid) %in% mostCommon)]
  
  return(centroid_subset)
}