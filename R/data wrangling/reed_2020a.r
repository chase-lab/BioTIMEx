## reed_2020a
library(data.table)

dataset_id <- 'reed_2020a'
load(file='data/raw data/reed_2020a/ddata')
setDT(ddata)

setnames(ddata, tolower)
setnames(ddata, c('transect', 'scientific_name','count'), c('block', 'species','value'))

ddata[treatment %in% c('POST ANNUAL','POST CONTINUAL'),
      treatment := ifelse(treatment == 'POST ANNUAL', 'ANNUAL', 'CONTINUAL')]

ddata[, effort := sum(area), by = .(year, site, block, treatment)] # effort is the number of surveys

ddata <- ddata[, .(value = sum(value / effort)), by = .(year, site, block, treatment, species)]  # abundance divided by effort
ddata[!is.na(value) & value > 0, value := value / min(value), by = .(year, site, block,  treatment)]# standardised abundance divided by the smallest abundance


ddata[, ':='(
   dataset_id = dataset_id,
   treatment = tolower( treatment),
   treatment_type = 'kelp removal',
   timepoints = paste0('T', seq_along(unique(year))[match(year, unique(year))]),
   design = ifelse(treatment == 'control', 'AC', 'AI'),

   realm = 'marine',
   taxon = 'fish',
   metric = 'density',
   unit = 'ind per m2',
   comment = 'Cryptic and Mobile surveys pooled. Multiple annual surveys pooled into one with total abundances standardized by total sampled area. Two transects per site, each with a different treatment.'
)]

ddata[treatment != 'control', "time_since_disturbance" := year - min(year), by = site]

verif <- ddata[, ap := ifelse(value > 0, 1, 0)][, .(N = sum(ap), S=length(unique(species))), by = .(site, block, year)][S > N]
if(nrow(verif)>0) warning('S > N')

ddata <- ddata[, ap := NULL]

dddata <- ddata[value > 0]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
