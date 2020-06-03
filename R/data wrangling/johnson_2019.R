## johnson_2019
library(data.table)

dataset_id <- 'johnson_2019'
load(file='data/raw data/johnson_2019/ddata')
setDT(ddata)

# Typo correction
ddata[Nutrient == 'Referenceient_Nutrients', Nutrient := 'Reference'][,Nutrient := droplevels(Nutrient)]

# Wide to long conversion
species_columns <- grep(colnames(ddata), pattern = 'num.')
colnames(ddata) <- trimws( gsub(colnames(ddata), pattern = 'num\\.', replacement = ' ') )
ddata <- melt(ddata, measure.vars = colnames(ddata)[species_columns], variable.name = 'species', value.name = 'value')

# Deleting useless rows
ddata <- ddata[value > 0] # , grep(colnames(ddata), pattern = 'Total', value = TRUE) := NULL

timepoints <- seq_along(unique(ddata$Year))
timepoints <- paste0('T',timepoints[match(ddata$Year, unique(ddata$Year))])


fdd = ifelse(ddata$Period == 'After' & ddata$Fish == 'Low' | (ddata$Period == 'After'  & ddata$Creek == 'Sweeney' & ddata$Nutrient == 'Fertilized'), 2004,
             ifelse(ddata$Period == 'After' & ddata$Creek == 'Clubhead' & ddata$Nutrient == 'Fertilized', 2005, NA))


ddata[, ':='(site = Creek,
             year = Year,
             treatment = ifelse(Nutrient == "Reference" & Fish == 'Ambient', 'control',
                                ifelse(Nutrient == "Reference" & Fish == 'Low', 'fish manipulation',
                                       ifelse(Nutrient %in% c('Nutrient',"Fertilized") & Fish == 'Ambient', 'nutrient addition',
                                              ifelse(Nutrient %in% c('Nutrient',"Fertilized") & Fish == 'Low', 'nutrient+fish', NA)
                                       )
                                )
             ),


             timepoints = timepoints,
             fdd = fdd

             )]
ddata[, ':='(design = paste0(ifelse(Period == 'Before', 'B',
                                    ifelse(Period == 'After', 'A', NA)),
                             ifelse(treatment == 'control', 'C', 'I')),
             time_since_disturbance = year - fdd
)
]


# Standardisation
dtsampling <- ddata[order(year, treatment), .(effort = length(unique(Month))), by = .(site, year, treatment)]
dat <- ddata[, .(value = sum(value)),
             by = .(site, year, treatment, species)]
dat <- merge(dat, dtsampling, by = c('year', 'site', 'treatment'))
dat[, value := value / effort][, effort := NULL]

# Metadata
metadata <- unique(ddata[, .(site, year, treatment, fdd, timepoints, design, time_since_disturbance)])
dat <- merge(dat, metadata, by = c('year', 'site', 'treatment'))

dat[, ':='(
   dataset_id = dataset_id,
   treatment_type = 'eutrophication and community manipulation',
   realm = 'terrestrial',
   taxon = 'invertebrates',
   metric = 'density',
   unit = 'ind/m2',
   comment = 'Block design with two treatments. Treatments were applied at different times and frequencies. Treatments applied to the different sites differed so sites were not pooled together. Abundances from several samplings a year, several transects were pooled together.'
)]


dat <- dat[dat$value > 0, ]



dat <- dat[!is.na(dat$value), ]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
write.csv(dat, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '_dt.csv'),
          row.names=FALSE)
