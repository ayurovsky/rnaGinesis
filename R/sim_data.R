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
  
  if (numTypes<2)
      stop("Must have at least two tissue types")
  if (numTypes>10)
      stop("Too many tissue types: maximum of ten types")
  
  
  
  if (numTypes>=2)
  {
    tissue2_info = sortMu(mu = mu_tumor,
                       A = A_tumor,
                       scaleFactor = scaleFactor[1],
                       seed = seed+1)
    mu_tissue2 = tissue2_info[[1]]
    A_tissue2 = tissue2_info[[2]]
    mu = cbind(mu_tumor, 
                mu_tissue2)
    A = list(A_tumor,
           A_tissue2)
  }
  if (numTypes>=3)
  {
    tissue3_info = sortMu(mu = mu_tumor,
                       A = A_tumor,
                       scaleFactor = scaleFactor[2],
                       seed = seed+2)
    mu_tissue3 = tissue3_info[[1]]
    A_tissue3 = tissue3_info[[2]]
    mu = cbind(mu,
               mu_tissue3)
    A[[3]] = A_tissue3
  }
  if (numTypes>=4)
  {
    tissue4_info = sortMu(mu = mu_tumor,
                       A = A_tumor,
                       scaleFactor = scaleFactor[3],
                       seed = seed+3)
    mu_tissue4 = tissue4_info[[1]]
    A_tissue4 = tissue4_info[[2]]
    mu = cbind(mu,
               mu_tissue4)
    A[[4]] = A_tissue4
  }
  if (numTypes>=5)
  {
    tissue5_info = sortMu(mu = mu_tumor,
                       A = A_tumor,
                       scaleFactor = scaleFactor[4],
                       seed = seed+4)
    mu_tissue5 = tissue5_info[[1]]
    A_tissue5 = tissue5_info[[2]]
    mu = cbind(mu,
               mu_tissue5)
    A[[5]] = A_tissue5
  }
  if (numTypes>=6)
  {
    tissue6_info = sortMu(mu = mu_tumor,
                       A = A_tumor,
                       scaleFactor = scaleFactor[5],
                       seed = seed+5)
    mu_tissue6 = tissue6_info[[1]]
    A_tissue6 = tissue6_info[[2]]
    mu = cbind(mu,
               mu_tissue6)
    A[[6]] = A_tissue6
  }
  if (numTypes>=7)
  {
    tissue7_info = sortMu(mu = mu_tumor,
                       A = A_tumor,
                       scaleFactor = scaleFactor[6],
                       seed = seed+6)
    mu_tissue7 = tissue7_info[[1]]
    A_tissue7 = tissue7_info[[2]]
    mu = cbind(mu,
               mu_tissue7)
    A[[7]] = A_tissue7
  }
  if (numTypes>=8)
  {
    tissue8_info = sortMu(mu = mu_tumor,
                       A = A_tumor,
                       scaleFactor = scaleFactor[7],
                       seed = seed+7)
    mu_tissue8 = tissue8_info[[1]]
    A_tissue8 = tissue8_info[[2]]
    mu = cbind(mu,
               mu_tissue8)
    A[[8]] = A_tissue8
  }
  if (numTypes>=9)
  {
    tissue9_info = sortMu(mu = mu_tumor,
                       A = A_tumor,
                       scaleFactor = scaleFactor[8],
                       seed = seed+8)
    mu_tissue9 = tissue9_info[[1]]
    A_tissue9 = tissue9_info[[2]]
    mu = cbind(mu,
               mu_tissue9)
    A[[9]] = A_tissue9
  }
  if (numTypes==10)
  {
    tissue10_info = sortMu(mu = mu_tumor,
                       A = A_tumor,
                       scaleFactor = scaleFactor[9],
                       seed = seed+9)
    mu_tissue10 = tissue10_info[[1]]
    A_tissue10 = tissue10_info[[2]]
    mu = cbind(mu,
               mu_tissue10)
    A[[10]] = A_tissue10
  }
  
  # for each sample's mixture matrix
  # ... and a set of mvn params
  # ... simulate mixed expression
  data = apply(H, 2, sim_data_1, mu, A, seed)
  
  return(list(data, exp(mu)))
}
