#' Description
#'
#' @export

tot.cor = function(o, w_exp, w_obs)
{
  tot = sum(evalCOSDIST(w_exp, w_obs[,o]))
  return(tot)
}
