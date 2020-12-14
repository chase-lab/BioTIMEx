## knops_2018b
library(data.table)

dataset_id <- 'knops_2018b'
load(file = 'data/raw data/knops_2018b/ddata')
setDT(ddata)

setnames(ddata, c('Year','Plot'), c('year','site'))

ddata <- melt(ddata, id.vars = 1:6, variable.name = 'species', value.name = 'value')
ddata <- ddata[value > 0][order(year, site, species)]

ddata[, ':='(treatment = paste0(
   fifelse(Fencing == 1, 'Ex', ''),
   fifelse(Fertilization > 0, paste0('Fe', Fertilization), ''),
   fifelse(Burning == 1, 'Bu', '')
)
)][,
   treatment := fifelse(treatment == '', 'control', treatment)
   ]

# community
ddata[, effort := Trapnights / min(Trapnights)]
ddata[,
      ':='(N = sum(value) / effort,
           ENSPIE = vegan::diversity(x = value, index = 'invsimpson')
      ),
      by = .(year, site)
      ]

ddata[, S := vegan::rarefy(value, sample = round(sum(value) / effort), 0), by = .(year, site)]

# Sn
ddata[, minN := round(min(N), 0), by = .(site, treatment)] # 0% minN < 6
ddata[, Sn := vegan::rarefy(value, sample = minN), by = .(site, treatment, year)]

ddata[, ':='(
   singletons = sum(value == 1),
   doubletons = sum(value == 2)
), by = .(site, treatment, year)
][,
  coverage := fifelse(
     doubletons > 0,
     1 - (singletons/N) * (((N - 1)*singletons)/((N - 1)*singletons + 2*doubletons)),
     1 - (singletons/N) * (((N - 1)*singletons)/((N - 1)*singletons + 2))
  )][, ':='(singletons = NULL, doubletons = NULL)]


ddata[,
      ':='(   dataset_id = dataset_id,
              treatment_type = 'prairie management',
              timepoints = paste0('T',seq_along(unique(year))[match(year, unique(year))]),
              design = paste0('A', ifelse(treatment == 'control', 'C', "I")),
              time_since_disturbance = ifelse(treatment == 'control', NA,
                                              as.numeric(year) - 2000),
              realm = 'terrestrial',
              taxon = 'mammals',

              comment = 'Block design with treatments being Ex (Exclosure meaning no grazing), Fe (fertilization (0 + 2 dosages)) and Bu (burning every other year). Effort is standardised by the smallest effort. N is standardised by the relative effort. S is the exected richness for N while Sn is the expected richness for minN.',

              species = NULL,
              value = NULL,

              Fencing = NULL,
              Fertilization = NULL,
              Burning = NULL,
              Trapnights = NULL
      )]

ddata <- unique(ddata)

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'), row.names = FALSE)

