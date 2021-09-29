#'  Calculate Initial Mu and A
#'  Helper function that, 
#'  given an expression matrix
#'  calculates mu_0 and A_0
#'  for the simulator:
#'  
#'
#' \code{calculate_initial_mu_and_A} will take in a custom expression matrix, or use the TCGA_PAAD expression data to calculate initial mu and A
#'
#' @param E A custom expression matrix to use;  if not passed in, TCGA_PAAD data will be used
#'
#' 
#' @return A list containing mu_0 and A_0
#'
#' @export
#' 

calculate_initial_mu_and_A <- function(E = matrix(ncol=0,nrow=0)) 
{
  if (length(E) == 0) {
    print("Using TCGA_PAAD to generate initial mu and A.")
    data("TCGA_PAAD")
    # get whitelist samples (150) and gene names (20531)
    E <- as.matrix(TCGA_PAAD$ex)
    # rownames(E) <- as.vector(TCGA_PAAD$featInfo$SYMBOL)
    E <- E[,TCGA_PAAD$sampInfo$Decision == "whitelist"]
  }
  
  # remove all genes with 0 expression
  E_non_zero <- E[apply(E,1,function(X) min(X)>0 ),]
  
  # selecting the highest expressing 5000 genes
  E_high <- E_non_zero[order(rowSums(E_non_zero), decreasing = TRUE),]
  
  # top 5000 genes
  E_top <- E_high[1:5000,]
  
  # take the log of the expressions!!! (exp later)
  E_top = log(E_top)
  
  # average expression top 5000 genes 
  mu_0 <- rowMeans(E_top)
  
  # now get the covariance matrix of top 5000 genes
  sigma_0 <- cov(t(E_top))
  
  sigma_0 = sigma_0 + diag(5000)/1000000
  A_0 <- chol(sigma_0)

  # double-check that the sigma is equal to A time transpose of A
  all.equal(crossprod(A_0), sigma_0)
  
  return(list(mu_0, A_0))
}