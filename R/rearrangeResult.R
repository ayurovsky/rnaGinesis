# Helper method to rearrange results to match truths

rearrangeResult <- function(trueH, resultH, trueW, resultW) {
  # globally rearrange NMF results to match truth
  possible.perms = gtools::permutations(ncol(resultW), ncol(resultW))
  cor_orders = apply(X = possible.perms, 1,
                     FUN=tot.cor, w_exp = trueW, w_obs = resultW)
  
  #plot(sort(cor_orders))
  best = possible.perms[which(cor_orders==max(cor_orders)),]
  resultW = resultW[,best]
  resultH = resultH[best,]
  
  return(list(resultW,resultH))
}