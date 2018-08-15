#' Description
#'
#' @export



add_error = function(sim_data, seed, noise_setting)
{
  if (noise_setting==0)
  {
    return (sim_data)
  }
  else
  {
    set.seed(seed)
    G = nrow(sim_data)
    S = ncol(sim_data)
    noise = matrix(0, nrow=G, ncol=S)
    s = abs(log(noise_setting))
    for (i in 1:S)
    {
      noise[,i] = rnorm(G, mean = 0, sd = s)
    }
    sim_data_error = sim_data * exp(noise) 
    return(sim_data_error)
  }
}
