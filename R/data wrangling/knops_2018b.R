## knops_2018b
library(data.table)

dataset_id <- 'knops_2018b'
load(file='data/raw data/knops_2018b/ddata')
setDT(ddata)

ddata <- melt(ddata, id.vars = 1:6, variable.name = 'species', value.name = 'value')
ddata[, ':='(year=Year,
             treatment = paste0(
                ifelse(Fencing == 1, 'Ex', ''),
                ifelse(Fertilization > 0, paste0('Fe', Fertilization), ''),
                ifelse(Burning == 1, 'Bu', '')
             )
)
]

dat <- ddata[, .(value = sum(value)/sum(Trapnights)),
             by = .(year, treatment, species)]

timepoints <- seq_along(unique(dat$year))
timepoints <- paste0('T',timepoints[match(dat$year, unique(dat$year))])

dat <- dat[,
           ':='(   dataset_id = dataset_id,
                   site = 'Field.B',
                   # block = Plot,
                   year = year,
                   treatment_type = 'prairie management',
                   timepoints = timepoints,
                   treatment = ifelse(treatment == '', 'control', treatment),
                   design = paste0('A', ifelse(treatment == '', 'C', "I")),
                   time_since_disturbance = ifelse(treatment == '', NA,
                                                   as.numeric(year) - 2000),
                   realm = 'terrestrial',
                   taxon = 'invertebrates',
                   metric = 'count',
                   unit = 'ind per trapnight',
                   comment = 'Block design with treatments being Ex (Exclosure meaning no grazing), Fe (fertilization (0 + 2 dosages)) and Bu (burning every other year).'
           )]

dat <- dat[!is.na(value)]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
write.csv(dat, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
