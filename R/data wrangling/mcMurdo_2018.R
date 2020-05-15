## mcMurdo_2018

dataset_id <- 'mcMurdo_2018'
load(file=paste0('data/raw data/', dataset_id, '/ddata'))

dat <- data.frame(dataset_id = rep(dataset_id, nrow(ddata)))

dat$year <- format(ddata$COLLECTION_DATE, "%Y")
dat$month <- format(ddata$COLLECTION_DATE, "%m")
dat$day <- format(ddata$COLLECTION_DATE, "%d")

dat$site <- ddata$LOCATION
dat$block <- ddata$SAMPLE_TYPE
dat$plot <- ddata$REPLICATE
dat$subplot <- ddata$DEPTH_M

dat$treatment <- ifelse(ddata$TREATMENT == 'control', 'control',
                        paste(ddata$TREATMENT, ddata$DEPTH, sep='_')
)
dat$treatment_type <- "water level"

dat$design
ifelse()
dat$timepoint <- ddata$TIMEPOINT
dat$time_since_disturbance_days
aggregate(COLLECTION_DATE ~ REPLICATE + SAMPLE_TYPE + DEPTH_M + TIMEPOINT + TREATMENT, data = ddata, c)




dat$species <- ddata$spec.code
dat$metric <- 'count'
dat$value <- ddata$count




dat <- dat[!is.na(dat$value), ]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
write.csv(dat, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
