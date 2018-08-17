#' Take in a single mu and A, and a mixture matrix H
#' Return mixed expression
#'
#' @export


sim_data = function(mu_tumor = 101-(1:100),
                    A_tumor = 1:100 %*% t(1:100),
                    H = sim_H(),
                    scaleFactor = 10,
                    seed = 1234)
{
  stroma_info = sortMu(mu = mu_tumor,
                       A = A_tumor,
                       scaleFactor = scaleFactor,
                       seed = seed+1)
  
  immune_info = sortMu(mu = mu_tumor,
                       A = A_tumor,
                       scaleFactor = scaleFactor,
                       seed = seed+2)
  
  normal_info = sortMu(mu = mu_tumor,
                       A = A_tumor,
                       scaleFactor = scaleFactor,
                       seed = seed+3)
  
  mu_stroma = stroma_info[[1]]
  A_stroma = stroma_info[[2]]
  mu_immune = immune_info[[1]]
  A_immune = immune_info[[2]]
  mu_normal = normal_info[[1]]
  A_normal = normal_info[[2]]
  
  mu = cbind(mu_tumor,
             mu_stroma,
             mu_immune,
             mu_normal)
  
  A = list(A_tumor,
           A_stroma,
           A_immune,
           A_normal)
  
  # for each sample's mixture matrix
  # ... and a set of mvn params
  # ... simulate mixed expression
  data = apply(H, 2, sim_data_1, mu, A)
  
  return(list(data, exp(mu)))
}
