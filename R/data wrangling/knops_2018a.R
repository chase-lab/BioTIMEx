## knops_2018a
library(data.table)

dataset_id <- 'knops_2018a'
load(file='data/raw data/knops_2018a/ddata')
setDT(ddata)

setnames(ddata, c('Plot','nSpecimens','Date'), c('site','value','date'))

ddata[, ':='(year = format(date, '%Y'),
             month = format(date, '%m'),
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

ddata <- ddata[,
               lapply(.SD, mean),
               by = .(site, block, treatment, year),
               .SDcols = c('N','S','Sn','ENSPIE')
               ]


ddata[,
             ':='(dataset_id = dataset_id,
                  treatment_type = 'prairie management',
                  timepoints = paste0('T',seq_along(unique(year))[match(year, unique(year))]),
                  design = paste0('A', ifelse(treatment == 'control', 'C', "I")),
                  time_since_disturbance = ifelse(treatment == 'control', NA,
                                                  as.numeric(year) - 2000),
                  realm = 'terrestrial',
                  taxon = 'invertebrates',

                  comment = 'Block design with treatments being Ex (Exclosure meaning no grazing), Fe (fertilization) and Bu (burning every other year). Subadults are excluded which  diminishes greatly the number of undeterminate species.'
                  )]


dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
