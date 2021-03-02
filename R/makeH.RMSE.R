# Returns H.RMSE matrix with RMSE between true propos and estimated props across all samples for each deconvolution method 
#' @export
#' 
makeH.RMSE <- function(trueH, resultH.NMF, resultH.CIBERSORT) {
  # For every sample
  H.RMSE <- matrix(nrow = ncol(trueH))
  
  # Calculates RMSE values across all samples for NMF and appends as column to H.RMSE
  rmse.H.NMF <- evalH.RMSE(trueH,resultH.NMF)
  H.RMSE[,1] <- rmse.H.NMF
  
  # Calculates RMSE values across all samples for DeMixT and appends as column to H.RMSE
  #rmse.H.DeMixT <- evalH.RMSE(trueH,resultH.DeMixT) 
  #H.RMSE <- cbind(H.RMSE,rmse.H.DeMixT)
  
  # Calculates RMSE values across all samples for CIBERSORT and appends as column to H.RMSE
  rmse.H.CIBERSORT <- evalH.RMSE(trueH,resultH.CIBERSORT) 
  H.RMSE <- cbind(H.RMSE,rmse.H.CIBERSORT)
  
  colnames(H.RMSE) <- c("NMF","CIBERSORT")
  
  return(H.RMSE)
}
