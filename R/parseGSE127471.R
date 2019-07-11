#' generate_data_set_list
#'
#' @export
#' @import GEOquery
#' @import Matrix
#' @import readr

#-----------------------------GSE127471-----------------------------------

parseGSE127471 <- function() {
  # library(GEOquery)
  # library(Matrix)
  # library(readr)
  
  parsedGSE127471 <- list()
  parsedGSE127471$ex <- readMM("./inst/extdata/GSM3635372_matrix.mtx")
  parsedGSE127471$metadata <- list(log.transformed = FALSE,
                                   reference = "Newman AM, Steen CB, Liu CL, Gentles AJ et al. Determining cell type abundance and expression from bulk tissues with digital cytometry. Nat Biotechnol 2019 Jul;37(7):773-782. PMID: 31061481",
                                   accession = "GSE127471",
                                   description = "302 samples of follicular lymphoma lymph node biopsy",
                                   survivalA = "None",
                                   survivalB = "None") 
  
  barcodes <- read_delim("inst/extdata/GSM3635372_barcodes.tsv","\t",  
                         escape_double = FALSE, 
                         col_names = FALSE, 
                         trim_ws = TRUE)
  genes <- read_delim("./inst/extdata/GSM3635372_genes.tsv","\t",  
                      escape_double = FALSE, 
                      col_names = FALSE, 
                      trim_ws = TRUE)
  rownames(parsedGSE127471$ex) <- genes$X1
  colnames(parsedGSE127471$ex) <- barcodes$X1
  
  parsedGSE127471$sampInfo <- data.frame(id = barcodes$X1) 
  parsedGSE127471$featInfo <- data.frame(SYMBOL = genes$X1, 
                                         probe_id = genes$X2) 
  
  save(parsedGSE127471, file = "./data/datasetGSE127471.RData")
  return(NULL)
}
