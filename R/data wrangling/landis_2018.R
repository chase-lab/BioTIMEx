## landis_2018
library(data.table)


dataset_id <- 'landis_2018'
load(file='data/raw data/landis_2018/ddata')
setDT(ddata)

setnames(ddata, old = c('Treatment', 'Replicate', 'Station', 'Species','Adults', 'Year','Sample_Date'),
         new = c('site', 'block', 'plot', 'species','value', 'year','date'))

ddata <- ddata[value > 0]

# Selecting surveys between beginningof June and end of August
ddata[, daynum := format(date, '%j')]
ddata <- ddata[daynum > 152 & daynum < 243]
# A = ddata[daynum > 121 & daynum < 243,length(unique(date)), by = .(site, year)]
# B = ddata[daynum > 152 & daynum < 243,length(unique(date)), by = .(site, year)]
# C = ddata[daynum > 152 & daynum < 243,length(unique(date)), by = .(site, year)]


# Community
ddata[, ':='(
   N = sum(value),
   S = length(unique(species)),
   ENSPIE = vegan::diversity(x = value, index = 'invsimpson')
),
by = .(site, block, plot, year, date)
]

ddata[, minN := min(N), by = .(site, block, plot)] # 100% minN=1

ddata[, Sn := NA] #vegan::rarefy(value, sample = minN), by = .(site, block, year, date)]

ddata <- ddata[,
               lapply(.SD, mean),
               by = .(site, block, plot, year),
               .SDcols = c('N','minN','S','Sn','ENSPIE')
               ]


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

   comment = 'Hierarchical experimental design. Treatment is one of 10 culture treatments. Effort: several replicates (block) per treatment (site), each being sampled at 5 stations (plot) several time a year. Several biodiversity metrics each year are averaged.'
)
]



dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, '/', dataset_id, '.csv'), row.names=FALSE)
