#-----------------------------GSE97284-----------------------------------

parseGSE97284 <- function() {
  library(GEOquery)
  library(Matrix)
  library(readr)
  
  gse <- getGEO("GSE97284", 
                GSEMatrix = TRUE, 
                getGPL = FALSE)
  gse <- gse$GSE97284_series_matrix.txt.gz
  expression <- exprs(gse)
  sampleInfo <- gse@phenoData
  featureInfo <- data.frame(SYMBOL = rownames(expression))
  parsedGSE97284 <- list()
  parsedGSE97284$expression <- exprs(gse)
  parsedGSE97284$sampleInfo <- sampleInfo@data
  parsedGSE97284$featureInfo <- data.frame(SYMBOL = rownames(expression))
  
  save(parsedGSE97284, file = "./data/datasetGSE97284.RData")
  return(NULL)
}

