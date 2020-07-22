# Wrangle raw data

if(!dir.exists('data/wrangled data/'))   dir.create('data/wrangled data/')
listF <- list.files('R/data wrangling', pattern = ".R|.r", full.names = TRUE)
lapply(listF, function(fullPath) source(fullPath, encoding = 'UTF-8', echo = FALSE, local = TRUE))
