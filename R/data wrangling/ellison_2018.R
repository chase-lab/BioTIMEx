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

effort <- ddata[, .(effort = length(unique(date))), by = .(year, site, block, plot, subplot, treatment)]

ddata <- ddata[, .(value = sum(value)), by = .(year, site, block, plot, subplot, treatment, species)]
ddata <- merge(ddata, effort, by = c('year', 'site','block', 'plot', 'subplot', 'treatment'))

ddata[, ':='(dataset_id = dataset_id,
             treatment_type = "manipulated community",
             design = paste0('A', ifelse(grepl('control', treatment), 'C', 'I')),
             timepoints = paste0('T',seq_along(unique(year))[match(year, unique(year))]),
             time_since_disturbance = ifelse(grepl('control', treatment), NA, year - 2006),
             realm = 'terrestrial',
             taxon = 'invertebrates',
             metric = 'count',
             value = value, #  / effort,
             unit = 'count',
             comment = 'Hierarchical experimental design. Treatment is one of 8 canopy manipulation treatments. Effort: is the number of times the pitfalls were sampled relevant for effort? Or should the time between first and last survey of each year be used as effort?'
)
][, effort := NULL]



dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
