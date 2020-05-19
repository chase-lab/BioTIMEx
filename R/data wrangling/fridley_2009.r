## fridley_2009

dataset_id <- 'fridley_2009'
load(file='data/raw data/fridley_2009/ddata')

dat <- data.frame(dataset_id = rep(dataset_id, nrow(ddata)))

dat$year <- ddata$year
dat$month <- NA
dat$day <- NA

dat$site <- ddata$block
dat$block <- ddata$plot
dat$plot <- NA
dat$subplot <- NA

dat$treatment <- ddata$treatment
dat$treatment_type <- "manipulated climate"

dat$design <- paste0('A', ifelse(ddata$treatment == 'control', 'C', 'I'))

timepoints <- seq_along(unique(ddata$year))
timepoints <- paste0('T',timepoints[match(ddata$year, unique(ddata$year))])
dat$timepoint <- timepoints
dat$time_since_disturbance_days <- NA

dat$species <- ddata$species
dat$metric <- 'count'
dat$value <- ddata$contacts
dat$unit <- 'count'

dat$comment <- 'Artificial temperature increase in winter began in November 1993 (warm treatment). Artificial drought began in summer 1994. Artificial increase of water input began in summer 1994. See metadata for full setup.'

dat <- dat[!is.na(dat$value), ]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
write.csv(dat, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
