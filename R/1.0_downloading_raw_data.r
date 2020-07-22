# Downloading raw data
# tb::executeAll(fullPath = 'R/data download', echo=F)

listF <- list.files('./R/data download', pattern = ".R|.r", full.names = TRUE)
lapply(listF, function(fullPath) source(fullPath, encoding = 'UTF-8', echo = FALSE, local = TRUE))

