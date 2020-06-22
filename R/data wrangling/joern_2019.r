## joern_2019
library(data.table)


dataset_id <- 'joern_2019'
load(file='data/raw data/joern_2019/ddata')
setDT(ddata)

setnames(ddata, old = c('RecYear','Watershed','Repsite', 'Species'),
         new = c('year','site','block', 'species'))
ddata[, ':='(
   site = toupper(site),
   treatment = paste(
      ifelse(substr(site, 1, 1) %in% c('n','N'), 'Grazing', 'noGrazing'),
      ifelse(substr(site, 2, 3) == '00',
             'noFire',
             paste0('fire', substr(site, 2, 3) )), sep = '_'),
   date = as.Date(paste(year, RecMonth, RecDay, sep='/'), format = '%Y/%m/%d')
)][, ':='(treatment = ifelse(treatment == 'noGrazing_noFire', 'control', treatment),
   daynum = format(date, format = '%j'))
   ]

# Keeping only samples between July and August
ddata <- ddata[daynum >= 182  & daynum <= 243]

# melting sites and selecting columns
ddata <- melt(ddata,
            id.vars = c('site', 'block', 'treatment', 'year','date','species'),
            measure.vars = paste0('S', 1:10),
            variable.name = 'plot',
            value.name = 'value'
            )

## wrong value correction
ddata[value == 0, value := NA]
ddata <- ddata[!is.na(value) & value > 0]


# Community
ddata[, ':='(
   N = sum(value),
   S = length(unique(species)),
   ENSPIE = vegan::diversity(x = value, index = 'invsimpson')
),
by = .(site, block, plot, treatment, year, date)
]

ddata[, minN := min(N), by = .(site, block, plot, treatment)] # 99% minN=1

ddata[, Sn := NA] #vegan::rarefy(value, sample = minN), by = .(site, block, treatment, year, date)]

ddata <- ddata[,
               lapply(.SD, mean),
               by = .(site, block, plot, treatment, year),
               .SDcols = c('N','minN','S','Sn','ENSPIE')
               ]


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

   comment = 'Grasshopper sampling in fields burnt at various frequencies (the number in the site names indicates the theoretical frequency). Some fields are also grazed and the site name indicates N for natural grazing by bison. Most of the time, there were several samplings in a year, their divrsity metrics have been averaged together.'
)]


dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)

