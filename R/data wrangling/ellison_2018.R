## ellison_2018
library(data.table)

dataset_id <- 'ellison_2018'
load(file='data/raw data/ellison_2018/ddata')
setDT(ddata)

setnames(ddata, old = c('block','plot','subplot','subplot.t', 'count'),
         new = c('site','block','plot','subplot', 'value'))

ddata[, ':='( year = as.integer(format(date, '%Y')),
              treatment = paste(
                 gsub(' control', '_management', treatment),
                 subplot, sep='_'),
              species = paste(genus, species))]

ddata[, effort := length(unique(date)), by = .(year, site, block, plot, subplot, treatment)] # effort is the number of surveys
ddata <- ddata[, .(value = sum(value) / effort), by = .(year, site, block, plot, subplot, treatment, species)]  # abundance divided by effort
ddata[!is.na(value) & value > 0, value := value / min(value), by = .(year, site, block, plot, subplot, treatment)] # standardised abundance divided by the smallest abundance



ddata[, ':='(dataset_id = dataset_id,
             treatment_type = "manipulated community",
             design = paste0('A', ifelse(grepl('control', treatment), 'C', 'I')),
             timepoints = paste0('T',seq_along(unique(year))[match(year, unique(year))]),
             time_since_disturbance = ifelse(grepl('control', treatment), NA, year - 2006),
             realm = 'terrestrial',
             taxon = 'invertebrates',
             metric = 'count',
             unit = 'ind per survey',
             comment = 'Hierarchical experimental design. Treatment is one of 8 canopy manipulation treatments. Effort: each survey corresponds to traps being open/active for 48 hours (Ellison 2005).'
)
]



dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
