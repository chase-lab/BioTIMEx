## knops_2018a
library(data.table)

dataset_id <- 'knops_2018a'
load(file='data/raw data/knops_2018a/ddata')
setDT(ddata)

ddata[, ':='(Genus = gsub('undet', 'Unknown', Genus),
          Specific.epithet = gsub('undet|under', 'sp.', Specific.epithet))]

ddata[, ':='(year = format(Date, '%Y'),
             treatment = paste0(
                ifelse(Exclosure == 'y', 'Ex', ''),
                ifelse(Fertilized == 'y', 'Fe', ''),
                ifelse(Burned == 'y', 'Bu', '')
             ),
             species = paste(Genus, Specific.epithet)
)
             ]

dat <- ddata[, .(value = sum(nSpecimens)/c(1, 1, 3, 2)[match(year, c(2003:2006))]),
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
                  unit = 'ind per survey',
                  comment = 'Block design with treatments being Ex (Exclosure meaning no grazing), Fe (fertilization) and Bu (burning every other year). Life stage is also given (sometimes) so subadults could be excluded hence diminishing greatly the number of undeterminate species.'
                  )]

dat <- dat[!is.na(value)]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
write.csv(dat, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
