#' Description
#'
#' @export


sim_data = function(A_tumor, mu_tumor, H, seed)
{
  set.seed(seed)
  o = order(mu_tumor)
  mu_tumor = mu_tumor[o]
  A_tumor = A_tumor[o,o]
  stroma_info = sortMu(mu_tumor, A_tumor, 2)
  immune_info = sortMu(mu_tumor, A_tumor, 2)
  normal_info = sortMu(mu_tumor, A_tumor, 2)
  mu_stroma = stroma_info[[1]]
  A_stroma = stroma_info[[2]]
  mu_immune = immune_info[[1]]
  A_immune = immune_info[[2]]
  mu_normal = normal_info[[1]]
  A_normal = normal_info[[2]]
  mu = cbind(mu_tumor, mu_stroma, mu_immune, mu_normal)
  A = list(A_tumor, A_stroma, A_immune, A_normal)
  data = apply(H, 2, sim_data_1, mu, A)
  return(list(data, exp(mu)))
}
