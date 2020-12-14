## fridley_2009
library(data.table)

dataset_id <- 'fridley_2009'
load(file = 'data/raw data/fridley_2009/ddata')
setDT(ddata)

setnames(ddata, c('block', 'plot', 'contacts'),
         c('site', 'block', 'value'))

# Community
ddata[, ':='(
   N = sum(value),
   S = length(unique(species)),
   ENSPIE = vegan::diversity(x = value, index = 'invsimpson')
),
by = .(site, block, year)
]

ddata[, minN := min(N), by = .(site, block)] # No minN < 6

ddata[, Sn := vegan::rarefy(value, sample = minN), by = .(site, block, year)]

ddata[, ':='(
   singletons = sum(value == 1),
   doubletons = sum(value == 2)
), by = .(site, block, year)
][,
  coverage := fifelse(
     doubletons > 0,
     1 - (singletons/N) * (((N - 1)*singletons)/((N - 1)*singletons + 2*doubletons)),
     1 - (singletons/N) * (((N - 1)*singletons)/((N - 1)*singletons + 2))
  )][, ':='(singletons = NULL, doubletons = NULL)]


ddata[, ':='(
   dataset_id = dataset_id,
   treatment_type = "manipulated climate",
   design = paste0('A', fifelse(treatment == 'control', 'C', 'I')),
   timepoints = paste0('T', seq_along(unique(year))[match(year, sort(unique(year)))]),
   time_since_disturbance = ifelse(treatment == 'control', NA,
                                   fifelse(treatment %like% 'warm', year - 1993, year - 1994)
   ),

   realm = 'terrestrial',
   taxon = 'plants',
   species = NULL,
   value = NULL,

   comment = 'Artificial temperature increase in winter began in November 1993 (warm treatment). Artificial drought began in summer 1994. Artificial increase of water input began in summer 1994. See metadata for full setup. No standardisation needed, one sampling per year.'

)]

ddata <- unique(ddata)

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'), row.names = FALSE)

