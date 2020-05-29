## reed_2020a
library(data.table)

dataset_id <- 'reed_2020a'
load(file='data/raw data/reed_2020a/ddata')
setDT(ddata)

dat <- ddata[COUNT > 0, .(value = sum(COUNT)/sum(AREA)), keyby= .(site=SITE, year=YEAR,  treatment=TREATMENT,  species=SCIENTIFIC_NAME)]
# Is the standardization correct? or does it devide only by area were each species was observed?

dat[, design := 'AI'][treatment == 'control', design := 'AC']

timepoints <- seq_along(unique(dat$year))
timepoints <- paste0('T',timepoints[match(dat$year, unique(dat$year))])

dat[treatment == 'control', "time_since_disturbance_years" := year - min(year), by = site]
dat[, ':='(dataset_id = dataset_id,
           # block = NA,
           # plot = NA,
           # subplot = NA,
           treatment = tolower( dat$treatment),
           treatment_type = 'kelp removal',
           timepoints = timepoints,
           realm = 'marine',
           taxon = 'fish',
           metric = 'density',
           unit = 'ind per m2',
           comment = 'Cryptic and Mobile surveys pooled. Multiple annual surveys pooled into one with total abundances standardized by total sampled area.')]


dat <- dat[!is.na(dat$value), ]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
write.csv(dat, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
