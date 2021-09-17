#' Description
#'
#' @export

tot.rmse = function(o, h_exp, h_obs, i)
{
  tot = rmse(h_exp[,i], h_obs[o,i])
  return(tot)
}
