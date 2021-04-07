# Finds the cosine distance between all individual true Ws and all individual result Ws
#' @export
#'

makeW_COSDIST <- function(trueW, resultW.Method1, resultW.Method2, method1Name="NMF", method2Name="CIBERSORT") {
  # For every sample
  W.COSDIST <- matrix(nrow = ncol(trueH))
  
  # Calculates RMSE values across all samples for Method1 and appends as column to H.RMSE
  cosdist.W.Method1 <- evalW.COSDIST(trueW,resultW.Method1)
  W.COSDIST[,1] <- cosdist.W.Method1
  
  # Calculates RMSE values across all samples for DeMixT and appends as column to H.RMSE
  #cosdist.W.DeMixT <- evalW.COSDIST(trueW,resultW.DeMixT)
  #W.COSDIST <- cbind(W.COSDIST, cosdist.W.DeMixT)
  
  # Calculates RMSE values across all samples for Method2 and appends as column to H.RMSE
  cosdist.W.Method2 <- evalW.COSDIST(trueW,resultW.Method2)
  W.COSDIST <- cbind(W.COSDIST, cosdist.W.Method2)
  
  colnames(W.COSDIST) <- c(method1Name, method2Name)
  
  return(W.COSDIST)
}