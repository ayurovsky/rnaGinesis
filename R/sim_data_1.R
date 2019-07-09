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
  
  set.seed(seed)
  numTypes = length(h.i)
  if (numTypes == 2)
  {
    W = sim_2type(mean, chol)
  }
  else if (numTypes == 3)
  {
    W = sim_3type(mean, chol)
  }
  else if (numTypes == 4)
  {
    W = sim_4type(mean, chol)
  }
  else if (numTypes == 5)
  {
    W = sim_5type(mean, chol)
  }
  else if (numTypes == 6)
  {
    W = sim_6type(mean, chol)
  }
  else if (numTypes == 7)
  {
    W = sim_7type(mean, chol)
  }
  else if (numTypes == 8)
  {
    W = sim_8type(mean, chol)
  }
  else if (numTypes == 9)
  {
    W = sim_9type(mean, chol)
  }
  else if (numTypes == 10)
  {
    W = sim_10type(mean, chol)
  }
  else
  {
    if (numTypes<2)
      stop("Must have at least two tissue types")
    else
      stop("Too many tissue types: maximum of ten types")
  }
  
  return(W %*% h.i)
}
