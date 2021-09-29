#' Description
#'
#' @export

add_error = function(sim_data,
                     seed = 1234,
                     noise_setting = 2)
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
    s = abs(log(noise_setting))
    
    noise = matrix(rnorm(G*S, mean = 0, sd = s),
                   nrow=G,
                   ncol=S)
    
    sim_data_error = sim_data * exp(noise) 
    return(sim_data_error)
  }
}
