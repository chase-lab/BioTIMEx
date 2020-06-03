## joern_2019
library(data.table)


dataset_id <- 'joern_2019'
load(file='data/raw data/joern_2019/ddata')
setDT(ddata)

# re remplacer watershed by site

setnames(ddata, old = c('RecYear', 'Species'),
         new = c('year', 'species'))

ddata[, ':='(
   grazing = ifelse(substr(Watershed, 1, 1) %in% c('n','N'), 'Grazing', 'noGrazing'),
   fire_treatment = ifelse(substr(Watershed, 2, 3) == '00',
                            'noFire',
                            paste0('fire', toupper( substr(Watershed, 2, 3) ))),
   site = substr(Watershed, 1, 3),
   Watershed = toupper(Watershed),
   treatment_type = "fire and grazing",
   timepoints = paste0('T',seq_along(unique(year))[match(year, unique(year))])
)][,
   ':='(
      treatment = paste(grazing, fire_treatment, sep = '_'),
      design = paste0('A', ifelse(grazing == '' & fire_treatment == '00', 'C', 'I'))
   )]

# Disturbance calendar
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

fd <- fd[fd$Watershed %in% ddata$Watershed, ]




time_since_disturbance <- rep(NA, nrow(ddata))
for (i in 1:nrow(ddata))  {
   last_fire_date <- max(fd[fd$Watershed == ddata$Watershed[i] & fd$Year <=ddata$year[i], 'Year'])
   time_since_disturbance[i] <- as.numeric( ddata$year[i] - last_fire_date )
}
time_since_disturbance[is.infinite(time_since_disturbance)] <- NA

ddata[, ':='(
   time_since_disturbance = time_since_disturbance,
   realm = 'terrestrial',
   taxon = 'invertebrates',
   metric = 'count',
   unit = 'count',
   comment = 'Grasshopper sampling in fields burnt at various frequencies. Some fields are also grazed.'
)]

# Pooling abundances from different plots
ddata[, value := sum(Total), by = .(site, year, treatment, species)]

ddata[, ':='(Watershed = NULL,
             DataCode = NULL,
             RecType = NULL,
             RecMonth = NULL,
             RecDay = NULL,
             Soiltype = NULL,
             Repsite = NULL,
             Spcode = NULL,
             S1 = NULL,
             S2 = NULL,
             S3 = NULL,
             S4 = NULL,
             S5 = NULL,
             S6 = NULL,
             S7 = NULL,
             S8 = NULL,
             S9 = NULL,
             S10 = NULL,
             Total = NULL)
      ]

# Total abundance is different from the sum of the abundances in S1:S10 columns in a significant number of cases, Total values kept.
# ddata[!c(apply(ddata[,S1:S10], 1, sum, na.rm=T) == ddata[,.(Total)])]


ddata <- ddata[!is.na(ddata$value), ]
dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
write.csv(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '_dt.csv'),
          row.names=FALSE)
