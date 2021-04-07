#' generate_data_set_list
#'
#' @export
#' @import GEOquery
#' @import Matrix
#' @import readr

#-----------------------------GSE19830----------------------------------

parseGSE19830 <- function() {
 # library(GEOquery)
 # library(Matrix)
 # library(readr)
  
  gse <- getGEO("GSE19830", 
                GSEMatrix = TRUE, 
                getGPL = FALSE)
  gse <- gse$GSE19830_series_matrix.txt.gz
  ex <- exprs(gse)
  sampInfo <- gse@phenoData
  featInfo <- data.frame(SYMBOL = rownames(ex))
  parsedGSE19830 <- list()
  parsedGSE19830$expression <- ex
  parsedGSE19830$sampleInfo <- sampInfo
  parsedGSE19830$featureInfo <- featInfo
  parsedGSE19830$metadata <- list(log.transformed = FALSE,
                                   reference = "Shen-Orr SS, Tibshirani R, Khatri P, Bodian DL et al. Cell type-specific gene expression differences in complex tissues. Nat Methods 2010 Apr;7(4):287-9. PMID: 20208531",
                                   accession = "GSE19830",
                                   description = "30 mixed samples of liver, brain, and lung tissues in 10 different mixing proportions with three replicates",
                                   survivalA = "None",
                                   survivalB = "None")
  
  save(parsedGSE19830, file = "./data/alisa_datasetGSE19830.RData")
  return(NULL)
}
