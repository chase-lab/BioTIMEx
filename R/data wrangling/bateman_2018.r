## bateman_2018
library(data.table)


dataset_id <- 'bateman_2018'
load(file='data/raw data/bateman_2018/ddata')
setDT(ddata)

setnames(ddata, old = c('reach', 'site_code','common_name','bird_count'),
         new = c('site', 'block', 'species','value'))
ddata[, year := as.integer(format(survey_date, '%Y'))]


effort <- ddata[, .(effort = length(unique(survey_date))), by = .(year, site, block)]
ddata <- ddata[, .(value = sum(value)), by = .(year, site, block, species)]
ddata <- merge(ddata, effort, by = c('year', 'site', 'block'))


ddata[, ':='(
   dataset_id = dataset_id,
   treatment = ifelse(site %in% c('Ave35','Ave67','Price','Priest'), 'Urban_notRestored',
                      ifelse(site %in% c('BM','Rio'), 'urban_restored',
                             'notUrban_notRestored')
                      ),
   treatment_type = 'riverbank vegetation restoration',
   timepoints = paste0('T',seq_along(unique(year))[match(year, unique(year))]),
   time_since_disturbance = ifelse(site == 'BM', year - 2012,
                                   ifelse(site == 'Rio', year - 2005, NA)
                                   ),
   realm = 'terrestrial',
   taxon = 'birds',
   metric = 'count',
   value = value  / effort,
   unit = 'mean abundance per survey',
   comment = 'Some restored and some unrestored sites along the Salt river. Each station was surveyed several times a year (2 to 9). Abundances are summed per year and divided by the number of sampling events.'
)
][, ':='(design = paste0('A', ifelse(treatment == "urban_restored", 'I', 'C')),
         effort = NULL)]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, '/', dataset_id, '.csv'))
