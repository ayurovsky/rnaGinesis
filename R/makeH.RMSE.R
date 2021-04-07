# Returns H.RMSE matrix with RMSE between true propos and estimated props across all samples for each deconvolution method 
#' @export
#' 
makeH.RMSE <- function(trueH, resultH.Method1, resultH.Method2, method1Name="NMF", method2Name="CIBERSORT") {
  # For every sample
  H.RMSE <- matrix(nrow = ncol(trueH))
  
  # Calculates RMSE values across all samples for Method1 and appends as column to H.RMSE
  rmse.H.Method1 <- evalH.RMSE(trueH,resultH.Method1)
  H.RMSE[,1] <- rmse.H.Method1
  
  # Calculates RMSE values across all samples for DeMixT and appends as column to H.RMSE
  #rmse.H.DeMixT <- evalH.RMSE(trueH,resultH.DeMixT) 
  #H.RMSE <- cbind(H.RMSE,rmse.H.DeMixT)
  
  # Calculates RMSE values across all samples for Method2 and appends as column to H.RMSE
  rmse.H.Method2 <- evalH.RMSE(trueH,resultH.Method2) 
  H.RMSE <- cbind(H.RMSE,rmse.H.Method2)
  
  colnames(H.RMSE) <- c(method1Name, method2Name)
  
  return(H.RMSE)
}
