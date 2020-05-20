## joern_2019

dataset_id <- 'joern_2019'
load(file='data/raw data/joern_2019/ddata')

dat <- data.frame(dataset_id = rep(dataset_id, nrow(ddata)))

dat$year <- ddata$RecYear
dat$month <- ddata$RecMonth
dat$day <- ddata$RecDay

dat$site <- toupper( ddata$Watershed )
dat$block <- toupper( substr(ddata$Watershed, 4, 4) )
dat$plot <- tolower( ddata$Repsite )
dat$subplot <- NA

grazing <- ifelse(substr(ddata$Watershed, 1, 1) %in% c('n','N'), 'Grazing', '')
fire_treatment <- tolower( substr(ddata$Watershed, 2, 3) )

dat$treatment <- paste0(grazing, ifelse(grazing == '', '', '_'), fire_treatment)
dat$treatment_type <- "fire and grazing"

dat$design <- paste0('A', ifelse(grazing == '' & fire_treatment == '00', 'C', 'I'))

ddata$Date <- as.Date(paste(ddata$RecYear, ddata$RecMonth, ddata$RecDay, sep = '-'))
timepoints <- seq_along(unique(ddata$Date))
timepoints <- paste0('T',timepoints[match(ddata$Date, unique(ddata$Date))])
dat$timepoint <- timepoints


load('data/raw data/joern_2019/ddata_env')
fd <- fd[nchar(fd$Watershed) <= 4,]

# N4D -> N04D
pattern <- "(^[A-Za-z]){1}([0-9]){1}([A-Za-z]){1}$"
replacement <- "\\10\\2\\3"
fd$Watershed <- gsub(pattern, replacement, fd$Watershed)
# 1B -> 001B
fd$Watershed <- toupper( paste0(
   sapply(max(nchar(fd$Watershed))-nchar(fd$Watershed), function(x) paste(rep(x = 0, times = x), collapse="")),
   fd$Watershed
) )
ddata$Watershed <- toupper( ddata$Watershed )

fd <- fd[fd$Watershed %in% ddata$Watershed, ]

dat$time_since_disturbance_days <- rep(NA, nrow(dat))
for (i in 1:nrow(ddata))  {
   last_fire_date <- max(fd[fd$Watershed == ddata$Watershed[i] & fd$Date <=ddata$Date[i], 'Date'])
   dat$time_since_disturbance_days[i] <- as.numeric( ddata$Date[i] - last_fire_date )
}
dat[is.infinite(dat$time_since_disturbance_days),'time_since_disturbance_days'] <- NA


dat$realm <- 'terrestrial'
dat$taxon <- 'invertebrates'
dat$species <- ddata$Species
dat$metric <- 'count'
dat$value <- ddata$Total
dat$unit <- 'count'

dat$comment <- 'Grasshopper sampling in fields burnt at various frequencies. Some fields are also grazed.'

dat <- dat[!is.na(dat$value), ]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
write.csv(dat, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
