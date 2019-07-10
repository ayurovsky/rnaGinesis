#-----------------------------GSE127813--------------------------------------

parseGSE127813 <- function() {
  library(GEOquery)
  library(Matrix)
  library(readr)
  
  parsedGSE127813 <- read.table("./inst/extdata/GSE127813_Whole_blood_gene_expression_matrix.txt")
  save(parsedGSE127813, file = "./data/datasetGSE127813.RData")
  return(NULL)
}

