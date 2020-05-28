## ellison_2017a
# correct typos in subs

dataset_id <- 'ellison_2017a'
load(file='data/raw data/ellison_2017a/ddata')

dat <- data.frame(dataset_id = rep(dataset_id, nrow(ddata)))

dat$year <- ddata$year
dat$month <- ddata$month
dat$day <- ddata$day

dat$site <- ddata$site
dat$block <- ddata$cham
dat$plot <- toupper (ddata$subs)
dat$subplot <- NA         # SPLIT WINKLER AND PITFALLS


warming_table <- na.omit(unique(ddata[, c('site','cham','warming','target.delta')]))
warming_table$warming <- gsub(warming_table$warming, pattern = ' c| C', replacement = '_c')

dat$treatment <- ifelse(
   ddata$site == 'HF',
   paste(warming_table[warming_table$site == 'HF',][match(ddata$cham, warming_table[warming_table$site == 'HF', 'cham']), "warming"],
         warming_table[warming_table$site == 'HF',][match(ddata$cham, warming_table[warming_table$site == 'HF', 'cham']), "target.delta"], sep = '_'),
   ifelse(
      ddata$site == 'DF',
      paste(warming_table[warming_table$site == 'DF',][match(ddata$cham, warming_table[warming_table$site == 'DF', 'cham']), "warming"],
            warming_table[warming_table$site == 'DF',][match(ddata$cham, warming_table[warming_table$site == 'DF', 'cham']), "target.delta"], sep = '_'),
      NA)
)


dat$treatment_type <- 'warming'

dat$design <- paste0(ifelse(ddata$treat == 'Pre-treat', 'B', "A"),
                     ifelse(grepl(dat$treatment, pattern = 'control'), 'C', "I"))

timepoints <- seq_along(unique(ddata$date))
timepoints <- paste0('T',timepoints[match(ddata$date, unique(ddata$date))])
dat$timepoint <- timepoints
fdd <- aggregate(date ~ cham + site, data = ddata, FUN=min, subset = ddata$treat == 'Treat') # first_disturbance_date
dat$time_since_disturbance_days <- ifelse(ddata$treat == 'Pre-treat',
                                          NA,
                                          ifelse(ddata$site == 'HF',
                                                 as.numeric(ddata$date - fdd[fdd$site == 'HF',][match(ddata$cham, fdd[fdd$site == 'HF', 'cham']), 'date']),
                                                 ifelse(ddata$site == 'DF',
                                                        as.numeric(ddata$date - fdd[fdd$site == 'DF',][match(ddata$cham, fdd[fdd$site == 'DF', 'cham']), 'date']),
                                                        NA)
                                          )
)


dat$realm <- 'terrestrial'
dat$taxon <- 'invertebrates'

dat$species <- paste(ddata$genus, ddata$species)
dat$metric <- 'count'
dat$value <- ddata$n
dat$unit <- 'count'

dat$comment <- 'Block design with treatments being ,no chamber, a chamber without warming, a chamber and warming with different warming intensities. Two sampling methods: pitfall traps and Winkler samples.'

dat <- dat[!is.na(dat$value), ]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
write.csv(dat, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)

