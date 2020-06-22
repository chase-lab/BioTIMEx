## knops_2018b
library(data.table)

dataset_id <- 'knops_2018b'
if(FALSE){
load(file='data/raw data/knops_2018b/ddata')
setDT(ddata)

setnames(ddata, c('Year','Plot'), c('year','site'))

ddata <- melt(ddata, id.vars = 1:6, variable.name = 'species', value.name = 'value')
ddata <- ddata[value > 0][order(year, site, species)]

ddata[, ':='(treatment = paste0(
   ifelse(Fencing == 1, 'Ex', ''),
   ifelse(Fertilization > 0, paste0('Fe', Fertilization), ''),
   ifelse(Burning == 1, 'Bu', '')
)
)
][,
  treatment := ifelse(treatment == '', 'control', treatment)
  ]

ddata[, relEffort := Trapnights /min(Trapnights)]
ddata[, ':='(N = sum(value) / relEffort,
             S = NA,
             ENSPIE = vegan::diversity(x = sum(value), index = 'invsimpson')
),
by = .(year, site)
]

# Minimal abundance
# ddata[, min(N) >= 6, by = site]
ddata[, minN := min(N), by = .(site, treatment)] # 0% minN < 6

ddata[, Sn := NA] # vegan::rarefy(value, sample = minN), by = .(site, treatment, year)]

ddata <- ddata[,
               lapply(.SD, mean),
               by = .(site, treatment, year),
               .SDcols = c('N','minN','S','Sn','ENSPIE')
               ]



ddata[,
      ':='(   dataset_id = dataset_id,
              treatment_type = 'prairie management',
              timepoints = paste0('T',seq_along(unique(year))[match(year, unique(year))]),
              design = paste0('A', ifelse(treatment == 'control', 'C', "I")),
              time_since_disturbance = ifelse(treatment == 'control', NA,
                                              as.numeric(year) - 2000),
              realm = 'terrestrial',
              taxon = 'mammals',

              comment = 'Block design with treatments being Ex (Exclosure meaning no grazing), Fe (fertilization (0 + 2 dosages)) and Bu (burning every other year).',

              Fencing = NULL,
              Fertilization = NULL,
              Burning = NULL,
              Trapnights = NULL
      )]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
       row.names=FALSE)
}
