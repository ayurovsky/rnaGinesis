#' Description
#'
#' @export

sim_H = function(S, seed)
{
  set.seed(seed)
  #k = 4
  #S = 1000
  H = t(rdirichlet(S, c(.3, .5, .1, .1)))
  rownames(H) = c("Tumor", "Stromal", "Immune", "Normal")
  colnames(H) = paste0("sample_", 1:S)
  #ggpairs(as.data.frame(t(H)), 1:4)
  return(H)
}
