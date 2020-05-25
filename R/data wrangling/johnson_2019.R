## johnson_2019


dataset_id <- 'johnson_2019'
load(file='data/raw data/johnson_2019/ddata')

dat <- data.frame(dataset_id = rep(dataset_id, nrow(ddata)))

dat$year <- ddata$Year
dat$month <- match(ddata$Month, month.name)
dat$day <- NA

dat$site <- ddata$Creek
dat$block <- ddata$Branch
dat$plot <- ddata$Transect
dat$subplot <- ddata$Rep


# Typo correction
ddata[ddata$Nutrient== 'Referenceient_Nutrients', 'Nutrient'] <- 'Reference'

dat$treatment <- ifelse(ddata$Nutrient == "Reference" & ddata$Fish == 'Ambient', 'control',
                        ifelse(ddata$Nutrient == "Reference" & ddata$Fish == 'Low', 'fish manipulation',
                               ifelse(ddata$Nutrient %in% c('Nutrient',"Fertilized") & ddata$Fish == 'Ambient', 'nutrient addition',
                                      ifelse(ddata$Nutrient %in% c('Nutrient',"Fertilized") & ddata$Fish == 'Low', 'nutrient+fish', NA)
                               )
                        )
                  )
dat$treatment_type <- dat$treatment

beforeafter <- ifelse(ddata$Period == 'Before', 'B',
                      ifelse(ddata$Period == 'After', 'A', NA))
controlimpact <- ifelse(ddata$Nutrient == 'Reference', 'C',
                        ifelse(ddata$Nutrient == 'Fertilized', 'I', NA))
dat$design <- paste0(beforeafter, controlimpact)

timepoints <- seq_along(unique(ddata$sampledate))
timepoints <- paste0('T',timepoints[match(ddata$sampledate, unique(ddata$sampledate))])
dat$timepoint <- timepoints

first_disturbance_date <- as.Date(ifelse(ddata$Period == 'After' & ddata$Fish == 'Low' | (ddata$Period == 'After'  & ddata$Creek == 'Sweeney' & ddata$Nutrient == 'Fertilized'), '2004-05-01',
       ifelse(ddata$Period == 'After' & ddata$Creek == 'Clubhead' & ddata$Nutrient == 'Fertilized', '2005-05-01', NA)), format='%Y-%m-%d')

dat$time_since_disturbance_days <- ifelse(is.na(first_disturbance_date), NA,
                                          as.numeric(as.Date(paste(ddata$Year, ddata$Month, '01', sep='-'), format = '%Y-%B-%d') - first_disturbance_date)
)


dat$realm <- 'terrestrial'
dat$taxon <- 'invertebrates'


species_columns <- grep(colnames(ddata), pattern = 'num.')
colnames(ddata) <- trimws( gsub(colnames(ddata), pattern = 'num\\.', replacement = ' ') )
dat <- data.frame(dat, ddata[, species_columns])

# wide to long conversion
dat <- reshape2::melt(dat, measure.vars = colnames(ddata)[species_columns], variable.name = 'species', value.name = 'value')
dat <- dat[dat$value > 0, ]

dat$metric <- 'density'
dat$value <- dat$value * 292.4
dat$unit <- 'ind/m2'

dat$comment <- 'Block design with two treatments. Treatments were applied at different times and frequencies.'

dat <- dat[!is.na(dat$value), ]

dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
write.csv(dat, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
          row.names=FALSE)
