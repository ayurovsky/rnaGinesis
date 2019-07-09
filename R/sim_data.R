#' Take in a single mu and A, and a mixture matrix H
#' Return mixed expression (after exponentiation)
#'
#' @export


sim_data = function(mu_tumor = 101-(1:100),
                    A_tumor = 1:100 %*% t(1:100),
                    H = sim_H(),
                    scaleFactor = rep(10,3),
                    seed = 1234)
{
  if (length(scaleFactor)!=(nrow(H)-1))
  {
    stop("Error: parameters don't match in length")
  }
  numTypes = nrow(H)
  
  # for each sample's mixture matrix
  # ... and a set of mvn params
  # ... simulate mixed expression
  data = apply(H, 2, sim_data_1, mu, A, seed)
  
  return(list(data, exp(mu)))
}
