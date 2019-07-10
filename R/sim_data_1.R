#'  Helper function that:
#'  use a single mixture and a set of mvn params 
#'  to simulate a single mixed sample
#'
#' @export
#' @import mvnfast


sim_data_1 = function(h.i, mean, chol,seed = 1234)
{
  if (length(h.i)!=ncol(mean))
  {
    stop("Number of tissue types do not match for cell-specific proportions and gene expression")
  }
    
  numTypes = length(h.i)
  
  if (numTypes<2)
      stop("Must have at least two tissue types")
  if (numTypes>10)
      stop("Too many tissue types: maximum of ten types")
  
  set.seed(seed)

  if (numTypes >= 2)
  {
    z_1 = as.matrix(rmvn(1, mean[,1], chol[[1]], isChol=TRUE))
    z_2 = as.matrix(rmvn(1, mean[,2], chol[[2]], isChol=TRUE))
    if (numTypes==2)
      {
         W = t(rbind(z_1, z_2))
      }
  }
  if (numTypes >= 3)
  {
    z_3 = as.matrix(rmvn(1, mean[,3], chol[[3]], isChol=TRUE))
    if (numTypes==3)
      {
        W = t(rbind(z_1, z_2, z_3))
      }
  }
  if (numTypes >= 4)
  {
    z_4 = as.matrix(rmvn(1, mean[,4], chol[[4]], isChol=TRUE))
    if (numTypes==4)
      {
        W = t(rbind(z_1, z_2, z_3, z_4))
      }
  }
  if (numTypes >= 5)
  {
    z_5 = as.matrix(rmvn(1, mean[,5], chol[[5]], isChol=TRUE))
    if (numTypes==5)
      {
        W = t(rbind(z_1, z_2, z_3, z_4, z_5))
      }
  }
  if (numTypes >= 6)
  {
    z_6 = as.matrix(rmvn(1, mean[,6], chol[[6]], isChol=TRUE))
    if (numTypes==6)
      {
        W = t(rbind(z_1, z_2, z_3, z_4, z_5, z_6))
      }
  }
  if (numTypes >= 7)
  {
    z_7 = as.matrix(rmvn(1, mean[,7], chol[[7]], isChol=TRUE))
    if (numTypes==7)
      {
        W = t(rbind(z_1, z_2, z_3, z_4, z_5, z_6, z_7))
      }
  }
  if (numTypes >= 8)
  {
    z_8 = as.matrix(rmvn(1, mean[,8], chol[[8]], isChol=TRUE))
    if (numTypes==8)
      {
        W = t(rbind(z_1, z_2, z_3, z_4, z_5, z_6, z_7, z_8))
      }
  }
  if (numTypes >= 9)
  {
    z_9 = as.matrix(rmvn(1, mean[,9], chol[[9]], isChol=TRUE))
    if (numTypes==9)
      {
        W = t(rbind(z_1, z_2, z_3, z_4, z_5, z_6, z_7, z_8, z_9))
      }
  }
  if (numTypes >= 10)
  {
    z_10 = as.matrix(rmvn(1, mean[,10], chol[[10]], isChol=TRUE))
    if (numTypes==10)
      {
        W = t(rbind(z_1, z_2, z_3, z_4, z_5, z_6, z_7, z_8, z_9, z_10))
      }
  }
 
  
  W = exp(W)
  return(W %*% h.i)
}
