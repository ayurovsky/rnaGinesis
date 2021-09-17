#' Helper method to rearrange results to match truths
#'
#' @export

rearrangeResult <- function(trueH, resultH, trueW, resultW, i) {
  # globally rearrange NMF results to match truth
  possible.perms = gtools::permutations(ncol(resultW), ncol(resultW))
  cor_res = apply(X = possible.perms, 1,
                     FUN=tot.cor, w_exp = trueW, w_obs = resultW)
  rmse_res = apply(X = possible.perms, 1,
                     FUN=tot.rmse, h_exp = trueH, h_obs = resultH, i=i)
  # combined results per permutation of correlation and rmse
  combined_results <- cor_res/rmse_res
  best = possible.perms[which(combined_results==max(combined_results)),]
  # break ties
  if (!is.null(nrow(best))) {
    best = best[1,]
  }  
  resultW = resultW[,best]
  resultH = resultH[best,]
  
  return(list(resultW,resultH))
}