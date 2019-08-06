# Finds the cosine distance between all individual true Ws and all individual result Ws

evalW.COSDIST <- function(trueW, resultW) {
  # Makes column with cos distance of each true W and result W matrices in all samples
  cosdist <- matrix(nrow = length(trueW))
  
  # For every sample
  for(i in 1:length(trueW)) {
    # Sums cosdist between true and estimated for each cell type to get overall cosdist for sample
    cosdist[i,1] <- mean(evalCOSDIST(trueW[[i]], resultW[[i]]))
  }
  
  return(cosdist)
}