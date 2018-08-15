#' Description
#'
#' @export

sortMu = function(mu, A, scaleFactor = 0)
{
  G = length(mu)
  
  O = order(mu)
  Musorted = mu[O]
  Asorted = A[O, O]
  
  L = 1:G
  Lnew = order(L + runif(G, 0, 1)*scaleFactor)
  
  JiggledMuSorted = Musorted[Lnew]
  JiggledASorted = Asorted[Lnew, Lnew]
  
  return(list(JiggledMuSorted, JiggledASorted))
}
