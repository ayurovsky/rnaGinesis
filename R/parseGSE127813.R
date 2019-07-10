#-----------------------------GSE127813--------------------------------------

parseGSE127813 <- function() {
  library(GEOquery)
  library(Matrix)
  library(readr)
  
  parsedGSE127813 <- read.table("./inst/extdata/GSE127813_Whole_blood_gene_expression_matrix.txt")
  parsedGSE127813$metadata <- list(log.transformed = FALSE,
                                   reference = "Newman AM, Steen CB, Liu CL, Gentles AJ et al. Determining cell type abundance and expression from bulk tissues with digital cytometry. Nat Biotechnol 2019 Jul;37(7):773-782. PMID: 31061481",
                                   accession = "GSE127813",
                                   description = "12 whole blood samples from healthy adult",
                                   survivalA = "None",
                                   survivalB = "None"
                                  )
  save(parsedGSE127813, file = "./data/datasetGSE127813.RData")
  return(NULL)
}

