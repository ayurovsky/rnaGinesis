#-----------------------------GSE127472-----------------------------------

parseGSE127472 <- function() {
  library(GEOquery)
  library(Matrix)
  library(readr)
  
  gse <- getGEO("GSE127472", 
                GSEMatrix = TRUE, 
                getGPL = FALSE)
  gse <- gse$`GSE127472-GPL570_series_matrix.txt.gz`
  ex <- exprs(gse)
  sampInfo <- gse@phenoData
  featInfo <- data.frame(SYMBOL = rownames(expression))
  parsedGSE127472 <- list()
  parsedGSE127472$ex <- ex
  parsedGSE127472$sampInfo <- sampInfo@data
  parsedGSE127472$featInfo <- featInfo
  parsedGSE127472$metadata <- list(log.transformed = FALSE,
                                   reference = "Newman AM, Steen CB, Liu CL, Gentles AJ et al. Determining cell type abundance and expression from bulk tissues with digital cytometry. Nat Biotechnol 2019 Jul;37(7):773-782. PMID: 31061481",
                                   accession = "GSE12772",
                                   description = "single cell RNAseq PBMCs from a patient with non-small cell lung cancer",
                                   survivalA = "None",
                                   survivalB = "None"
                                   )
  
  save(parsedGSE127472, file = "./data/datasetGSE127472.RData")
  return(NULL)
}