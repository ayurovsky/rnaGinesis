library(GEOquery)
parse <- function() {
  gse <- getGEO("GSE30611", GSEMatrix = TRUE)
  gse <- gse$GSE30611_series_matrix.txt.gz
  parsedGSE30611 <- list()
  parsedGSE30611$expression <- exprs(gse)
  parsedGSE30611$sampleInfo <- gse@phenoData
  parsedGSE30611$featureInfo <- data.frame(SYMBOL = rownames(expression))
  save(parsedGSE30611, file = "./data/datasetGSE30611.RData")
}
