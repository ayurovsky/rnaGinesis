#' Rearranges resultW, result H to match trueW, trueH ordering
#'
#' @export


rearrange <- function(data, experiment) {
  # Obtains resultW, resultH from expN.M.result.RData
  resultW <- data$resultW
  resultH <- data$resultH
  
  trueW <- experiment$trueW
  trueH <- experiment$trueH
  

  num_factors <- ncol(resultW[[1]])
  possible.perms <- gtools::permutations(num_factors, num_factors)
  sum_of_rmses <- numeric(num_factors)
  sum_of_cors <- numeric(num_factors)
 
  for(i in 1:length(resultW)) { # for each sample adds the errors for each permutation
    sum_of_rmses <- sum_of_rmses + apply(X = possible.perms, 1,
                     FUN=tot.rmse, h_exp = trueH, h_obs = resultH, i=i)
    sum_of_cors <- sum_of_cors + apply(X = possible.perms, 1,
                    FUN=tot.cor, w_exp = trueW[[i]], w_obs = resultW[[i]])
  }
  # combined results per permutation of correlation and rmse
  combined_results <- sum_of_cors*sum_of_rmses
  best = possible.perms[which(combined_results==min(combined_results)),]
  # break ties
  if (!is.null(nrow(best))) {
    best = best[1,]
  } 
  # now re-arrange for a single best permutation across all samples
  resultH <- resultH[best,]
  for(i in 1:length(resultW)) {
    resultW[[i]] <- resultW[[i]][,best]
  }
  
  return(list(resultW=resultW,
              resultH=resultH))
}