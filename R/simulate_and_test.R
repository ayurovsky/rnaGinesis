#' Description
#'
#' @export
#' @import gtools

simulate_and_test = function(A_tumor,
                             mu_tumor,
                             num.sim     = 20,
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
                  ncol=length(d.params),
                  byrow=TRUE)
  w_cos_dist = matrix(0,
                      nrow=num.sim,
                      ncol=length(d.params),
                      byrow=TRUE)
  w_RMSE = matrix(0,
                  nrow=num.sim,
                  ncol=length(d.params),
                  byrow=TRUE)
  h_cos_dist = matrix(0,
                      nrow=num.sim,
                      ncol=length(d.params),
                      byrow=TRUE)
  
  colnames(h_RMSE) = names(d.params)
  colnames(w_cos_dist) = names(d.params)
  colnames(w_RMSE) = names(d.params)
  colnames(w_cos_dist) = names(d.params)
  
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
    W      <- simresult[[2]]
    H      <- simresult[[3]]
    
    NMF_result = NMF_analyze(data,
                             rank = length(d.params),
                             seed + i)
    h_nmf = NMF_result[[2]]
    w_nmf = NMF_result[[1]]
    
    # globally rearrange NMF results to match truth
    possible.perms = permutations(4, 4, c(1, 2, 3, 4))
    cor_orders = apply(X = possible.perms, 1,
                       FUN=tot.cor, w_exp = W, w_obs = w_nmf)
    #plot(sort(cor_orders))
    best = possible.perms[which(cor_orders==max(cor_orders)),]
    w_nmf = w_nmf[,best]
    h_nmf = h_nmf[best,]
    
    colnames(w_nmf) <- names(d.params)
    row.names(h_nmf) <- names(d.params)
    
    #print(H[1:4,1:4])
    #print(h_nmf[1:4,1:4])
    #print(W[1:4,1:4])
    #print(w_nmf[1:4,1:4])
    
    h_RMSE[i,] = evalRMSE(t(H),t(h_nmf))
    w_RMSE[i,] = evalRMSE(W, w_nmf)
    w_cos_dist[i,] = evalCOSDIST(W, w_nmf)
    h_cos_dist[i,] = evalCOSDIST(t(H),t(h_nmf))
  }
  return(list(h_RMSE,
              w_RMSE,
              h_cos_dist,
              w_cos_dist))
}
