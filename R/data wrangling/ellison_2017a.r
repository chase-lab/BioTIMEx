## ellison_2017a
library(data.table)

dataset_id <- 'ellison_2017a'
load(file = 'data/raw data/ellison_2017a/ddata')
setDT(ddata)

setnames(ddata, old = c('cham', 'subs', 'n'),
         new = c('block', 'plot', 'value'))

## misprint correction:
ddata[year == 2009 & site == 'HF' & block %in% c(3,6) & treat == 'Treat',
      target.delta := fifelse(block == 3, 2, 0)]
## Missing plot number in HF block 4 8 12 year 2010. No importance since we pool plots together
## data selection
ddata <- ddata[ method != 'Winkler' &
                  !is.na(value) & value > 0 &
                  month >= 5 & month <= 9 &
                  year != 2015]


# Community
ddata[, species := paste(genus, species),]
ddata[, n_trap := length(unique(plot)), by = .(site, block, year, treat, warming, target.delta, doy)]

ddata <- ddata[, trap_days := sum(n_trap), by = .(site, block, year, treat, warming, target.delta)]
ddata <- ddata[, .(value = sum(value)), by = .(site, block, year, treat, warming, target.delta, trap_days, species)]

ddata[, ':='(N = sum(value),
             S = length(unique(species)),
             ENSPIE = vegan::diversity(x = value, index = 'invsimpson')
),
by = .(site, block, year, treat)
]
ddata[, minN := min(N), by = .(site, block)]
#data.frame(ddata[, .(minN=min(N)), by = .(site, block, year)][order(minN)][minN<6])

ddata[, Sn := vegan::rarefy(value, sample = minN), by = .(site, block, year, treat)]

ddata[, ':='(
  singletons = sum(value == 1),
  doubletons = sum(value == 2)
), by = .(site, block, year, treat)
][,
  coverage := fifelse(
    doubletons > 0,
    1 - (singletons/N) * (((N - 1)*singletons)/((N - 1)*singletons + 2*doubletons)),
    1 - (singletons/N) * (((N - 1)*singletons)/((N - 1)*singletons + 2))
  )][, ':='(singletons = NULL, doubletons = NULL)]

ddata[, ':='(value = NULL,
             species = NULL)]
ddata <- unique(ddata)

# Treatment
warming_table <- na.omit(unique(ddata[, c('site','block','warming','target.delta')]))

warming_table[, ':='(warming = gsub(warming, pattern = ' c| C', replacement = '_c'),
                     treatment = paste(warming, target.delta, sep = '_'))
][,':='(warming = NULL,
        target.delta = NULL)]

ddata <- merge(ddata, warming_table, by = c('site', 'block'), all.x = TRUE)

ddata[, ':='(dataset_id = dataset_id,
             treatment_type = 'warming',
             grain_m2 = pi*0.025^2 * trap_days,
             grain_comment = "'each plot has [1-5] pitfall traps (5 cm diameter)' trap area * number of pifalls * number of survey per year",
             design = paste0(fifelse(treat == 'Pre-treat', 'B', "A"),
                             fifelse(grepl(treatment, pattern = 'control'), 'C', "I")),

             timepoints = paste0('T', seq_along(unique(year))[match(year, sort(unique(year)))]),
             time_since_disturbance = fifelse(treat == 'Pre-treat' | grepl(treatment, pattern = 'control'),
                                              NA_integer_,
                                              fifelse(site == 'HF',
                                                      year - 2009, year - 2010
                                              )
             ),
             realm = 'terrestrial',
             taxon = 'invertebrates',

             comment = "Block design with treatments being, no chamber, a chamber without warming, a chamber and warming with different warming intensities. Winkler samples are excluded. Repeated samplings  of 4 pitfall traps in a single year are pooled. Counts are added before computing biodiversity metrics. Effort is defined as the number of pitfall surveys per year (1 to 13). In site HF, both pre and post treatment samples were made in 2009. Only surveys carried out from May to September are used. 2015 is excluded because it covers only the beginning of the year. 2009 is included because that is pre-treatment data.",

             treat = NULL,
             target.delta = NULL,
             warming = NULL,
             trap_days = NULL
)]


dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
       row.names = FALSE)
