# Calculates RMSE over each column in trueH and each column in resultH, returns column of RMSE over each sample

evalH.RMSE <- function(trueH, resultH) {
  rmse <- matrix(nrow = ncol(trueH))
  for(i in 1:ncol(trueH)) {
    rmse[i,1] <- rmse(trueH[,i],resultH[,i])
  }
  return(rmse)
}
