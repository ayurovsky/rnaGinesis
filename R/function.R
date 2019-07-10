library(GEOquery)
library(Matrix)
library(readr)

#-----------------------------GSE19830----------------------------------
parseGSE19830 <- function() {
  
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
  
}

#-----------------------------GSE97284-----------------------------------

parseGSE97284 <- function() {
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
}
  
#-----------------------------GSE127472-----------------------------------

parseGSE127472 <- function() {
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
}
#-----------------------------GSE127471-----------------------------------
parseGSE127471 <- function() {
  parsedGSE127471 <- readMM("./inst/extdata/GSM3635372_matrix.mtx")
  barcodes <- read_delim("inst/extdata/GSM3635372_barcodes.tsv","\t",  
                         escape_double = FALSE, 
                         col_names = FALSE, 
                         trim_ws = TRUE)
  genes <- read_delim("./inst/extdata/GSM3635372_genes.tsv","\t",  
                       escape_double = FALSE, 
                       col_names = FALSE, 
                       trim_ws = TRUE)
  rownames(parsedGSE127471) <- genes$X1
  colnames(parsedGSE127471) <- barcodes$X1
}

#-----------------------------GSE127813--------------------------------------

parseGSE127813 <- function() {
  parsedGSE127813 <- read.table("./inst/extdata/GSE127813_Whole_blood_gene_expression_matrix.txt")
}

#-------------------------------save---------------------------------------

saveGSE <- function() {
  save(parsedGSE19830, file = "./data/datasetGSE19830.RData")
  save(parsedGSE97284, file = "./data/datasetGSE97284.RData")
  save(parsedGSE127472, file = "./data/datasetGSE127472.RData")
  save(parsedGSE127471, file = "./data/datasetGSE127471.RData")
  save(parsedGSE127813, file = "./data/datasetGSE127813.RData")
}