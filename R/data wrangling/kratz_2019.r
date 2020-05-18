## kratz_2019

dataset_id <- 'kratz_2019'
load(file='data/raw data/kratz_2019/ddata')

dat <- data.frame(dataset_id = rep(dataset_id, nrow(ddata)))
