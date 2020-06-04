## reed_2020a
library(data.table)

dataset_id <- 'reed_2020a'
load(file='data/raw data/reed_2020a/ddata')
setDT(ddata)

setnames(ddata, tolower)
setnames(ddata, c('transect', 'scientific_name'), c('block', 'species'))

effort <- unique(
   ddata[,.(year, date, site, block, treatment, quad, side, survey, area)]
   )[,
     .(effort = sum(area)), by = .(year, site, block, treatment)
     ]
ddata <- ddata[, .(value = sum(count)), by = .(year, site, block, treatment, species)][value > 0]
ddata <- merge(ddata, effort, by = c('year', 'site', 'block', 'treatment'))

ddata[, ':='(
   dataset_id = dataset_id,
   treatment = tolower( treatment),
   treatment_type = 'kelp removal',
   timepoints = paste0('T', seq_along(unique(year))[match(year, unique(year))]),
   design = ifelse(treatment == 'control', 'AC', 'AI'),

   realm = 'marine',
   taxon = 'fish',
   metric = 'density',
   value = value / effort,
   unit = 'ind per m2',
   comment = 'Cryptic and Mobile surveys pooled. Multiple annual surveys pooled into one with total abundances standardized by total sampled area. Two transects per site, each with a different treatment.'
)][, effort := NULL]

ddata[treatment != 'control', "time_since_disturbance" := year - min(year), by = site]


dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
