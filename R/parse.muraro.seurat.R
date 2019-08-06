# parses muraro.sueart.rds data into ex, sampInfo, featInfo, metadata

system.file("extdata", "muraro.seurat.rds", package = "rnaGinesis")
data = readRDS("./inst/extdata/muraro.seurat.rds")

parsedData <- list()
# Creates expression matrix, dimensions: genes by cells
ex <- Seurat::GetAssayData(data)
ex <- as.matrix(ex)
ex <- ex[rowSums(ex) > 150,]

parsedData$ex <- ex
parsedData$sampInfo <- data.frame(SYMBOL = colnames(parsedData$ex))
parsedData$featInfo <- data.frame(SYMBOL = rownames(parsedData$ex))
parsedData$metadata <- data@meta.data

# Creates annotation matrix with identity/cell type of each cell, dimensions: cells by cell type 
annotation <- as.matrix(data$celltype)
parsedData$sampInfo$cell_type <- annotation

data <- parsedData

save(data, file = "./data/muraro.seurat.RData")
