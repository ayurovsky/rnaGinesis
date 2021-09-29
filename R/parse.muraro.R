# un-comment when necessary
#nBiocManager::install("scRNAseq")
#library(scRNAseq)
#sceM <- MuraroPancreasData()

#ex <- counts(sceM)
#ex <- as.matrix(ex)

# remove the samples with NA cell type
#ex <- ex[,which(!is.na(sceM$label))]

# remove low-expressed rows AFTER filtering for NA samples
#ex <- ex[rowSums(ex) > 150,]

#parsedData <- list()
#parsedData$ex <- ex
#parsedData$sampInfo <- data.frame(SYMBOL = colnames(parsedData$ex))
#parsedData$featInfo <- data.frame(SYMBOL = rownames(parsedData$ex))

#parsedData$metadata$cell_type <- as.matrix(sceM$label)[which(!is.na(sceM$label)),]

#parsedData$sampInfo$cell_type <- as.matrix(sceM$label)[which(!is.na(sceM$label)),]

#data <- parsedData

#save(data, file = "./data/muraro.RData") 
