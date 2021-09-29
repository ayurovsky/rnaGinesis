#' Compare two sets of column data (automatic matching)
#'
#' @export
#' @import Metrics

evalRMSE = function(truth, observed)
{
  RMSE = sapply(1:ncol(truth), function(i) rmse(truth[,i], observed[,i]))
  return(RMSE)
}
