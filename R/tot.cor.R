#' Description
#'
#' @export

tot.cor = function(o, w_exp, w_obs)
{
  cor = cor(w_exp, w_obs[,o])
  tot = sum(diag(cor))
  return(tot)
}
