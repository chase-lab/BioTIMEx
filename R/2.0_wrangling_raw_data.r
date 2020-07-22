# Wrangle raw data
#tb::executeAll(fullPath = 'R/data wrangling', echo=FALSE)


listF <- list.files('R/data wrangling', pattern = ".R|.r", full.names = TRUE)
lapply(listF, function(fullPath) source(fullPath, encoding = 'UTF-8', echo = FALSE, local = TRUE))
