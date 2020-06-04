## carpenter_2017
library(data.table)

dataset_id <- 'carpenter_2017'
load(file='data/raw data/carpenter_2017/ddata')
setDT(ddata)

setnames(ddata, old = c( 'lakename','year4','sampledate', 'concentration'),
         new = c('site', 'year','date', 'value'))

ddata[, ':='(
   treatment = ifelse(site == "Paul Lake", 'control',
                      ifelse(site %in% c('East Long Lake', 'West Long Lake'), 'eutrophication',
                             ifelse(site %in% c('Peter Lake','Tuesday Lake'), 'community manipulation', NA)
                      )
   ),
   species = gsub( trimws( paste(
      ifelse(is.na(genus), '', as.character(genus)),
      ifelse(is.na(species), '', as.character(species)),
      ifelse(is.na(genus) & is.na(species), 'Unkown', ''),
      ifelse(is.na(genus) & is.na(species) & !is.na(description), as.character(description), ''),
      sep=' ') ), pattern = ' {2,3}', replacement = ' ')
)]

# effort
effort <- ddata[, .(effort = length(unique(date))), by = .(site, year, treatment)]
ddata <- ddata[, .(value = sum(value)), by = .(year, site, treatment, species)]
ddata <- merge(ddata, effort, by = c('year', 'site', 'treatment'))


ddata[, ':='(
   dataset_id = dataset_id,
   treatment_type = 'eutrophication and community manipulation',
   design = paste0(ifelse(site == "Paul Lake", '',
                          ifelse(
                             (site %in% c('East Long Lake', 'West Long Lake') & year < 1991)  |
                                (site %in% c('Peter Lake','Tuesday Lake') & year < 1985), 'B', 'A')
   ),
   ifelse(site == "Paul Lake", 'C', 'I')),
   timepoints = paste0('T',seq_along(unique(year))[match(year, unique(year))]),
   realm = 'freshwater',
   taxon = 'phytoplankton',
   metric = 'concentration',
   value = value / effort,
   unit = NA,  # cell/mL of water?
   comment =  'Samples from 1991 to 1995 were counted by the same person hence ensuring comparable counts. 2013 to 2015 should have consistent sampling and counting too. Time since disturbance is the difference between sampledate and the FIRST disturbance. Most manipulations are reported in ./supporting litterature/Carpenter - Table 1 - Synthesis of a 33 year-series of whole lake experiments - lol2.10094.pdf.'
)][,
   time_since_disturbance := ifelse(site %in% c('East Long Lake', 'West Long Lake') & substr(design, 1, 1) == 'A',
                                    year - 1991,
                                    ifelse(site %in% c('Peter Lake','Tuesday Lake') & substr(design, 1, 1) == 'A',
                                           year - 1985, NA)
   )][,
      effort := NULL
      ]


dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
