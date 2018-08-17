#' Compare two sets of column data (automatic matching)
#'
#' @export
#' @import Metrics

evalRMSE = function(truth, observed)
{
  RMSE = c(rmse(truth[,1], observed[,1]),
           rmse(truth[,2], observed[,2]),
           rmse(truth[,3], observed[,3]),
           rmse(truth[,4], observed[,4]))
  return(RMSE)
}
