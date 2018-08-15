#' Description
#'
#' @export



sim_data1 = function(A_tumor, mu_tumor, H, seed)
{
  set.seed(seed)
  order_s = rank(runif(ncol(A_tumor), 0, 1))
  mu_stroma = mu_tumor[order_s]
  A_stroma = A_tumor[order_s, order_s]
  order_i = rank(runif(ncol(A_tumor), 0, 1))
  mu_immune = mu_tumor[order_i]
  A_immune = A_tumor[order_i, order_i]
  order_n = rank(runif(ncol(A_tumor), 0, 1))
  mu_normal = mu_tumor[order_n]
  A_normal = A_tumor[order_n, order_n]
  mu = cbind(mu_tumor, mu_stroma, mu_immune, mu_normal)
  A = list(A_tumor, A_stroma, A_immune, A_normal)
  data = apply(H, 2, sim_data_1, mu, A)
  return(list(data, exp(mu)))
}
