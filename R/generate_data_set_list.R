#' generate_data_set_list
#'
#' @export

generate_data_set_list <- function() {
   data_set_list <- data.frame(labels=c("GSE19830","GSE1","GSE1", "GSE1","GSE1", "GSE1","GSE1"),
                               variablenames =c("parsedGSE19830","GSE1","GSE1", "GSE1","GSE1", "GSE1", "GSE1"))
   save(list = c("data_set_list"),
        file = "./data/data_set_list.RData")
   return(NULL)
}