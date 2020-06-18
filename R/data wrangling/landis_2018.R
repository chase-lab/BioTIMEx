## landis_2018
library(data.table)


dataset_id <- 'landis_2018'
load(file='data/raw data/landis_2018/ddata')
setDT(ddata)

setnames(ddata, old = c('Treatment', 'Replicate', 'Station', 'Species','Adults', 'Year','Sample_Date'),
         new = c('site', 'block', 'plot', 'species','value', 'year','date'))


ddata[, effort := length(unique(date)), by = .(year, site, block, plot)] # effort is the number of surveys
ddata <- ddata[, .(value = sum(value / effort)), by = .(year, site, block, plot, species)]  # abundance divided by effort
ddata[, value := value / min(value), by = .(year, site, block, plot)]# standardised abundance divided by the smallest abundance

ddata <- ddata[value > 0]

ddata[, ':='(
   dataset_id = dataset_id,
   treatment = ifelse(site == 'CF', 'coniferous forest',
               ifelse(site == 'DF', 'decideous forest',
               ifelse(site == 'SF', 'mid-successional',
               ifelse(site == 'T1', 'conventional',
               ifelse(site == 'T2', 'no-till',
               ifelse(site == 'T3', 'reduced input',
               ifelse(site == 'T4', 'organic',
               ifelse(site == 'T5', 'poplar',
               ifelse(site == 'T6', 'alfalfa',
                     'early-successional'
   ))))))))),
   design = 'AI',
   timepoints = paste0('T',seq_along(unique(year))[match(year, unique(year))]),
   time_since_disturbance = year - 1989,
   realm = 'terrestrial',
   taxon = 'invertebrates',
   metric = 'count',
   unit = 'ind per replicate',
   comment = 'Hierarchical experimental design. Treatment is one of 10 culture treatments. Effort: several replicates (block) per treatment (site), each being sampled at 5 stations (plot) several time a year. Abundances are summed per year and divided by the number of sampling events.'
)
]



dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, '/', dataset_id, '.csv'))
