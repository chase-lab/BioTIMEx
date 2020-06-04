## foster_2009


dataset_id <- 'foster_2009'
load(file='data/raw data/foster_2009/ddata')

dat <- data.frame(dataset_id = rep(dataset_id, nrow(ddata)))

dat$year <- ddata$year
dat$month <- NA
dat$day <- NA

dat$site <- 'Harvard Forest'
dat$block <- ddata$plot
dat$plot <- NA
dat$subplot <- NA

dat$treatment <- 'logged'
dat$treatment_type <- "logging"

dat$design <- 'AI'

timepoints <- seq_along(unique(ddata$year))
timepoints <- paste0('T',timepoints[match(ddata$year, unique(ddata$year))])
dat$timepoint <- timepoints
dat$time_since_disturbance_days <- NA

dat$realm <- 'terrestrial'
dat$taxon <- 'plants'

load('data/raw data/foster_2009/ddata_species')
species_matching <- ddata_species[match(ddata$species, ddata_species$code), "species"]
dat$species <- ifelse(is.na(species_matching), ddata$species, species_matching)
dat$metric <- 'density'
dat$value <- ddata$count
dat$unit <- 'stems per hectare'

dat$comment <- 'Tree counting changes with time, see methods.'

dat <- dat[!is.na(dat$value) & dat$value > 0 , ]

# dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
# write.csv(dat, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
#           row.names=FALSE)

