## johnson_2019
library(data.table)

dataset_id <- 'johnson_2019'

if(FALSE) {
      load(file='data/raw data/johnson_2019/ddata')
      setDT(ddata)

      setnames(ddata, old = c('Year', 'Creek','Habitat', 'Transect', 'Rep'),
               new = c('year', 'site', 'block', 'plot','subplot'))


      # Wide to long conversion
      species_columns <- grep(colnames(ddata), pattern = 'num.', value=T)
      colnames(ddata) <- trimws( gsub(colnames(ddata), pattern = 'num\\.', replacement = ' ') )
      ddata <- melt(ddata, measure.vars = species_columns, variable.name = 'species', value.name = 'value')
      ddata <- ddata[value > 0] # Deleting useless rows

      # Treatment
         # Typo correction
      ddata[Nutrient == 'Referenceient_Nutrients', Nutrient := 'Reference'][,Nutrient := droplevels(Nutrient)]

      ddata[, treatment := ifelse(Nutrient == "Reference" & Fish == 'Ambient', 'control',
                                  ifelse(Nutrient == "Reference" & Fish == 'Low',
                                         'fish manipulation',
                                         ifelse(Nutrient %in% c('Nutrient',"Fertilized") & Fish == 'Ambient',
                                                'nutrient addition',
                                                ifelse(Nutrient %in% c('Nutrient',"Fertilized") & Fish == 'Low',
                                                       'nutrient+fish',
                                                       NA)
                                         )
                                  )
      )
      ]

      # Standardisation
      effort <- ddata[, .(effort = length(unique(Month))), by = .(year, site, block, plot, subplot, treatment)]
      ddata <- ddata[, .(value = sum(value)), by = .(site, block, plot, subplot, year, treatment, species)]
      ddata <- merge(ddata, effort, by = c('year', 'site','block', 'plot', 'subplot', 'treatment'))

      ddata[, ':='(dataset_id = dataset_id,
                   timepoints =  paste0('T',seq_along(unique(year))[match(year, unique(year))]),

                   design = paste0(ifelse(year == 2003, 'B','A'),
                                   ifelse(treatment == 'control', 'C', 'I')),

                   time_since_disturbance = year - ifelse(year > 2003 & treatment != 'control', 2004, NA),

                   treatment_type = 'eutrophication and community manipulation',
                   realm = 'terrestrial',
                   taxon = 'invertebrates',
                   metric = 'density',
                   value = value / effort,
                   unit = 'ind/m2',
                   comment = 'Block design with two treatments. Treatments were applied at different times and frequencies. Abundances from several samplings a year were pooled together.'
      )
            ][, effort := NULL
              ]


      ddata[, ap:= ifelse(value > 0, 1, 0)][, .(N = sum(ap), S=length(unique(species))), by = .(dataset_id, site, block, plot, subplot, year)][N>S]
      ddata[site == 'West' & block == 'TSA' & plot ==1 & year == 2003]


      dir.create(paste0('data/wrangled data/', dataset_id), showWarnings = FALSE)
      fwrite(ddata, paste0('data/wrangled data/', dataset_id, "/", dataset_id, '.csv'),
                row.names=FALSE)
}
