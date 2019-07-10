#' Description
#'
#' @export

Complete_simulation = function(A_tumor,
                               mu_tumor,
                               Samplesize  = 100,
                               scaleFactor = rep(10, 3),
                               d.params    = c("Tumor"   = .3,
                                               "Stromal" = .5,
                                               "Immune"  = .1,
                                               "Normal"  = .1),
                               noise_setting = 2,
                               seed = 1234 )
{
  H = sim_H(S        = Samplesize,
            seed     = seed, 
            d.params = d.params)
  
  datasim = sim_data(mu_tumor    = mu_tumor,
                     A_tumor     = A_tumor,
                     H           = H,
                     scaleFactor = scaleFactor,
                     seed        = seed)
  data = datasim[[1]]
  W    = datasim[[2]]
  
  data = add_error(sim_data      = data,
                   seed          = seed,
                   noise_setting = noise_setting)
  return(list(data,W,H))
}

