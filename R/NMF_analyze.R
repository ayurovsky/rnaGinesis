#' Description
#'
#' @export




NMF_analyze = function(data, W, seed)
{
  #ptm = proc.time()
  result = nmf(x=data, rank=4, seed = seed)
  #proc.time()-ptm
  w = basis(result)
  h = coef(result)
  median_w = apply(w, 2, median)
  lambda = 100/median_w
  B = diag(lambda)
  B.inv = diag(1/lambda)
  w_new = w %*% B
  h_new = B.inv %*% h
  h_new_sum1 = apply(h_new, 2, sum_to_1)
  o = order(apply(h_new_sum1, 1, mean), decreasing=TRUE)
  h_new_sum1 = h_new_sum1[c(o[2], o[1], o[3:4]),]
  
  #sort w to maximize correlation
  # maxcor = 0
  # order = c(1,2,3,4)
  possible.perms = permutations(4, 4, c(1, 2, 3, 4))
  cor_orders = apply(X = possible.perms, 1, FUN=tot.cor, w_exp = W, w_obs = w_new)
  best = possible.perms[which(cor_orders==max(cor_orders)),]
  w_new_sorted = w_new[,best]
  return (list(h_new_sum1, w_new_sorted))
}
