## battles_2015

dataset_id <- 'battles_2015'
load(file='data/raw data/battles_2015/ddata')

dat <- data.frame(dataset_id = rep(dataset_id, nrow(ddata)))

dat$year <- ddata$year
dat$month <- NA
dat$day <- NA

dat$site <- 'Hubbard Brook Watershed 5'

zones <- c('ridge_top_spruce/fir_forest', 'east_side_spruce/fir_forest', 'high_elevation_hardwoods', 'middle_elevation_hardwoods', 'low_elevation_hardwoods')
dat$block <- zones[match(ddata$Zone, 1:5)]
dat$plot <- ddata$Plot
dat$subplot <- NA

dat$treatment <- 'logging'


dat$treatment_type <- 'logging'

dat$design <- 'AI'

timepoints <- seq_along(unique(ddata$year))
timepoints <- paste0('T',timepoints[match(ddata$year, unique(ddata$year))])
dat$timepoint <- timepoints

dat$time_since_disturbance_days <- ddata$year - 1983


dat$realm <- 'terrestrial'
dat$taxon <- 'plants'

dat$species <- ddata$Species
dat$metric <- 'density'
#species_counts <- aggregate(Species ~ Plot, data = ddata, table)
#reshape2::melt(species_counts, grep(x=colnames(species_counts), 'Species'))

# Before running, the following changes have to be made
#  - exclude dead trees
#  - count individuals only once even if they have several stems



dat$value <- ddata$n
dat$unit <- 'ind per m2'

dat$comment <- 'The blocks represent pre-logging vegetation and are not necessarily meaningful any more. They can be pooled together. Meaning of species codes is found here: https://portal.edirepository.org/nis/metadataviewer?packageid=knb-lter-hbr.39.7'

dat <- dat[!is.na(dat$value) & dat$value > 0, ]

# dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
# write.csv(dat, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
#           row.names=FALSE)

