#' Creates list of individual Ws for each sample and expression matrix from direchlet proportions in H and scRNA-seq data
#'
#' @export


make_W <- function(data, H, total_cells) {
  # Creates expression matrix, list of Ws
  ex    = matrix(nrow = nrow(data$ex), ncol = ncol(H))
  trueW = list()
  
  # Obtains list of cell types from rownames of trueH
  types = as.vector(rownames(trueH))
  
  # for reproduceablity
  set.seed(1234)
  # For each sample
  for(i in 1:ncol(H)) {
    W = matrix(nrow = nrow(ex), ncol = nrow(H))
    # For each cell type in a sample
    for(j in 1:nrow(H)) {
      num_cells  = ceiling(H[j,i] * total_cells) # number of cells of that cell_type = proportion * total 
      cellType   = types[j] # name of cell type 
      all_ids    = which(data$sampInfo$cell_type == cellType) # obtains IDs of all cells of given cell_type
      num_cells = min(all_ids, length(num_cells)) # don't try to sample more than exists!!!
      sample_ids = sample(all_ids, num_cells) # samples num_cells cell IDs out of all cell IDs
      w_col      = rowMeans(as.matrix(data$ex[,sample_ids])) # averages! the gene expression columns for the sampled cells 
      W[,j]      = as.matrix(w_col) # adds cell_type GEP as one column in individual W  
    }
    # Rownames in W matrix = genes, colnames in W matrix = cell types
    colnames(W) = rownames(H)
    rownames(W) = rownames(data$ex)
    
    trueW[[i]] = W # adds the created individual W to list of Ws
    ex[,i] = W %*% H[,i] # creates one column in X using Xi = Wi * Hi
  }
  
  # now another set of filtering, to remove genes that have all zeros in ex from ex and all trueWs
  genes_to_keep <- rowSums(ex) > 0
  ex <- ex[genes_to_keep,]
  for(i in 1:ncol(H)) {
    trueW[[i]] <- trueW[[i]][genes_to_keep,]
  }
  # Rownames in expression matrix = genes, colnames in expression matrix = samples
  data$ex <- data$ex[genes_to_keep,]
  rownames(ex) = rownames(data$ex) 
  colnames(ex) = colnames(trueH)
  
  return(list(ex, trueW))
}