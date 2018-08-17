#' Take in a single Mu and A
#' Return a single adjusted Mu and A
#' 
#' @export

sortMu = function(mu = 101-(1:100),
                  A = 1:100 %*% t(1:100),
                  scaleFactor = 10,
                  seed = 1234,
                  verbose = TRUE)
{
  set.seed(seed)
  G = length(mu)
  
  O = order(mu)
  Musorted = mu[O]
  Asorted = A[O, O]
  
  L = 1:G
  Lnew = order(L + runif(G, 0, 1)*(scaleFactor+0.99))
  
  JiggledMuSorted = Musorted[Lnew]
  JiggledASorted = Asorted[Lnew, Lnew]
  
  
  Jiggledmu <- mu
  JiggledA  <- A
  
  Jiggledmu[O] <- JiggledMuSorted
  JiggledA[O,O]  <- JiggledASorted
  
  
  if(verbose){
    plot(mu,Jiggledmu)
  }
  
  return(list(Jiggledmu, JiggledA))
}
