## joern_2019
library(data.table)


dataset_id <- 'joern_2019'
load(file = 'data/raw data/joern_2019/ddata')
setDT(ddata)

setnames(ddata, old = c('RecYear','Watershed','Repsite', 'Species'),
         new = c('year','site','block', 'species'))

ddata[, ':='(
   site = toupper(site),
   treatment = paste(
      fifelse(substr(site, 1, 1) %in% c('n','N'), 'Grazing', 'noGrazing'),
      fifelse(substr(site, 2, 3) == '00',
              'noFire',
              paste0('fire', substr(site, 2, 3) )), sep = '_'),
   date = as.Date(paste(year, RecMonth, RecDay, sep = '/'), format = '%Y/%m/%d')
)][, ':='(treatment = fifelse(treatment == 'noGrazing_noFire', 'control', treatment),
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
ddata <- ddata[, .(value = sum(value)), by = .(site, block, treatment, year, species)] # Pooling by block is the same as taking the total column from raw data

# Community
ddata[, ':='(
   N = sum(value),
   S = length(unique(species)),
   ENSPIE = vegan::diversity(x = value, index = 'invsimpson')
),
by = .(site, block, treatment, year)
]

ddata[, minN := min(N), by = .(site, block, treatment)] # 100% > 5

ddata[, Sn := vegan::rarefy(value, sample = minN), by = .(site, block, treatment, year)]

ddata[, ':='(
   singletons = sum(value == 1),
   doubletons = sum(value == 2)
), by = .(site, block, treatment, year)
][,
  coverage := fifelse(
     doubletons > 0,
     1 - (singletons/N) * (((N - 1)*singletons)/((N - 1)*singletons + 2*doubletons)),
     1 - (singletons/N) * (((N - 1)*singletons)/((N - 1)*singletons + 2))
  )][, ':='(singletons = NULL, doubletons = NULL)]


ddata[, ':='(
   dataset_id = dataset_id,
   treatment_type = "fire and grazing",
   grain_m2 =  pi*0.38^2,
   grain_comment = "'Sampling is done by sweeping with canvas beating nets 38 cm in diameter. A sample of 200 sweeps (ten sets of 20 sweeps each) is taken at each site on each occasion. A sweep is taken at each step by traversing an arc of 180o with the net through the top layer of vegetation.'",
   design = paste0('A', fifelse(treatment == 'control', 'C', 'I')),
   timepoints = paste0('T', seq_along(unique(year))[match(year, sort(unique(year)))]),

   species = NULL,
   value = NULL
)]

ddata <- unique(ddata)

# Disturbance calendar
load('data/raw data/joern_2019/ddata_env')
fd <- fd[nchar(fd$Watershed) <= 4,]

# N4D -> N04D
pattern <- "(^[A-Za-z]){1}([0-9]){1}([A-Za-z]){1}$"
replacement <- "\\10\\2\\3"
fd$Watershed <- gsub(pattern, replacement, fd$Watershed)
# 1B -> 001B
fd$Watershed <- toupper( paste0(
   sapply(max(nchar(fd$Watershed)) - nchar(fd$Watershed), function(x) paste(rep(x = 0, times = x), collapse = "")),
   fd$Watershed
) )

fd <- fd[fd$Watershed %in% ddata$site, ]




time_since_disturbance <- rep(NA, nrow(ddata))
suppressWarnings({
   for (i in 1:nrow(ddata))  {
      last_fire_date <- max(fd[fd$Watershed == ddata$site[i] & fd$Year <= ddata$year[i], 'Year'])
      time_since_disturbance[i] <- as.numeric( ddata$year[i] - last_fire_date )
   }
})
time_since_disturbance[is.infinite(time_since_disturbance)] <- NA

ddata[, ':='(
   time_since_disturbance = time_since_disturbance,
   realm = 'terrestrial',
   taxon = 'invertebrates',
   effort = 1,

   comment = 'Grasshopper sampling in fields burnt at various frequencies (the number in the site names indicates the theoretical frequency of fire). Some fields are also grazed and the site name indicates N for natural grazing by bison. Most of the time, there were several samplings in a year and each site was sampled in two areas (block) each in 10 transects. The 10 transects and several surveys per year were pooled together and diversity metrics were computed on these aggregated communities. Effort is the same everywhere every year.'
)]


dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'), row.names = FALSE)

