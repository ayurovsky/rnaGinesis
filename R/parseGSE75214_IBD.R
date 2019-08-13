#' generate_data_set_list
#'
#' @export
#' @import GEOquery


#-----------------------------GSE75214-----------------------------------

parseGSE75214 <- function() {
  # library(GEOquery)
  
  gse <- getGEO("GSE75214", 
                GSEMatrix = TRUE, 
                getGPL = FALSE)
  gse <- gse$GSE75214_series_matrix.txt.gz
  
  ex <- exprs(gse)
  sampInfo <- gse@phenoData
  featInfo <- data.frame(SYMBOL = rownames(ex))
  parsedGSE75214 <- list()
  parsedGSE75214$ex <- ex
  parsedGSE75214$sampInfo <- sampInfo@data
  parsedGSE75214$featInfo <- featInfo
  parsedGSE75214$metadata <- list(log.transformed = FALSE,
                                  reference = "Vancamelbeke M, Vanuytsel T, Farré R, Verstockt S et al. Genetic and Transcriptomic Bases of Intestinal Epithelial Barrier Dysfunction in Inflammatory Bowel Disease. Inflamm Bowel Dis 2017 Oct;23(10):1718-1729. PMID: 28885228",
                                  accession = "GSE75214",
                                  description = "Mucosal biopsies from colon of 97 UC patients, 8 CD patients, 11 controls and mucosal biopsies from illeum of 67 CD patients, 11 controls",
                                  survivalA = "None",
                                  survivalB = "None")
  save(parsedGSE75214, file = "./data/datasetGSE75214.RData")
  return(NULL)
}

