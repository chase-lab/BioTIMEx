## carpenter_2017
library(data.table)

dataset_id <- 'carpenter_2017'
load(file='data/raw data/carpenter_2017/ddata')
setDT(ddata)

setnames(ddata, old = c( 'lakename','year4','sampledate', 'concentration'),
         new = c('site', 'year','date', 'value'))

ddata[, species := gsub( trimws( paste(
      ifelse(is.na(genus), '', as.character(genus)),
      ifelse(is.na(species), '', as.character(species)),
      ifelse(is.na(genus) & is.na(species), 'Unkown', ''),
      ifelse(is.na(genus) & is.na(species) & !is.na(description), as.character(description), ''),
      sep=' ') ), pattern = ' {2,3}', replacement = ' ')
]

ddata[, daynumber := format(date, '%j')]
ddata <- ddata[daynum > 152 & daynum < 243]
# A = ddata[daynum > 121 & daynum < 273,length(unique(date)), by = .(site, year)]
# B = ddata[daynum > 152 & daynum < 273,length(unique(date)), by = .(site, year)]
# C = ddata[daynum > 152 & daynum < 243,length(unique(date)), by = .(site, year)]

ddata <- ddata[!is.na(value) & value > 0]
ddata[, value := ifelse(value > 0 & value <= 1, 1, round(value, 0))]

# Community
ddata[, ':='(
            N = sum(value),
            S = length(unique(species)),
            ENSPIE = vegan::diversity(x = value, index = 'invsimpson')
         ),
         by = .(site, year, date)
]

# One site with only one individual sampled. Considered an outlier and excluded
ddata <- ddata[N > 1]

ddata[, minN := min(N), by = .(site)] # No minN < 6

ddata[, Sn := vegan::rarefy(value, sample = minN), by = .(site, year, date)]

ddata[, ':='(
   singletons = sum(value == 1),
   doubletons = sum(value == 2)
), by = .(site, year, date)
][,
  coverage := fifelse(
     doubletons > 0,
     1 - (singletons/N) * (((N - 1)*singletons)/((N - 1)*singletons + 2*doubletons)),
     1 - (singletons/N) * (((N - 1)*singletons)/((N - 1)*singletons + 2))
  )][, ':='(singletons = NULL, doubletons = NULL)]

ddata[, effort := length(unique(date)), by = .(site, year)]

ddata <- ddata[,
               lapply(.SD, mean),
               by = .(site, year),
               .SDcols = c('effort','N','minN','S','Sn','ENSPIE','coverage')
               ]

ddata[, ':='(
   dataset_id = dataset_id,
   treatment = ifelse(site == "Paul Lake", 'control',
                      ifelse(site %in% c('East Long Lake', 'West Long Lake'), 'eutrophication',
                             ifelse(site %in% c('Peter Lake','Tuesday Lake'), 'community manipulation', NA)
                      )
   ),

   treatment_type = 'eutrophication and community manipulation',
   design = paste0(ifelse(site == "Paul Lake", '',
                          ifelse(
                             (site %in% c('East Long Lake', 'West Long Lake') & year < 1991)  |
                                (site %in% c('Peter Lake','Tuesday Lake') & year < 1985), 'B', 'A')
   ),
   ifelse(site == "Paul Lake", 'C', 'I')),

   timepoints = paste0('T',seq_along(unique(year))[match(year, unique(year))]),
   realm = 'freshwater',
   taxon = 'phytoplankton',

   comment =  'One survey detecting only one individual was excluded. Effort is the number of surveys per year. Samples from 1991 to 1995 were counted by the same person hence ensuring comparable counts. 2013 to 2015 should have consistent sampling and counting too. Time since disturbance is the difference between sampledate and the FIRST disturbance. Most manipulations are reported in ./supporting litterature/Carpenter - Table 1 - Synthesis of a 33 year-series of whole lake experiments - lol2.10094.pdf.'
)][,
   time_since_disturbance := ifelse(site %in% c('East Long Lake', 'West Long Lake') & substr(design, 1, 1) == 'A',
                                    year - 1991,
                                    ifelse(site %in% c('Peter Lake','Tuesday Lake') & substr(design, 1, 1) == 'A',
                                           year - 1985, NA)
   )]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
