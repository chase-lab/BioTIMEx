## mcMurdo_2018
if (FALSE) {

   dataset_id <- 'mcMurdo_2018'
   load(file=paste0('data/raw data/', dataset_id, '/ddata'))

   # First experiment <- moat
   ddata_moat <- ddata[ddata$SAMPLE_TYPE == 'moat',]
   dat <- data.frame(dataset_id = rep(paste0(dataset_id,'a'), nrow(ddata_moat)))

   dat$year <- format(ddata_moat$COLLECTION_DATE, "%Y")
   dat$month <- format(ddata_moat$COLLECTION_DATE, "%m")
   dat$day <- format(ddata_moat$COLLECTION_DATE, "%d")

   dat$site <- ddata_moat$LOCATION
   dat$block <- ddata_moat$SAMPLE_TYPE
   dat$plot <- ddata_moat$REPLICATE
   dat$subplot <- ddata_moat$DEPTH_M

   dat$treatment <- ddata_moat$TREATMENT
   dat$treatment_type <- "water level"

   dat$design <- paste0(
      ifelse(ddata_moat$TIMEPOINT == 'T0', 'B', 'A'),
      ifelse(ddata_moat$TREATMENT == 'control', 'C', 'I')
   )

   dat$timepoint <- ddata_moat$TIMEPOINT
   dat$time_since_disturbance_days <- as.numeric(ddata_moat$COLLECTION_DATE - as.Date(ddata_moat$COLLECTION_DATE[1]))

   dat$realm <- 'freshwater'
   dat$taxon <- 'plankton'
   dat$species <- ddata_moat$spec.code
   dat$metric <- 'count'
   dat$value <- ddata_moat$count
   dat$unit <- 'count'

   dat$comment <- 'Two experiments in one. In "moat" treatment, samples are moved up (5m to surface). In "water column treatment", sampled are moved 3 meter deeper.'


   dat <- dat[!is.na(dat$value), ]

   # dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
   # write.csv(dat, paste0('data/wrangled data/', dataset_id, "/", dataset_id, 'a.csv'),
   #           row.names=FALSE)

}
