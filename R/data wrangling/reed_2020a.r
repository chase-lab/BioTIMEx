## reed_2020a


dataset_id <- 'reed_2020a'
load(file='data/raw data/reed_2020a/ddata')

# keeping only useful rows
ddata <- ddata[ddata$COUNT >0, ]

dat <- data.frame(dataset_id = rep(dataset_id, nrow(ddata)))

dat$year <- ddata$YEAR
dat$month <- ddata$MONTH
dat$day <- format(ddata$DATE, format = '%d')

dat$site <- ddata$SITE
dat$block <- ddata$TREATMENT
dat$plot <- ddata$TRANSECT
dat$subplot <- NA



dat$treatment <- ifelse(ddata$TREATMENT == 'CONTROL', 'control',
                        ifelse(grepl(ddata$TREATMENT, pattern = 'ANNUAL'), 'annual',
                               ifelse(grepl(ddata$TREATMENT, pattern = 'CONTINUAL'), 'continual', NA)))

dat$treatment_type <- 'kelp removal'

dat$design <- paste0('A', ifelse(ddata$TREATMENT == 'CONTROL', 'C', "I"))

timepoints <- seq_along(unique(ddata$DATE))
timepoints <- paste0('T',timepoints[match(ddata$DATE, unique(ddata$DATE))])
dat$timepoint <- timepoints
dat$time_since_disturbance_days <- ifelse(ddata$TREATMENT == 'CONTROL', NA,
                                          as.numeric(ddata$DATE - as.Date(min(ddata$DATE)))
)


dat$realm <- 'marine'
dat$taxon <- 'fish'

dat$species <- ddata$SCIENTIFIC_NAME
dat$metric <- 'count'
dat$value <- ddata$COUNT
dat$unit <- 'count'

dat$comment <- 'Two half studies making one together? cryptic study is focused on a subset of species (probably exhaustive in most cases).'

dat <- dat[!is.na(dat$value), ]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
write.csv(dat, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
