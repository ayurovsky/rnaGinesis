# Finds the cosine distance between all individual true Ws and all individual result Ws

makeW_COSDIST <- function(trueW, resultW.NMF, resultW.CIBERSORT) {
  # For every sample
  W.COSDIST <- matrix(nrow = ncol(trueH))
  
  # Calculates RMSE values across all samples for NMF and appends as column to H.RMSE
  cosdist.W.NMF <- evalW.COSDIST(trueW,resultW.NMF)
  W.COSDIST[,1] <- cosdist.W.NMF
  
  # Calculates RMSE values across all samples for DeMixT and appends as column to H.RMSE
  #cosdist.W.DeMixT <- evalW.COSDIST(trueW,resultW.DeMixT)
  #W.COSDIST <- cbind(W.COSDIST, cosdist.W.DeMixT)
  
  # Calculates RMSE values across all samples for CIBERSORT and appends as column to H.RMSE
  cosdist.W.CIBERSORT <- evalW.COSDIST(trueW,resultW.CIBERSORT)
  W.COSDIST <- cbind(W.COSDIST, cosdist.W.CIBERSORT)
  
  colnames(W.COSDIST) <- c("NMF", "CIBERSORT")
  
  return(W.COSDIST)
}