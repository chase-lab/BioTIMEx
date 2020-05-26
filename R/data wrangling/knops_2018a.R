## knops_2018a


dataset_id <- 'knops_2018a'
load(file='data/raw data/knops_2018a/ddata')

dat <- data.frame(dataset_id = rep(dataset_id, nrow(ddata)))

dat$year <- format(ddata$Date, format = '%Y')
dat$month <- format(ddata$Date, format = '%m')
dat$day <- format(ddata$Date, format = '%d')

dat$site <- ddata$Location
dat$block <- ddata$Plot
dat$plot <- NA
dat$subplot <- NA



dat$treatment <- paste0(
   ifelse(ddata$Exclosure == 'y', 'Ex', ''),
   ifelse(ddata$Fertilized == 'y', 'Fe', ''),
   ifelse(ddata$Burned == 'y', 'Bu', '')
)
dat$treatment[nchar(dat$treatment) == 0] <- 'control'

dat$treatment_type <- 'kelp removal'

dat$design <- paste0('A', ifelse(dat$treatment == 'control', 'C', "I"))

timepoints <- seq_along(unique(ddata$Date))
timepoints <- paste0('T',timepoints[match(ddata$Date, unique(ddata$Date))])
dat$timepoint <- timepoints
dat$time_since_disturbance_days <- ifelse(dat$treatment == 'control', NA,
                                          as.numeric(ddata$Date - as.Date('2000/01/01'))
)


dat$realm <- 'terrestrial'
dat$taxon <- 'invertebrates'

dat$species <- paste(ddata$Genus, ddata$Specific.epithet)
dat$metric <- 'count'
dat$value <- ddata$nSpecimens
dat$unit <- 'count'

dat$comment <- 'Block design with treatments being Ex (Exclosure meaning no grazing), Fe (fertilization) and Bu (burning every other year). Life stage is also given (sometimes) so subadults could be excluded hence diminishing greatly the number of undeterminate species.'

dat <- dat[!is.na(dat$value), ]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
write.csv(dat, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
