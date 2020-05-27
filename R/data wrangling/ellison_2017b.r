## ellison_2017b
# correct typos in subs, method

dataset_id <- 'ellison_2017b'
load(file='data/raw data/ellison_2017b/ddata')

dat <- data.frame(dataset_id = rep(dataset_id, nrow(ddata)))

dat$year <- format(ddata$date, '%Y')
dat$month <- format(ddata$date, '%m')
dat$day <- format(ddata$date, '%d')

dat$site <- 'HF'
dat$block <- ddata$cham
dat$plot <- ddata$subs
dat$subplot <- NA


warming_table <- unique(ddata[ddata$treat !='pre-treat', c('cham','treat','warming')])
warming_table$treat <- gsub(' ', '_', warming_table$treat)
warming_table$treat <- gsub('chamberless', 'chamberless_cont', warming_table$treat)

dat$treatment <- paste0(warming_table[match(ddata$cham, warming_table$cham), "treat"],
                       ifelse(is.na(warming_table[match(ddata$cham, warming_table$cham), "warming"]), '',
         paste0('_', warming_table[match(ddata$cham, warming_table$cham), "warming"]))
         )


dat$treatment_type <- 'warming'

dat$design <- paste0(ifelse(ddata$treat == 'pre-treat', 'B', "A"),
                     ifelse(grepl(dat$treatment, pattern = 'cham'), 'C', "I"))

timepoints <- seq_along(unique(ddata$date))
timepoints <- paste0('T',timepoints[match(ddata$date, unique(ddata$date))])
dat$timepoint <- timepoints
fdd <- aggregate(date ~ cham, data = ddata, FUN=min, subset = ddata$treat == 'heated') # first_disturbance_date
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

dat$species <- ifelse(is.na(ddata$species),
                      paste0(ddata$genus, '.sp.'),
                      as.character(ddata$species))
dat$metric <- 'count'
dat$value <- ddata$n
dat$unit <- 'count'

dat$comment <- 'Block design with treatments being ,no chamber, a chamber without warming, a chamber and warming with different warming intensities. Two sampling methods: pitfall traps and wrinklers.'

dat <- dat[!is.na(dat$value) & dat$value > 0, ]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
write.csv(dat, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)

