## ellison_2017a
# correct typos in subs, method

dataset_id <- 'ellison_2017a'
load(file='data/raw data/ellison_2017a/ddata')

dat <- data.frame(dataset_id = rep(dataset_id, nrow(ddata)))

dat$year <- ddata$year
dat$month <- ddata$month
dat$day <- ddata$day

dat$site <- ddata$site
dat$block <- ddata$cham
dat$plot <- ddata$subs
dat$subplot <- NA


warming_table <- na.omit(unique(ddata[, c('site','cham','warming','target.delta')]))
warming <- ifelse(
   ddata$site == 'HF',
   warming_table[match(ddata$cham, warming_table[warming_table$site == 'HF', 'cham']), c("warming",'target.delta')],
   ifelse(
      ddata$site == 'DF',
      warming_table[match(ddata$cham, warming_table[warming_table$site == 'DF', 'cham']), c("warming",'target.delta')],
      NA)
)
faire la meme chose pour ddata$warming ou alors faire les deux a la fois dans le ifelse

dat$treatment <-

#
# ifelse()
# ( & ddata$cham %in% c(4, 6, 11, 14, 15)) |
#    (ddata$site == 'DF' & ddata$cham %in% c(2, 5, 11, 14, 15)) , )

dat$treatment_type <- 'kelp removal'

dat$design <- paste0(ifelse(ddata$treat == 'Pre-treat', 'B', "A"),
                     ifelse(ddata$warning == 'Heated', 'I', "C"))

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

