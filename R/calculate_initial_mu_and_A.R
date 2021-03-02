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
  
  # average expression top 5000 genes - very different values....
  # avg and sd of mu_0 and m completely different
  # mean(mu) = 11.65 sd(mu) = 1.48
  # mean(mu_0) = 7.57. sd(mu_0) = 0.75
  mu_0 <- rowMeans(E_top)
  # TWO ORDERS OF MAGNITUDE DIFF when exponentiate!!!!
  
  # now get the covariance matrix of top 5000 genes
  sigma_0 <- cov(t(E_top))
  
  # Error in chol.default(sigma_0) : 
  # the leading minor of order 150 is not positive definite
  # but running with pivot is not the answer!!!! - warnings, then the returned matrix is not sig = A t(A), also, rows and cols re-ordered
  # and when re-order using pivot information, gene order returned, but the matrix is not upper triangular
  #  Warning message when running with pivot=TRUE:
  #In chol.default(sigma_0, pivot = TRUE) :
  #   the matrix is either rank-deficient or indefinite
  # https://stackoverflow.com/questions/43121059/correct-use-of-pivot-in-cholesky-decomposition-of-positive-semi-definite-matrix
  #A_0 <- chol(sigma_0, TRUE)
  # all.equal(crossprod(unpivA_0), sigma_0)
  # [1] "Attributes: < Component “dimnames”: Component 1: 287 string mismatches >"
  # [2] "Attributes: < Component “dimnames”: Component 2: 287 string mismatches >"
  # [3] "Mean relative difference: 0.3385224" 
  #r <- attr(A_0, 'rank')
  #if (r < nrow(sigma_0)) A_0[(r+1):nrow(sigma_0), (r+1):nrow(sigma_0)] <- 0
  #oo <- order(attr(A_0, 'pivot'))
  #unpivA_0 <- A_0[, oo]
  #all.equal(crossprod(unpivA_0), sigma_0)
  # do the Cholesky decomposition to get the upper triangular matrix A - chokes!!!
  
  # symmetric - equal to traspose
  # positive definite all eigen values are positive; positive-semidefinite = eigen values are non-zero
  # rank - number of linearly independent columns of matrix
  
  sigma_0 = sigma_0 + diag(5000)/1000000
  A_0 <- chol(sigma_0) # , pivot=TRUE) # -
 
  # check means - not equal for A_0 and A:
  #sum(A_0)/2500
  #sum(A)/2500

  # double-check that the sigma is equal to A time transpose of A
  all.equal(crossprod(A_0), sigma_0)
  
  return(list(mu_0, A_0))
}