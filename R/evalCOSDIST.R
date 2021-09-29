#' Compare two sets of column data (automatic matching)
#'
#' @export

evalCOSDIST = function(truth, observed)
{
  cor_identified = cor(truth, observed)
  cos_dist = (1-diag(cor_identified))/2
  return(cos_dist)
}
