## joern_2019
library(data.table)


dataset_id <- 'joern_2019'
load(file='data/raw data/joern_2019/ddata')
setDT(ddata)

setnames(ddata, old = c('RecYear','Watershed','Repsite', 'Species','Total'),
         new = c('year','site','block', 'species','value'))

## wrong value correction
ddata[value == 0, value := NA]

ddata[, ':='(
   site = toupper(site),
   treatment = paste(
      ifelse(substr(site, 1, 1) %in% c('n','N'), 'Grazing', 'noGrazing'),
      ifelse(substr(site, 2, 3) == '00',
             'noFire',
             paste0('fire', substr(site, 2, 3) )), sep = '_'),
   date = as.Date(paste(year, RecMonth, RecDay, sep='/'), format = '%Y/%m/%d')
)][, treatment := ifelse(treatment == 'noGrazing_noFire', 'control', treatment)]


# Pooling abundances from different surveys
ddata[, effort := length(unique(date)), by = .(site, block, year, treatment)] # effort is the number of surveys
ddata <- ddata[, .(value = sum(value / effort)), by = .(site, block, year, treatment, species)]  # abundance divided by effort
ddata[!is.na(value) & value > 0, value := value / min(value), by = .(year, site, block, treatment)] # standardised abundance divided by the smallest abundance


ddata[, ':='(
   dataset_id = dataset_id,
   treatment_type = "fire and grazing",
   timepoints = paste0('T',seq_along(unique(year))[match(year, unique(year))]),
   design = paste0('A', ifelse(treatment == 'control', 'C', 'I'))
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

fd <- fd[fd$Watershed %in% ddata$site, ]




time_since_disturbance <- rep(NA, nrow(ddata))
suppressWarnings({
   for (i in 1:nrow(ddata))  {
      last_fire_date <- max(fd[fd$Watershed == ddata$site[i] & fd$Year <=ddata$year[i], 'Year'])
      time_since_disturbance[i] <- as.numeric( ddata$year[i] - last_fire_date )
   }
})
time_since_disturbance[is.infinite(time_since_disturbance)] <- NA

ddata[, ':='(
   time_since_disturbance = time_since_disturbance,
   realm = 'terrestrial',
   taxon = 'invertebrates',
   metric = 'count',
   unit = 'count',
   comment = 'Grasshopper sampling in fields burnt at various frequencies (the number in the site names indicates the theoretical frequency). Some fields are also grazed and the site name indicates N for natural grazing by bison. Most of the type, there were several samplings in a year, they have been pooled together and divided by the number of visits (1 to 14).'
)]


# Total abundance is different from the sum of the abundances in S1:S10 columns in a significant number of cases, Total values kept.
# ddata[!c(apply(ddata[,S1:S10], 1, sum, na.rm=T) == ddata[,.(Total)])]


verif <- ddata[, ap := ifelse(value > 0, 1, 0)][, .(N = sum(ap), S=length(unique(species))), by = .(dataset_id, site, block, year)][S > N]
if(nrow(verif) > 0) warning('S > N')

ddata[, ap := NULL]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
