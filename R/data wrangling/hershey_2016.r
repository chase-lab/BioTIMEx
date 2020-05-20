## hershey_2016

dataset_id <- 'hershey_2016'
load(file=paste0('data/raw data/',dataset_id, '/ddata'))

# reshaping the data
ddata <- reshape2::melt(ddata,
               measure.vars = c('RHYAC','BRACHY','NATARSIA','ORTHO','OTHCHIR','CHIPUPA','BLACK','BLKPUPA','BAETIS','BAETSP3','EPHEM','CINYG','NEMOURA','TIPULA','SNAILS'),
               variable.name = 'species',
               value.name = 'count')

dat <- data.frame(dataset_id = rep(dataset_id, nrow(ddata)))

ddata$Date <- as.Date(ddata$Date, format = '%d-%b-%y')
dat$year <- format(ddata$Date, "%Y")
dat$month <- format(ddata$Date, "%m")
dat$day <- format(ddata$Date, "%d")

dat$site <- ddata$Site
dat$block <- ddata$Stream.Type
dat$plot <- ddata$Trial
dat$subplot <- NA


station <- as.numeric(trimws(gsub(x=ddata$station.m, pattern='K|k', replacement='')))
station <- ifelse(abs(station) < 10, station * 1000, station)
dat$treatment <- paste(ifelse(station < 0, 'control', 'impact'), station, sep='_')
dat$treatment_type <- "eutrophication"

dat$design <- paste0('A', ifelse(station < 0, 'C', 'I'))

timepoints <- seq_along(unique(ddata$Date))
timepoints <- paste0('T',timepoints[match(ddata$Date, unique(ddata$Date))])
dat$timepoint <- timepoints
dat$time_since_disturbance_days <- NA

dat$realm <- 'freshwater'
dat$taxon <- 'invertebrates'
dat$species <- ddata$species
dat$metric <- 'count'
dat$value <- ddata$count
dat$unit <- 'count'

dat$comment <- 'Treatment variable shows the distance above (negative values) and downstream (positive values) of a nutrient source.'

dat <- dat[!is.na(dat$value) & dat$value != 0, ]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
write.csv(dat, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
