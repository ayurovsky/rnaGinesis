if (!require("Metrics")) {
   install.packages("Metrics", dependencies = TRUE, repos="http://cran.rstudio.com/")
}
if (!require("NMF")) {
   install.packages("NMF", dependencies = TRUE, repos="http://cran.rstudio.com/")
}
if (!require("gtools")) {
   install.packages("gtools", dependencies = TRUE, repos="http://cran.rstudio.com/")
}
if (!require("mvnfast")) {
   install.packages("mvnfast", dependencies = TRUE, repos="http://cran.rstudio.com/")
}
if (!require("reshape")) {
   install.packages("mvnfast", dependencies = TRUE, repos="http://cran.rstudio.com/")
}

# ===============================
#          Bioconductor
# ===============================
if (!require("BiocManager")) {
   install.packages("BiocManager")
}
if (!require("GEOquery")) {
   BiocManager::install("GEOquery")
}
if (!require("DeMixT")) {
  BiocManager::install("DeMixT")
}