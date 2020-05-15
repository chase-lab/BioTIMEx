## allison_2018
dataset_id <- 'allison_2018'
load(file='data/raw data/allison_2018/ddata')

dat <- data.frame(dataset_id = rep(dataset_id, nrow(ddata)))

dat$year <- format(ddata$date, "%Y")
dat$month <- format(ddata$date, "%m")
dat$day <- format(ddata$date, "%d")

dat$site <- ddata$block
dat$block <- NA
dat$plot <- ddata$treatment
dat$subplot <- ddata$subplot

dat$treatment <- paste(ddata$treatment, ddata$subplot.t, sep='_')
dat$treatment_type <- "manipulated community"

dat$design <- NA
timepoints <- seq_along(unique(ddata$date))
timepoints <- paste0('T',timepoints[match(ddata$date, unique(ddata$date))])

dat$timepoint <- timepoints
dat$time_since_disturbance_days <- NA

dat$species <- ddata$spec.code
dat$metric <- 'count'
dat$value <- ddata$count

dat <- dat[!is.na(dat$value), ]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
write.csv(dat, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
