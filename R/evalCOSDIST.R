#' Description
#'
#' @export



evalCOSDIST = function(truth_mean, observed)
{
  cor_identified = cor(truth_mean, observed)
  cos_dist = (1-diag(cor_identified))/2
  names(cos_dist) = c("Tumor", "Stroma", "Immune", "Normal")
  return(cos_dist)
}
