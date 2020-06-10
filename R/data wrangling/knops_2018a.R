## knops_2018a
library(data.table)

dataset_id <- 'knops_2018a'
load(file='data/raw data/knops_2018a/ddata')
setDT(ddata)

setnames(ddata, 'Plot', 'site')

ddata[, ':='(year = format(Date, '%Y'),
             treatment = paste0(
                ifelse(Exclosure == 'y', 'Ex', ''),
                ifelse(Fertilized == 'y', 'Fe', ''),
                ifelse(Burned == 'y', 'Bu', '')
             ),
             Genus = gsub('undet', 'Unknown', Genus),
             Specific.epithet = gsub('undet|under', 'sp.', Specific.epithet)
)
][,
  ':='(species = paste(Genus, Specific.epithet),
       treatment = ifelse(treatment == '', 'control', treatment))
  ][, block := paste0('B',seq_along(unique(treatment))[match(treatment, unique(treatment))])]


ddata <- ddata[, .(value = sum(nSpecimens)/c(1, 1, 3, 2)[match(year, c(2003:2006))]),
    by = .(year, block, treatment, species)]

ddata[,
             ':='(dataset_id = dataset_id,
                  site = 'Field.B',
                  treatment_type = 'prairie management',
                  timepoints = paste0('T',seq_along(unique(year))[match(year, unique(year))]),
                  design = paste0('A', ifelse(treatment == 'control', 'C', "I")),
                  time_since_disturbance = ifelse(treatment == 'control', NA,
                                                  as.numeric(year) - 2000),
                  realm = 'terrestrial',
                  taxon = 'invertebrates',
                  metric = 'count',
                  unit = 'ind per survey',
                  comment = 'Block design with treatments being Ex (Exclosure meaning no grazing), Fe (fertilization) and Bu (burning every other year). Life stage is also given (sometimes) so subadults could be excluded hence diminishing greatly the number of undeterminate species.'
                  )]

verif <- ddata[, ap := ifelse(value > 0, 1, 0)][, .(N = sum(ap), S=length(unique(species))), by = .(site, block, treatment, year)][S>N]
if(nrow(verif)>0) warning('S > N')

ddata <- ddata[, ap := NULL]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
