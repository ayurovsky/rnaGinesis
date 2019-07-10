#' generate_data_set_list
#'
#' @export

generate_data_set_list <- function() {
   data_set_list <- data.frame(labels=c("GSE19830","GSE97284","GSE127472", "GSE127471","GSE127813"),
                               variablenames =c("parsedGSE19830","parsedGSE97284","parsedGSE127472", "parsedGSE127471","parsedGSE127813"))
   save(list = c("data_set_list"),
        file = "./data/data_set_list.RData")
   return(NULL)
   
}