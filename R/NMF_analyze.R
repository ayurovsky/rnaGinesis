#' Description
#'
#' @export
#' @import NMF

NMF_analyze = function(data,
                       rank = 4,
                       seed = 1234)
{
  result = nmf(x    = data,
               rank = 4,
               seed = seed)
  w = basis(result)
  h = coef(result)
  
  # normalize columns of learned W
  median_w = apply(w, 2, median)
  lambda = 100/median_w
  B = diag(lambda)
  B.inv = diag(1/lambda)
  w_new = w %*% B
  h_new = B.inv %*% h
  
  # normalize to have H colSums close to 1
  h_sums <- colSums(h_new)
  mean_sum <- mean(h_sums)
  w <- w_new * mean_sum
  h <- h_new / mean_sum
  
  return (list(w,h))
}
