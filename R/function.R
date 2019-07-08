library(GEOquery)
parse <- function() {
  #-----------------------------GSE19830-----------------------------------
  
  gse <- getGEO("GSE19830", GSEMatrix = TRUE, getGPL = FALSE)
  gse <- gse$GSE19830_series_matrix.txt.gz
  expression <- exprs(gse)
  sampleInfo <- gse@phenoData
  featureInfo <- data.frame(SYMBOL = rownames(expression))
  parsedGSE19830 <- list()
  parsedGSE19830$expression <- exprs(gse)
  parsedGSE19830$sampleInfo <- sampleInfo@data
  parsedGSE19830$featureInfo <- data.frame(SYMBOL = rownames(expression))
  
  #-----------------------------GSE97284-----------------------------------
  
  gse <- getGEO("GSE97284", GSEMatrix = TRUE, getGPL = FALSE)
  gse <- gse$GSE97284_series_matrix.txt.gz
  expression <- exprs(gse)
  sampleInfo <- gse@phenoData
  featureInfo <- data.frame(SYMBOL = rownames(expression))
  parsedGSE97284 <- list()
  parsedGSE97284$expression <- exprs(gse)
  parsedGSE97284$sampleInfo <- sampleInfo@data
  parsedGSE97284$featureInfo <- data.frame(SYMBOL = rownames(expression))
  
  #-----------------------------GSE127472-----------------------------------
  
  gse <- getGEO("GSE127472", GSEMatrix = TRUE, getGPL = FALSE)
  gse <- gse$`GSE127472-GPL570_series_matrix.txt.gz`
  expression <- exprs(gse)
  sampleInfo <- gse@phenoData
  featureInfo <- data.frame(SYMBOL = rownames(expression))
  parsedGSE127472 <- list()
  parsedGSE127472$expression <- expression
  parsedGSE127472$sampleInfo <- sampleInfo@data
  parsedGSE127472$featureInfo <- featureInfo
  
  #-----------------------------save-----------------------------------
  
  save(parsedGSE19830, file = "./data/datasetGSE19830.RData")
  save(parsedGSE97284, file = "./data/datasetGSE97284.RData")
  save(parsedGSE127472, file = "./data/datasetGSE127472.RData")
}
