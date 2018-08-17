#' Description
#'
#' @export

simulate_and_test = function(A_tumor,
                             mu_tumor,
                             num.sim = 20,
                             Samplesize  = 100,
                             scaleFactor = 10,
                             d.params    = c("Tumor"   = .3,
                                             "Stromal" = .5,
                                             "Immune"  = .1,
                                             "Normal"  = .1),
                             noise_setting = 2,
                             seed          = 1234 )
{
  h_RMSE = matrix(0,
                  nrow=num.sim,
                  ncol=4,
                  byrow=TRUE)
  w_cos_dist = matrix(0,
                      nrow=num.sim,
                      ncol=4,
                      byrow=TRUE)
  
  colnames(h_RMSE) = c("Tumor", "Stroma", "Immune", "Normal")
  colnames(w_cos_dist) = c("Tumor", "Stroma", "Immune", "Normal")
  
  for (i in 1:num.sim)
  {
    writeLines("---------------")
    writeLines(paste("iteration",i))
    writeLines(paste("Samplesize",Samplesize))
    writeLines(paste("scaleFactor",scaleFactor))
    writeLines(paste("noise_setting",noise_setting))
    
    simresult <- Complete_simulation(A_tumor,
                                     mu_tumor,
                                     Samplesize    = Samplesize,
                                     scaleFactor   = scaleFactor,
                                     d.params      = d.params,
                                     noise_setting = noise_setting,
                                     seed          = seed + i)
    data   <- simresult[[1]]
    mean_W <- simresult[[2]]
    H      <- simresult[[3]]
    
    NMF_result = NMF_analyze(data,
                             mean_W,
                             seed + i)
    h_nmf = NMF_result[[2]]
    w_nmf = NMF_result[[1]]
    
    h_RMSE[i,]     = evalRMSE(H,h_nmf)
    w_cos_dist[i,] = evalCOSDIST(mean_W, w_nmf)
  }
  return(list(h_RMSE,w_cos_dist))
}
