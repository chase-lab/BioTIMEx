## ellison_2017a
library(data.table)

dataset_id <- 'ellison_2017a'
if(FALSE){
load(file='data/raw data/ellison_2017a/ddata')
setDT(ddata)

setnames(ddata, old = c('cham', 'subs', 'n'),
         new = c('block', 'plot', 'value'))

## misprint correction:
ddata[year == 2009 & site == 'HF' & block %in% c(3,6) & treat == 'Treat',
      target.delta := ifelse(block == 3, 2, 0)]

warming_table <- na.omit(unique(ddata[, c('year', 'site','block','warming','target.delta')]))

warming_table[, ':='(warming = gsub(warming, pattern = ' c| C', replacement = '_c'),
                     treatment = paste(warming, target.delta, sep = '_'))
              ][,
                ':='(warming = NULL, target.delta = NULL)]

ddata <- merge(ddata, warming_table, by = c('year', 'site', 'block'))

ddata[method != 'Winkler', ':='(species = paste(genus, species),
                                plot = trimws( toupper( plot ) ))]

ddata[,
                effort := length(unique(sampling.id)),


      # EFFORT SHOULD USE DATE INSTEAD
                by = .(site, year, block, plot, treat, treatment)] # effort is the number of surveys

ddata <- ddata[,
               .(value = as.numeric(sum(value / effort))), by = .(site, year, block, plot, treat, treatment, species)]  # abundance divided by effort
ddata[!is.na(value) & value > 0, value := value / min(value), by = .(year, site, block, plot, treat, treatment)]# standardised abundance divided by the smallest abundance

ddata[, ':='(dataset_id = dataset_id,
             treatment_type = 'warming',
             design = paste0(ifelse(treat == 'Pre-treat', 'B', "A"),
                             ifelse(grepl(treatment, pattern = 'control'), 'C', "I")),

             timepoints = paste0('T',seq_along(unique(year))[match(year, unique(year))]),
             time_since_disturbance = ifelse(treat == 'Pre-treat' | grepl(treatment, pattern = 'control'),
                                             NA,
                                             ifelse(site == 'HF',
                                                    year - 2009, year - 2010
                                             )
             ),
             realm = 'terrestrial',
             taxon = 'invertebrates',
             metric = 'count',
             unit = 'ind per survey',
             comment = "Block design with treatments being, no chamber, a chamber without warming, a chamber and warming with different warming intensities. Winkler samples are excluded. Repeated samplings in a single year are pooled. Counts are added and divided by effort. Effort is defined as the number of pitfall surveys per year (1 to 13). What's up with block/chamber 6? Its temperature changes. In site HF, both pre and post treatment samples were made in 2009.",
             treat = NULL)]


ddata <- ddata[!is.na(value) & !is.na(species) & species != 'NA NA']    # three rows have a NA value for value but there is a species name.

# ddata[, ap := ifelse(value > 0, 1, 0)][, .(N = sum(ap), S=length(unique(species))), by = .(site, block, plot, treatment, design, year)][S>N]



dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
}
