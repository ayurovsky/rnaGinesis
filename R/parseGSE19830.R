#-----------------------------GSE19830----------------------------------

parseGSE19830 <- function() {
  library(GEOquery)
  library(Matrix)
  library(readr)
  
  gse <- getGEO("GSE19830", 
                GSEMatrix = TRUE, 
                getGPL = FALSE)
  gse <- gse$GSE19830_series_matrix.txt.gz
  expression <- exprs(gse)
  sampleInfo <- gse@phenoData
  featureInfo <- data.frame(SYMBOL = rownames(expression))
  parsedGSE19830 <- list()
  parsedGSE19830$expression <- exprs(gse)
  parsedGSE19830$sampleInfo <- sampleInfo@data
  parsedGSE19830$featureInfo <- data.frame(SYMBOL = rownames(expression))
  
  save(parsedGSE19830, file = "./data/datasetGSE19830.RData")
}
