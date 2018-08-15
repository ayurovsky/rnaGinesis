#' Description
#'
#' @export

simulation_1 = function(num.sim, S, seed)
{
  h_RMSE = matrix(0, nrow=num.sim, ncol=4, byrow=TRUE)
  w_cos_dist = matrix(0, nrow=num.sim, ncol=4, byrow=TRUE)
  h_RMSE_1.05 = matrix(0, nrow=num.sim, ncol=4, byrow=TRUE)
  w_cos_dist_1.05 = matrix(0, nrow=num.sim, ncol=4, byrow=TRUE)
  h_RMSE_0.5 = matrix(0, nrow=num.sim, ncol=4, byrow=TRUE)
  w_cos_dist_0.5 = matrix(0, nrow=num.sim, ncol=4, byrow=TRUE)
  colnames(h_RMSE) = c("Tumor", "Stroma", "Immune", "Normal")
  colnames(w_cos_dist) = c("Tumor", "Stroma", "Immune", "Normal")
  colnames(h_RMSE_1.05) = c("Tumor", "Stroma", "Immune", "Normal")
  colnames(w_cos_dist_1.05) = c("Tumor", "Stroma", "Immune", "Normal")
  colnames(h_RMSE_0.5) = c("Tumor", "Stroma", "Immune", "Normal")
  colnames(w_cos_dist_0.5) = c("Tumor", "Stroma", "Immune", "Normal")
  seeds = rep(0, num.sim)
  for (i in 1:num.sim)
  {
    H = sim_H(S, seed+i)
    datasim = sim_data1(A_tumor, mu_tumor, H, seed+i)
    data = datasim[[1]]
    mean_W = datasim[[2]]
    data_1.05 = add_error(data, seed+i, 1.05)
    data_0.5 = add_error(data, seed+i, 0.5)
    NMF_result = NMF_analyze(data, mean_W, seed+i)
    NMF_result_1.05 = NMF_analyze(data_1.05, mean_W, seed+i)
    NMF_result_0.5 = NMF_analyze(data_0.5, mean_W, seed+i)
    h_nmf = NMF_result[[1]]
    w_nmf = NMF_result[[2]]
    h_nmf_1.05 = NMF_result_1.05[[1]]
    w_nmf_1.05 = NMF_result_1.05[[2]]
    h_nmf_0.5 = NMF_result_0.5[[1]]
    w_nmf_0.5 = NMF_result_0.5[[2]]
    h_RMSE[i,] = evalRMSE(H,h_nmf)
    w_cos_dist[i,] = evalCOSDIST(mean_W, w_nmf)
    h_RMSE_1.05[i,] = evalRMSE(H,h_nmf_1.05)
    w_cos_dist_1.05[i,] = evalCOSDIST(mean_W, w_nmf_1.05)
    h_RMSE_0.5[i,] = evalRMSE(H,h_nmf_0.5)
    w_cos_dist_0.5[i,] = evalCOSDIST(mean_W, w_nmf_0.5)
    seeds[i] = seed+i
  }
  #change the name if number of simulations changes
  filename = paste0("level1_result_", num.sim, "sim_", S, "samp_2")
  assign(filename, list(h_RMSE, w_cos_dist, h_RMSE_1.05, w_cos_dist_1.05, h_RMSE_0.5, w_cos_dist_0.5, seeds))
  save(list = filename, file=paste0(filename, ".RData"))
}
