## bateman_2018
library(data.table)


dataset_id <- 'bateman_2018'
load(file = 'data/raw data/bateman_2018/ddata')
setDT(ddata)

setnames(ddata, old = c('reach', 'site_code','common_name','bird_count','survey_date'),
         new = c('site', 'block', 'species','value','date'))
ddata[, ':='(year = as.integer(format(date, '%Y')),
             month = as.integer(format(date, '%m')))]

# Selecting surveys between January and May, excluding 2018 which has only January
ddata <- ddata[ year != 2018 & month <= 5]

ddata[is.na(value), value := 1]

# Community
ddata[, ':='(N = sum(value),
             S = length(unique(species)),
             ENSPIE = vegan::diversity(x = value, index = 'invsimpson')
),
by = .(site, block, year, date)
]

ddata[, minN := min(N), by = .(site, block)] # 0% minN < 6

ddata[, Sn := vegan::rarefy(value, sample = minN), by = .(site, block, year, date)]

ddata[, ':='(
   singletons = sum(value == 1),
   doubletons = sum(value == 2)
), by = .(site, block, year, date)
][,
  coverage := fifelse(
     doubletons > 0,
     1 - (singletons/N) * (((N - 1)*singletons)/((N - 1)*singletons + 2*doubletons)),
     1 - (singletons/N) * (((N - 1)*singletons)/((N - 1)*singletons + 2))
  )][, ':='(singletons = NULL, doubletons = NULL)]

ddata <- ddata[,
               lapply(.SD, mean),
               by = .(site, block, year),
               .SDcols = c('N','minN','S','Sn','ENSPIE','coverage')
]


ddata[, ':='(
   dataset_id = dataset_id,
   treatment = fifelse(site %in% c('Ave35','Ave67','Price','Priest'), 'urban_notRestored',
                       fifelse(site %in% c('BM','Rio'), 'urban_restored',
                               'notUrban_notRestored')
   ),
   treatment_type = 'riverbank vegetation restoration',
   grain_m2 = pi*30^2,
   grain_comment = "listening point of 30m radius - estimated",
   timepoints = paste0('T', seq_along(unique(year))[match(year, sort(unique(year)))]),
   time_since_disturbance = fifelse(site == 'BM', year - 2012,
                                    fifelse(site == 'Rio', year - 2005, NA_integer_)
   ),
   realm = 'terrestrial',
   taxon = 'birds',

   comment = 'Some restored and some unrestored sites along the Salt river. Each station was surveyed several times a year (2 to 9). Abundances are summed per year and divided by the number of sampling events. One listening point (30m radius circle) per site per survey.'
)
][, design := paste0('A', fifelse(treatment == "urban_restored", 'I', 'C'))]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, '/', dataset_id, '.csv'),  row.names=FALSE)
