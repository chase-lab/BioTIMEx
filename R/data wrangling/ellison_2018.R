## ellison_2018
library(data.table)

dataset_id <- 'ellison_2018'
load(file='data/raw data/ellison_2018/ddata')
setDT(ddata)

setnames(ddata, old = c('block','plot','subplot','subplot.t', 'count'),
         new = c('site','block','plot','subplot', 'value'))

ddata[, ':='( year = as.integer(format(date, '%Y')),
              species = paste(genus, species))]
ddata <- ddata[!is.na(value) & value > 0]
ddata <- ddata[!(date > '2006-08-31' & date < '2006-12-31')]

# Community
ddata[, ':='(
   N = sum(value),
   S = length(unique(species)),
   ENSPIE = vegan::diversity(x = value, index = 'invsimpson')
),
by = .(site, block, plot, subplot, year, date)
]

ddata[, minN := min(N), by = .(site, block, plot, subplot)] # No minN < 6

ddata[, Sn := NA] #vegan::rarefy(value, sample = minN), by = .(site, block, plot, subplot, year, date)]

ddata <- ddata[,
               lapply(.SD, mean),
               by = .(site, block, plot, subplot, treatment, year),
               .SDcols = c('N','minN','S','Sn','ENSPIE')
               ]


ddata[, ':='(dataset_id = dataset_id,
             treatment = paste(
                gsub(' control', '_management', treatment),
                subplot, sep='_')
)][, ':='(
             treatment_type = "manipulated community",
             design = paste0('A', ifelse(grepl('control', treatment), 'C', 'I')),
             timepoints = paste0('T',seq_along(unique(year))[match(year, unique(year))]),
             time_since_disturbance = ifelse(grepl('control', treatment), NA, year - 2006),
             realm = 'terrestrial',
             taxon = 'invertebrates',

             comment = 'Hierarchical experimental design. Treatment is one of 8 canopy manipulation treatments. Effort: each survey corresponds to traps being open/active for 48 hours (Ellison 2005).'
)
]



dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
