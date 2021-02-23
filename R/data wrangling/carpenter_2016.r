## carpenter_2016
library(data.table)

dataset_id <- 'carpenter_2016'
load(file='data/raw data/carpenter_2016/ddata')
setDT(ddata)

setnames(ddata, c('year4', 'lakename', 'taxon_name', 'abundance','sampledate'),
         c('year', 'site', 'species', 'value','date'))

# Exclusion of lakes with unknown disturbance history
ddata <- ddata[!site %in% c('Ward Lake','Hummingbird Lake')]

# Exclusion of samples outside of the first of May to 31st of August period
ddata[, daynumber := format(date, '%j')]
ddata <- ddata[daynum > 121 & daynum < 243]

ddata <- ddata[!is.na(value) & value > 0]
ddata[, value := round(value, 0)]

# Community
ddata[, ':='(
   N = sum(value),
   S = length(unique(species)),
   ENSPIE = vegan::diversity(x = value, index = 'invsimpson')
),
by = .(site, year, date)
]

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


beforeafter <- fifelse(ddata$site %in% c("Paul Lake", 'Crampton Lake'), '',
                       fifelse(
                          (ddata$site %in% c('East Long Lake', 'West Long Lake') & ddata$year < 1991)  |
                             (ddata$site %in% c('Peter Lake','Tuesday Lake') & ddata$year < 1985), 'B', 'A')
)

ddata[, ':='(
   dataset_id = dataset_id,
   treatment = fifelse(site %in% c("Paul Lake", 'Crampton Lake'), 'control',
                       fifelse(site %in% c('East Long Lake', 'West Long Lake'), 'eutrophication',
                               fifelse(site %in% c('Peter Lake','Tuesday Lake'), 'community manipulation', NA_character_)
                       )
   ),
   treatment_type = 'eutrophication + fish community manipulation',
   grain_m2 = pi*0.15^2 * 2,
   grain_comment = "'We sampled for zooplankton by taking two vertical hauls of a conical net (30 cm diameter, 80-mm mesh) from 2.5 m to the surface in Monday Bog and from 4.0 m in Wednesday Bog.'. Two hauls per survey",
   design = paste0(beforeafter, fifelse(site %in% c("Paul Lake", 'Crampton Lake'), 'C', 'I')),
   timepoints = paste0('T', seq_along(unique(year))[match(year, sort(unique(year)))]),
   time_since_disturbance = fifelse(site %in% c('East Long Lake', 'West Long Lake') & beforeafter == 'A',
                                    year - 1991,
                                    fifelse(site %in% c('Peter Lake','Tuesday Lake') & beforeafter == 'A',
                                            year - 1985,
                                            NA_integer_)
   ),
   realm = 'freshwater',
   taxon = 'zooplankton',

   comment = 'Effort is the number of surveys per year. Time since disturbance is the difference between sampledate and the FIRST disturbance. Most manipulations are reported in ./supporting litterature/Carpenter - Table 1 - Synthesis of a 33 year-series of whole lake experiments - lol2.10094.pdf. Zooplankton abundances from several surveys a year are additionned and averaged (3 to 19 surveys).'
)]


dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
       row.names=FALSE)
