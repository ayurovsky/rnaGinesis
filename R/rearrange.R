#' Rearranges resultW, result H to match trueW, trueH ordering
#'
#' @export


rearrange <- function(data, experiment) {
  # Obtains resultW, resultH from expN.M.result.RData
  resultW <- data$resultW
  resultH <- data$resultH
  
  trueW <- experiment$trueW
  trueH <- experiment$trueH
  
  # rearrange resultW, resultH to match trueW, trueH
  for(i in 1:length(resultW)) { # for each sample
    rearranged <- rearrangeResult(trueH, resultH, trueW[[i]], resultW[[i]])
    resultW[[i]] <- rearranged[[1]]
    resultH[,i] <- rearranged[[2]][,i]
  }
  
  return(list(resultW=resultW,
              resultH=resultH))
}