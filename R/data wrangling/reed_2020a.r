## reed_2020a
library(data.table)

dataset_id <- 'reed_2020a'
load(file = 'data/raw data/reed_2020a/ddata')
setDT(ddata)

setnames(ddata, tolower)
setnames(ddata, c('transect', 'scientific_name','count'), c('block', 'species','value'))

ddata[treatment %in% c('POST ANNUAL','POST CONTINUAL'),
      treatment := fifelse(treatment == 'POST ANNUAL', 'ANNUAL', 'CONTINUAL')]

ddata <- ddata[value > 0]
ddata[, month := as.numeric(format(date, '%m'))]

# exclusion of 2020, IVE 2011
ddata <- ddata[ year != 2020 &
                   month >= 2 & month <= 11 &
                   !(site == 'IVEE' & year == 2011)]


# Community
ddata[, ':='(
   N = sum(value),
   S = length(unique(species)),
   ENSPIE = vegan::diversity(x = value, index = 'invsimpson')
),
by = .(site, block, treatment, year, date)
]

# exclusion of campaigns reaching an abundance <= 5
# ddata <- ddata[ N > 5 ]
ddata[, minN := min(N), by = .(site, block, treatment)]

ddata[, Sn := vegan::rarefy(value, sample = minN), by = .(site, block, treatment, year, date)]

ddata[, ':='(
   singletons = sum(value == 1),
   doubletons = sum(value == 2)
), by = .(site, block, treatment, year, date)
][,
  coverage := fifelse(
     doubletons > 0,
     1 - (singletons/N) * (((N - 1)*singletons)/((N - 1)*singletons + 2*doubletons)),
     1 - (singletons/N) * (((N - 1)*singletons)/((N - 1)*singletons + 2))
  )][, ':='(singletons = NULL, doubletons = NULL)]

# effort
ddata[, effort := length(unique(date)), by = .(site, treatment, year)]
ddata[, effort := sum(area), by = .(site, treatment, year)]

ddata <- ddata[,
               lapply(.SD, mean),
               by = .(site, block, treatment, year),
               .SDcols = c('effort','N','minN','S','Sn','ENSPIE','coverage')
]






ddata[, ':='(
   dataset_id = dataset_id,
   treatment = tolower( treatment),
   treatment_type = 'kelp removal',
   grain_m2 = 80,
   grain_comment = 'Each block is a 40m long, 2m wide transect',
   design = fifelse(treatment == 'control', 'AC', 'AI'),
   timepoints = paste0('T', seq_along(unique(year))[match(year, sort(unique(year)))]),

   realm = 'marine',
   taxon = 'fish',

   comment = 'Cryptic and Mobile surveys pooled. Diversity metrics computed for multiple surveys per year and then averaged together. Two transects per site, each with a different treatment. Effort for Cryptic fish is significantly lower than for swimming fish. Only surveys made between February and November are kept. 2020 is excluded because only the beginning of the year is covered.'
)]

ddata[treatment != 'control', "time_since_disturbance" := year - min(year), by = site]


dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'), row.names = FALSE)

