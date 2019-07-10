#-----------------------------GSE127471-----------------------------------

parseGSE127471 <- function() {
  library(GEOquery)
  library(Matrix)
  library(readr)
  
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
  
  save(parsedGSE127471, file = "./data/datasetGSE127471.RData")
  return(NULL)
}
