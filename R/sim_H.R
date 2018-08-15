#' Description
#'
#' @export

sim_H = function(S,
                 seed = 1234, 
                 d.params = c("Tumor" = .3,
                              "Stromal" =.5,
                              "Immune" = .1,
                              "Normal" = .1))
{
  set.seed(seed)
  H = t(rdirichlet(S,d.params))
  rownames(H) = names(d.params)
  colnames(H) = paste0("sample_", 1:S)
  return(H)
}
