#-----------------------------GSE127472-----------------------------------

parseGSE127472 <- function() {
  library(GEOquery)
  library(Matrix)
  library(readr)
  
  gse <- getGEO("GSE127472", 
                GSEMatrix = TRUE, 
                getGPL = FALSE)
  gse <- gse$`GSE127472-GPL570_series_matrix.txt.gz`
  expression <- exprs(gse)
  sampleInfo <- gse@phenoData
  featureInfo <- data.frame(SYMBOL = rownames(expression))
  parsedGSE127472 <- list()
  parsedGSE127472$expression <- expression
  parsedGSE127472$sampleInfo <- sampleInfo@data
  parsedGSE127472$featureInfo <- featureInfo
  
  save(parsedGSE127472, file = "./data/datasetGSE127472.RData")
  return(NULL)
}