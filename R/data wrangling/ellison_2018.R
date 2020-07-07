## ellison_2018
library(data.table)

dataset_id <- 'ellison_2018'
load(file='data/raw data/ellison_2018/ddata')
setDT(ddata)

setnames(ddata, old = c('block','plot','subplot','subplot.t', 'count'),
                new = c('site','block','plot','subplot', 'value'))

ddata[, ':='( year = as.integer(format(date, '%Y')),
              species = paste(genus, species))]
ddata <- ddata[!is.na(value) & value > 0 &
               !(date > '2006-08-31' & date < '2006-12-31') &
               !(site == 'Ridge' & block == 4 & year == 2006) & # Only one block
               !(site == 'Valley' & block == 3 & year == 2006)] # Only one block



# Community
# pooling subplots among plots (each plot has 3 subplots that are treatments, not replicates so subplots aka treatments of several plots are pooled together) and subplot is then renamed plot for consistency.
ddata <- ddata[, .(value = sum(value)), by = .(site, block, subplot, treatment, year, date, species)]
setnames(ddata, 'subplot', 'plot')
ddata[, ':='(
   N = sum(value),
   S = length(unique(species)),
   ENSPIE = vegan::diversity(x = value, index = 'invsimpson')
),
by = .(site, block, plot, year, date)
]

ddata[, minN := min(N), by = .(site, block, plot)]

ddata[, Sn := vegan::rarefy(value, sample = minN), by = .(site, block, plot, year, date)]

ddata[, effort := length(unique(date)), by = .(site, year, block, plot)]

ddata <- ddata[,
               lapply(.SD, mean),
               by = .(site, block, plot, treatment, year),
               .SDcols = c('effort','N','minN','S','Sn','ENSPIE')
               ]


ddata[, ':='(dataset_id = dataset_id,
             treatment = paste(
                gsub(' control', '_management', treatment),
                plot, sep='_')
)][, ':='(
             treatment_type = "manipulated community",
             design = paste0('A', ifelse(grepl('control', treatment), 'C', 'I')),
             timepoints = paste0('T',seq_along(unique(year))[match(year, unique(year))]),
             time_since_disturbance = ifelse(grepl('control', treatment), NA, year - 2006),
             realm = 'terrestrial',
             taxon = 'invertebrates',

             comment = 'Hierarchical experimental design. Treatment is one of 8 canopy manipulation treatments. Effort is the number of survey peryea, each survey corresponds to traps being open/active for 48 hours (Ellison 2005).'
)
]



dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
