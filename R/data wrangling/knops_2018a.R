## knops_2018a
library(data.table)

dataset_id <- 'knops_2018a'
load(file = 'data/raw data/knops_2018a/ddata')
setDT(ddata)

setnames(ddata, c('Plot','nSpecimens','Date'), c('site','value','date'))

ddata[, ':='(year = format(date, '%Y'),
             month = format(date, '%m'),
             treatment = paste0(
                fifelse(Exclosure == 'y', 'Ex', ''),
                fifelse(Fertilized == 'y', 'Fe', ''),
                fifelse(Burned == 'y', 'Bu', '')
             ),
             Genus = gsub('undet', 'Unknown', Genus),
             Specific.epithet = gsub('undet|under', 'sp.', Specific.epithet)
)
][,
  ':='(species = paste(Genus, Specific.epithet),
       treatment = fifelse(treatment == '', 'control', treatment))
][, block := paste0('B', seq_along(unique(treatment))[match(treatment, unique(treatment))])]

# selecting surveys happening in August
# excluding sub-adults
ddata <- ddata[month == '08' & (Life.stage == 'na' | Life.stage == 'adults')]



# Community
ddata[, ':='(
   N = sum(value),
   S = length(unique(species)),
   ENSPIE = vegan::diversity(x = value, index = 'invsimpson')
),
by = .(site, block, treatment, year, date)
]

ddata[, minN := min(N), by = .(site, block, treatment)] # 0% minN < 6

ddata[, Sn := vegan::rarefy(value, sample = minN), by = .(site, block, treatment, year, date)]

ddata[, ':='(
   singletons = sum(value == 1),
   doubletons = sum(value == 2)
), by = .(site, block, treatment, year, date)
][,
  coverage := fifelse(
     doubletons > 0,
     1 - (singletons/N) * (((N - 1)*singletons)/((N - 1)*singletons + 2*doubletons)),
     1 - (singletons/N) * (((N - 1)*singletons)/((N - 1)*singletons + 2))
  )][, ':='(singletons = NULL, doubletons = NULL)]

ddata <- ddata[,
               lapply(.SD, unique),
               by = .(site, block, treatment, year),
               .SDcols = c('N','minN','S','Sn','ENSPIE','coverage')
]


ddata[,
      ':='(dataset_id = dataset_id,
           treatment_type = 'prairie management',
           grain_m2 = pi*0.38^2,
           grain_comment = "'All 32 plots were sampled for arthropods in 2003-2006 using a 38 cm diameter muslin sweep net to take 50 sweeps per plot. A ?sweep? consisted of a quick, approximately 2-meter-long horizontal swing of the net.'",
           design = paste0('A', fifelse(treatment == 'control', 'C', "I")),
           timepoints = paste0('T', seq_along(unique(year))[match(year, sort(unique(year)))]),
           time_since_disturbance = fifelse(treatment == 'control', NA_integer_,
                                            as.numeric(year) - 2000),
           realm = 'terrestrial',
           taxon = 'invertebrates',

           comment = 'Block design with treatments being Ex (Exclosure meaning no grazing), Fe (fertilization) and Bu (burning every other year). Subadults are excluded which diminishes greatly the number of undeterminate species. Only surveys from August are kept, that is one survey per year.'
      )]


dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'), row.names = FALSE)

