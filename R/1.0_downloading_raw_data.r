# Downloading raw data

if(!dir.exists('data/raw data/'))   dir.create('data/raw data/')
listF <- list.files('./R/data download', pattern = ".R|.r", full.names = TRUE)
lapply(listF, function(fullPath) source(fullPath, encoding = 'UTF-8', echo = FALSE, local = TRUE))
