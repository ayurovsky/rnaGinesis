# Rearranges resultW, result H to match trueW, trueH ordering

rearrange <- function(data) {
  # Obtains resultW, resultH from expN.M.result.RData
  resultW <- data$resultW
  resultH <- data$resultH
  
  # rearrange resultW, resultH to match trueW, trueH
  for(i in 1:length(resultW)) {
    rearranged <- rearrangeResult(trueH, resultH, trueW[[i]], resultW[[i]])
    resultW[[i]] <- rearranged[[1]]
    resultH <- rearranged[[2]]
  }
  
  return(list(resultW, resultH))
}