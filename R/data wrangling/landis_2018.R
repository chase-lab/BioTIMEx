## landis_2018
library(data.table)


dataset_id <- 'landis_2018'
load(file = 'data/raw data/landis_2018/ddata')
setDT(ddata)

setnames(ddata, old = c('Treatment', 'Replicate', 'Station', 'Species','Adults', 'Year','Sample_Date'),
         new = c('site', 'block', 'plot', 'species','value', 'year','date'))

ddata <- ddata[value > 0]

# Selecting surveys between beginning of June and end of August
ddata[, daynum := format(date, '%j')]
ddata <- ddata[daynum > 152 & daynum < 243]
# A = ddata[daynum > 121 & daynum < 243,length(unique(date)), by = .(site, year)]
# B = ddata[daynum > 152 & daynum < 243,length(unique(date)), by = .(site, year)]
# C = ddata[daynum > 152 & daynum < 243,length(unique(date)), by = .(site, year)]

# Community
## Pooling plots (There are always 5 plots) and blocks together (the number of blocks is constant for a given site / treatment in time).
ddata <- unique(ddata[, .(value = sum(value)), by = .(site, year, date, species)])
ddata[, effort := length(unique(date)), by = .(site, year)]

## Computing metrics
ddata[, ':='(
   N = sum(value),
   S = length(unique(species)),
   ENSPIE = vegan::diversity(x = value, index = 'invsimpson')
),
by = .(site, year, date)
]

ddata[, minN := min(N), by = .(site)]

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

ddata <- ddata[,
               lapply(.SD, mean),
               by = .(site, year),
               .SDcols = c('effort','N','minN','S','ENSPIE','Sn','coverage')
]


ddata[, ':='(
   dataset_id = dataset_id,
   treatment = c('coniferous forest', 'decideous forest', 'mid-successional', 'conventional', 'no-till', 'reduced input', 'organic', 'poplar', 'alfalfa', 'early-successional')[match(site, c('CF', 'DF', 'SF', 'T1', 'T2', 'T3', 'T4', 'T5', 'T6'))],
   treatment_type = "vegetation management",
   grain_m2 = 0.229*0.178*2,
   grain_comment = "'Double sided sticky traps with 22.9 × 17.8 cm (9 × 7”) of sticky surface per side, “Corn rootworm trap”, Great Lakes IPM Vestaburg MI.' One per site",
   design = 'AI',
   timepoints = paste0('T', seq_along(unique(year))[match(year, sort(unique(year)))]),
   time_since_disturbance = year - 1989,
   realm = 'terrestrial',
   taxon = 'invertebrates',

   comment = 'Hierarchical experimental design. Treatment is one of 10 culture treatments. Effort: 3 or 6 replicates (block) per treatment (site), each being sampled at 5 stations (plot) several time a year. Blocks and plots were pooled together to increase min N but it is still low. However, the number of surveys per year varies a lot so several biodiversity metrics each year are averaged. Effort gives the number of surveys per year.'
)
]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, '/', dataset_id, '.csv'), row.names = FALSE)
