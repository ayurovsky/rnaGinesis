#' Description
#'
#' @export

sim_W_data = function(mu_tumor,A_tumor, seed = 1234)
{
  set.seed(seed)
  
  z_tumor = rmvn(1, mu_tumor, A_tumor, isChol=TRUE)
  
  order_s = rank(runif(ncol(A_tumor), 0, 1))
  A_stroma = A_tumor[order_s, order_s]
  mu_stroma = mu_tumor[order_s]
  z_stroma = rmvn(1, mu_stroma, A_stroma, isChol=TRUE)
  
  order_i = rank(runif(ncol(A_tumor), 0, 1))
  A_immune = A_tumor[order_i, order_i]
  mu_immune = mu_tumor[order_i]
  z_immune = rmvn(1, mu_immune, A_immune, isChol=TRUE)
  
  order_n = rank(runif(ncol(A_tumor), 0, 1))
  A_normal = A_tumor[order_n, order_n]
  mu_normal = mu_tumor[order_n]
  z_normal = rmvn(1, mu_normal, A_normal, isChol=TRUE)
  
  # save 4 mus for this sample
  mu = cbind(mu_tumor, mu_stroma, mu_immune, mu_normal)
  mu = exp(mu)
  
  # construct W for this sample
  tumor  = as.matrix(exp(z_tumor))
  stroma = as.matrix(exp(z_stroma))
  immune = as.matrix(exp(z_immune))
  normal = as.matrix(exp(z_normal))
  
  W = t(rbind(tumor, stroma, immune, normal))
  colnames(W) = c("Tumor", "Stromal", "Immune", "Normal")
  rownames(W) = paste0("gene_", 1:ncol(A_tumor))

  return(list(W, mu))
}
