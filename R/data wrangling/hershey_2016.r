## hershey_2016
library(data.table)

dataset_id <- 'hershey_2016'
load(file=paste0('data/raw data/',dataset_id, '/ddata'))
setDT(ddata)

setnames(ddata, c('station.m', 'Trial', 'Date'),
         c('site', 'block', 'date'))
# reshaping the data
ddata <- melt(ddata,
              measure.vars = c('RHYAC','BRACHY','NATARSIA','ORTHO','OTHCHIR','CHIPUPA','BLACK','BLKPUPA','BAETIS','BAETSP3','EPHEM','CINYG','NEMOURA','TIPULA','SNAILS'),
              variable.name = 'species',
              value.name = 'value')[value > 0 & !is.na(value)]

ddata[, ':='(
   dataset_id = dataset_id,
   year = as.integer(format(as.Date(date, '%d-%b-%y'), '%Y')),
   site =  ifelse(abs(as.numeric(trimws(gsub(x=site, pattern='K|k', replacement='')))) < 10,
                  as.numeric(trimws(gsub(x=site, pattern='K|k', replacement=''))) * 1000,
                  as.numeric(trimws(gsub(x=site, pattern='K|k', replacement=''))))

)]

ddata[, effort := length(unique(date)), by = .(site, block, year)]

ddata[,
   ':='(treatment = paste(ifelse(site < 0, 'control', 'impact'), site, sep='_'),
        treatment_type = "eutrophication",
        design = paste0('A', ifelse(site < 0, 'C', 'I')),
        timepoints = paste0('T',seq_along(unique(year))[match(year, unique(year))]),
        time_since_disturbance = ifelse(site < 0, NA, year - 1984),

        realm = 'freshwater',
        taxon = 'invertebrates',
        metric = 'count',
        # value = value /effort, #?
        unit = 'ind per sample',

        comment = 'Treatment variable shows the distance above (negative values) and downstream (positive values) of a nutrient source.',

        effort = NULL,
        Site = NULL,
        Stream.Type = NULL,
        Sample.Type = NULL,
        date = NULL
   )
   ][,
     site := paste0('site_', site)
     ]


dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
       row.names=FALSE)
