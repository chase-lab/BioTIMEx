## carpenter_2017
dataset_id <- 'carpenter_2017'
load(file='data/raw data/carpenter_2017/ddata')

dat <- data.frame(dataset_id = rep(dataset_id, nrow(ddata)))

dat$year <- ddata$year4
dat$month <- format(ddata$sampledate, "%m")
dat$day <- format(ddata$sampledate, "%d")

dat$site <- ddata$lakename
dat$block <- ddata$lakeid
dat$plot <- NA
dat$subplot <- NA

dat$treatment <- NA
dat$treatment_type <- "eutrophication"

dat$design <- paste0('A', ifelse(ddata$subplot.t == 'control', 'C', 'I'))

timepoints <- seq_along(unique(ddata$sampledate))
timepoints <- paste0('T',timepoints[match(ddata$sampledate, unique(ddata$sampledate))])
dat$timepoint <- timepoints
dat$time_since_disturbance_days <- NA

dat$realm <- 'freshwater'
dat$taxon <- 'phytoplankton'
dat$species <- paste(ddata$genus, ddata$species, ddata$description, sep=' ')
dat$metric <- 'concentration'
dat$value <- ddata$concentration
dat$unit <- NA

dat$comment <- 'Samples from 1991 to 1995 were counted by the same person hence ensuring comparable counts. 2013 to 2015 should have consistent sampling and counting too.'

dat <- dat[!is.na(dat$value), ]

if(FALSE) {
   dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
   write.csv(dat, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
}
