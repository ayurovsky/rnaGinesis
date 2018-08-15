#' Description
#'
#' @export



sim_W_data = function(A_tumor, seed)
{
  set.seed(seed)
  #rm(A)
  order_s = rank(runif(ncol(A_tumor), 0, 1))
  A_stroma = A_tumor[order_s, order_s]
  order_i = rank(runif(ncol(A_tumor), 0, 1))
  A_immune = A_tumor[order_i, order_i]
  order_n = rank(runif(ncol(A_tumor), 0, 1))
  A_normal = A_tumor[order_n, order_n]
  
  z_tumor = rmvn(1, mu_tumor, A_tumor, isChol=TRUE)
  mu_stroma = mu_tumor[order_s]
  z_stroma = rmvn(1, mu_stroma, A_stroma, isChol=TRUE)
  mu_immune = mu_tumor[order_i]
  z_immune = rmvn(1, mu_immune, A_immune, isChol=TRUE)
  mu_normal = mu_tumor[order_n]
  z_normal = rmvn(1, mu_normal, A_normal, isChol=TRUE)
  
  mu = cbind(mu_tumor, mu_stroma, mu_immune, mu_normal)
  mu = exp(mu)
  
  tumor = as.matrix(exp(z_tumor))
  stroma = as.matrix(exp(z_stroma))
  immune = as.matrix(exp(z_immune))
  normal = as.matrix(exp(z_normal))
  W = t(rbind(tumor, stroma, immune, normal))
  colnames(W) = c("Tumor", "Stromal", "Immune", "Normal")
  rownames(W) = paste0("gene_", 1:ncol(A_tumor))
  rm(A_immune,A_normal,A_stroma)
  rm(tumor, stroma, immune, normal)
  rm(z_tumor, z_immune, z_stroma, z_normal)
  return(list(W, mu))
}
