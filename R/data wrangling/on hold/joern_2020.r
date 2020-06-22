## joern_2020
library(data.table)


dataset_id <- 'joern_2020'
load(file='data/raw data/joern_2020/ddata')
setDT(ddata)

setnames(ddata, old = c('Recyear','Watershed','Repsite'),
         new = c('year','site','block'))


ddata[, ':='(
   site = toupper(site),
   species = paste(Genus, Species)
)
][site %in% c("0C1A", "0C3A", "0C3B", "0C3C"),
  site := c('C01A','C03A','C03B','C03C')[match(site, c("0C1A", "0C3A", "0C3B", "0C3C"))]
  ]
#
# ddata[, ':='(
#    treatment = paste(
#       ifelse(substr(site, 1, 1) %in% c('n','N'), 'Grazing', 'noGrazing'),
#       ifelse(substr(site, 2, 3) == '00',
#              'noFire',
#              paste0('fire', substr(site, 2, 3) )), sep = '_'),
#    date = as.Date(paste(year, Recmonth, Recday, sep='/'), format = '%Y/%m/%d')
# )][, treatment := ifelse(treatment == 'noGrazing_noFire', 'control', treatment)]
#
#
# # Pooling abundances from different surveys
# effort <- ddata[, .(effort = length(unique(date))), by = .(site, block, year, treatment)]
# ddata <- ddata[, .(value = sum(Total)), by = .(site, block, year, treatment, species)]
# ddata <- merge(ddata, effort, by = c('year', 'site','block', 'treatment'))
#
# ddata[, ':='(
#    dataset_id = dataset_id,
#    treatment_type = "fire and grazing",
#    timepoints = paste0('T',seq_along(unique(year))[match(year, unique(year))]),
#    design = paste0('A', ifelse(treatment == 'control', 'C', 'I'))
# )]
#
# # Disturbance calendar
# load('data/raw data/joern_2019/ddata_env')
# fd <- fd[nchar(fd$Watershed) <= 4,]
#
# # N4D -> N04D
# pattern <- "(^[A-Za-z]){1}([0-9]){1}([A-Za-z]){1}$"
# replacement <- "\\10\\2\\3"
# fd$Watershed <- gsub(pattern, replacement, fd$Watershed)
# # 1B -> 001B
# fd$Watershed <- toupper( paste0(
#    sapply(max(nchar(fd$Watershed))-nchar(fd$Watershed), function(x) paste(rep(x = 0, times = x), collapse="")),
#    fd$Watershed
# ) )
#
# fd <- fd[fd$Watershed %in% ddata$site, ]
#
#
#
#
# time_since_disturbance <- rep(NA, nrow(ddata))
# suppressWarnings({
#    for (i in 1:nrow(ddata))  {
#       last_fire_date <- max(fd[fd$Watershed == ddata$site[i] & fd$Year <=ddata$year[i], 'Year'])
#       time_since_disturbance[i] <- as.numeric( ddata$year[i] - last_fire_date )
#    }
# })
# time_since_disturbance[is.infinite(time_since_disturbance)] <- NA
#
# ddata[, ':='(
#    time_since_disturbance = time_since_disturbance,
#    realm = 'terrestrial',
#    taxon = 'invertebrates',
#    metric = 'count',
#    value = value / effort,
#    unit = 'count',
#    comment = 'Grasshopper sampling in fields burnt at various frequencies (the number in the site names indicates the theoretical frequency). Some fields are also grazed and the site name indicates N for natural grazing by bison. Most of the type, there were several samplings in a year, they have been pooled together and divided by the number of visits (1 to 14).'
# )]
#
#
# # Total abundance is different from the sum of the abundances in S1:S10 columns in a significant number of cases, Total values kept.
# # ddata[!c(apply(ddata[,S1:S10], 1, sum, na.rm=T) == ddata[,.(Total)])]
#
#
# ddata[, effort := NULL]
#
# dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
# fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
#        row.names=FALSE)
('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
#        row.names=FALSE)

