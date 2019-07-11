#' generate_data_set_list
#'
#' @export
#' @import GEOquery
#' @import Matrix
#' @import readr

#-----------------------------GSE97284-----------------------------------

parseGSE97284 <- function() {
 # library(GEOquery)
 # library(Matrix)
 # library(readr)
  
  gse <- getGEO("GSE97284", 
                GSEMatrix = TRUE, 
                getGPL = FALSE)
  gse <- gse$GSE97284_series_matrix.txt.gz
  ex <- exprs(gse)
  sampInfo <- gse@phenoData
  featInfo <- data.frame(SYMBOL = rownames(ex))
  parsedGSE97284 <- list()
  parsedGSE97284$ex <- exprs(gse)
  parsedGSE97284$sampInfo <- sampInfo@data
  parsedGSE97284$featInfo <- featInfo
  parsedGSE97284$metadata <- list(log.transformed = FALSE,
                                   reference = "Tyekucheva S, Bowden M, Bango C, Giunchi F et al. Stromal and epithelial transcriptional map of initiation progression and metastatic potential of human prostate cancer. Nat Commun 2017 Sep 4;8(1):420. PMID: 28871082",
                                   accession = "GSE97284",
                                   description = "25 samples of isolated tumor tissues, 25 samples of isolated stromal tissues, and 23 admixture samples",
                                   survivalA = "None",
                                   survivalB = "None")       
  
  save(parsedGSE97284, file = "./data/datasetGSE97284.RData")
  return(NULL)
}

