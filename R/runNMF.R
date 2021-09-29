#' Runs NMF on mixture data and obtains result W, result H
#' 
#' @export
#' @import NMF


runNMF <- function(mixture, rank) {
  # library(NMF)
  
  # Runs NMF on mixture data, normalizes results
  nmf_result <- NMF_analyze(data = mixture, rank = rank)
  
  # Obtains W and H matrices from NMF, W = genes by cell-types, H = cell-types by samples
  resultW <- nmf_result[[1]]
  resultH <- nmf_result[[2]]
  
  # Creates list of Ws for every sample (for NMF, all Ws are the same)
  resultW <- lapply(seq_len(ncol(resultH)), function(X) resultW)
  
  # Saves results to list
  exp.NMF <- list()
  exp.NMF$resultW <- resultW
  exp.NMF$resultH <- resultH
  
  return(exp.NMF)
}