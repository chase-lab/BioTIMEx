## carpenter_2016
dataset_id <- 'carpenter_2016'
load(file='data/raw data/carpenter_2016/ddata')

# Exclusion of lakes with unknown disturbance history
ddata <- ddata[!ddata$lakename %in% c('Ward Lake','Hummingbird Lake'),]

dat <- data.frame(dataset_id = rep(dataset_id, nrow(ddata)))

dat$year <- ddata$year4
dat$month <- format(ddata$sampledate, "%m")
dat$day <- format(ddata$sampledate, "%d")

dat$site <- ddata$lakename
dat$block <- ddata$lakeid
dat$plot <- NA
dat$subplot <- NA

dat$treatment <- ifelse(ddata$lakename %in% c("Paul Lake", 'Crampton Lake'), 'control',
                        ifelse(ddata$lakename %in% c('East Long Lake', 'West Long Lake'), 'eutrophication',
                               ifelse(ddata$lakename %in% c('Peter Lake','Tuesday Lake'), 'community manipulation', NA)
                        )
)
dat$treatment_type <- 'eutrophication + fish community manipulation'

beforeafter <- ifelse(ddata$lakename %in% c("Paul Lake", 'Crampton Lake'), '',
                      ifelse(
                         (ddata$lakename %in% c('East Long Lake', 'West Long Lake') & ddata$year4 < 1991)  |
                            (ddata$lakename %in% c('Peter Lake','Tuesday Lake') & ddata$year4 < 1985), 'B', 'A')
)
controlimpact <- ifelse(ddata$lakename %in% c("Paul Lake", 'Crampton Lake'), 'C', 'I')
dat$design <- paste0(beforeafter, controlimpact)

timepoints <- seq_along(unique(ddata$sampledate))
timepoints <- paste0('T',timepoints[match(ddata$sampledate, unique(ddata$sampledate))])
dat$timepoint <- timepoints
dat$time_since_disturbance_days <- ifelse(ddata$lakename %in% c('East Long Lake', 'West Long Lake') & beforeafter == 'A',
                                          as.numeric(ddata$sampledate - as.Date('1991-05-01', format = '%Y-%m-%d')),
                                          ifelse(ddata$lakename %in% c('Peter Lake','Tuesday Lake') & beforeafter == 'A',
                                                 as.numeric(ddata$sampledate - as.Date('1985-01-01', format = '%Y-%m-%d')), NA)
)

dat$realm <- 'freshwater'
dat$taxon <- 'zooplankton'
dat$species <- ddata$taxon_name
dat$metric <- 'standardised count'
dat$value <- ddata$abundance
dat$unit <- 'count'

dat$comment <- 'Time since disturbance is the difference between sampledate and the FIRST disturbance. Most manipulations are reported in ./supporting litterature/Carpenter - Table 1 - Synthesis of a 33 year-series of whole lake experiments - lol2.10094.pdf'


dat <- dat[!is.na(dat$value), ]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
write.csv(dat, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
