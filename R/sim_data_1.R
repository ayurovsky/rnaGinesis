#'  Helper function that:
#'  use a single mixture and a set of mvn params 
#'  to simulate a single mixed sample
#'
#' @export
#' @import mvnfast


sim_data_1 = function(h.i, mean, chol)
{
  z_tumor  = rmvn(1, mean[,1], chol[[1]], isChol=TRUE)
  z_stroma = rmvn(1, mean[,2], chol[[2]], isChol=TRUE)
  z_immune = rmvn(1, mean[,3], chol[[3]], isChol=TRUE)
  z_normal = rmvn(1, mean[,4], chol[[4]], isChol=TRUE)
  
  tumor = as.matrix(exp(z_tumor))
  stroma = as.matrix(exp(z_stroma))
  immune = as.matrix(exp(z_immune))
  normal = as.matrix(exp(z_normal))
  
  W = t(rbind(tumor, stroma, immune, normal))
  
  return(W %*% h.i)
}
