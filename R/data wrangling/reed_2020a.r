## reed_2020a
library(data.table)

dataset_id <- 'reed_2020a'
load(file='data/raw data/reed_2020a/ddata')
setDT(ddata)

setnames(ddata, tolower)
setnames(ddata, c('transect', 'scientific_name','count'), c('block', 'species','value'))

ddata[treatment %in% c('POST ANNUAL','POST CONTINUAL'),
      treatment := ifelse(treatment == 'POST ANNUAL', 'ANNUAL', 'CONTINUAL')]

ddata <- ddata[value > 0]

# Community
ddata[, ':='(
   N = sum(value),
   S = length(unique(species)),
   ENSPIE = vegan::diversity(x = value, index = 'invsimpson')
),
by = .(site, block, treatment, year, date)
]

ddata[, minN := min(N), by = .(site, block, treatment)] # 100% minN=1

ddata[, Sn := NA] #vegan::rarefy(value, sample = minN), by = .(site, block, treatment, year, date)]

ddata <- ddata[,
               lapply(.SD, mean),
               by = .(site, block, treatment, year),
               .SDcols = c('N','minN','S','Sn','ENSPIE')
               ]



# ddata[order(site, year, treatment), .(effort = sum(area)), by = .(year, site, block, treatment, survey)]



ddata[, ':='(
   dataset_id = dataset_id,
   treatment = tolower( treatment),
   treatment_type = 'kelp removal',
   timepoints = paste0('T', seq_along(unique(year))[match(year, unique(year))]),
   design = ifelse(treatment == 'control', 'AC', 'AI'),

   realm = 'marine',
   taxon = 'fish',

   comment = 'Cryptic and Mobile surveys pooled. Multiple surveys per year  pooled into one by averaging biodiversity metrics. Two transects per site, each with a different treatment. Effort for Cryptic fish is significantly lower than for swiming fish.'
)]

ddata[treatment != 'control', "time_since_disturbance" := year - min(year), by = site]


dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)

