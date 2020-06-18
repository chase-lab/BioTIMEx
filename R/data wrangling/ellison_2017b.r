## ellison_2017b
# correct typos in subs, method

dataset_id <- 'ellison_2017b'
load(file='data/raw data/ellison_2017b/ddata')
setDT(ddata)

setnames(ddata, old = c('cham', 'subs', 'n'),
         new = c('site', 'block', 'value'))

ddata[, ':='(year = format(date, '%Y'),
             treat = gsub(' ', '_', treat),
             species = ifelse(!is.na(species),
                              as.character(species),
                              paste0(genus, ' sp.'))
)
][,
  treat := gsub('chamberless', 'chamberless_cont', treat)
  ]


warming_table <- unique(ddata[treat != 'pre-treat', c('site','treat','warming')])

warming_table[, ':='(treatment = paste(treat, ifelse(!is.na(warming), warming, 0), sep = '_'))
              ]

ddata <- merge(ddata, warming_table, by = c('site'))


# Standardisation
effort <- ddata[, .(effort = length(unique(date))), by = .(year, site, block, treatment)]
ddata <- ddata[, .(value = sum(value)), by = .(site, block, year, treatment, species)]
ddata <- merge(ddata, effort, by = c('year', 'site', 'block', 'treatment'))
ddata[, value := value / effort]
ddata[!is.na(value) & value > 0, value := value / min(value), by = .(year, site, block, treatment)]

ddata[, ':='(
   dataset_id = dataset_id,

   treatment_type = 'warming',
   time_since_disturbance = ifelse(treatment == 'pre-treat' | grepl(treatment, pattern = 'cham'), NA, 1),
   timepoints = paste0('T', seq_along(unique(year))[match(year, unique(year))]),
   design = paste0(ifelse(treatment == 'pre-treat', 'B', "A"),
                   ifelse(grepl(treatment, pattern = 'cham'), 'C', "I")),
   realm = 'terrestrial',
   taxon = 'invertebrates',
   metric = 'count',
   unit = 'ind per survey',
   comment =  'Block design with treatments being, no chamber, a chamber without warming, a chamber and warming with different warming intensities. No Winkler samples in this dataset. Repeated samplings in a single year are pooled. Counts are added and divided by effort. Effort is defined as the number of surveys per year (1 to 4).',

   # warming = NULL,
   # treat = NULL,
   effort = NULL
)
]


dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)

