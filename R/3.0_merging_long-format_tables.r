## merging Wrangled data.frames
library(data.table)

# Merging
listfiles <- list.files('data/wrangled data', pattern = '.csv',
                        full.names = TRUE, recursive = T)

template <- read.csv('data/template long format.csv', h = TRUE, sep = '\t')
column_names_template <- template[,1]

lst <- lapply(listfiles, data.table::fread)
dt <- data.table::rbindlist(lst, fill = TRUE)
data.table::setcolorder(dt, column_names_template)



# Checking data
indispensable_variables <- column_names_template[as.logical(template[2,])]

if(any(is.na(dt$site) & !is.na(dt$block)) ||
   any(is.na(dt$block) & !is.na(dt$plot)) ||
   any(is.na(dt$plot) & !is.na(dt$subplot))
) {
   problematic_datasets <- unique(dt[is.na(dt$site) & !is.na(dt$block) |
                 is.na(dt$block) & !is.na(dt$plot) |
                 is.na(dt$plot) & !is.na(dt$subplot), "dataset_id"])
   warning(paste0('Review hierarchical structure in: ', paste(problematic_datasets, collapse = ", ")))
}

na_variables <- apply(dt[, .(indispensable_variables)], 2, function(variable) any(is.na(variable)))
if(any(na_variables))   {

   na_variables_names <- indispensable_variables[na_variables]
   # warning(paste0('NA values in columns ', paste(na_variables_names, collapse = ", ")))

   for(na_variable in na_variables_names) {
      warning(paste0('The variable -', na_variable, '- has missing values in the following datasets: ', paste(unique(dt[is.na(dt[, .(na_variable)]), 'dataset_id']), collapse = ', ')))
   }

}
if( any(!is.na(dt$time_since_disturbance_days) & dt$time_since_disturbance_days < 0) ) {
   problematic_studies <- unique(dt[!is.na(dt$time_since_disturbance_days) & dt$time_since_disturbance_days < 0, 'dataset_id'])
   warning(paste0('Negative values in "time_since_disturbance_days" in: ', paste(problematic_studies, collapse = ', ')))
}

nrow(dt[design %like% 'C' & !is.na(time_since_disturbance)]) == 0
unique(dt[design %like% 'C' & !is.na(time_since_disturbance), .(dataset_id)])



## S > N
verifSN <- dt[, ap := ifelse(value > 0, 1, 0)][, .(N = sum(ap), S=length(unique(species))), by = .(dataset_id, site, block, plot, subplot, year)][S>N] # this shows that in some cases the site block plot subplot structure does not cover treatments ( site A, block 2, plot3 can exist with both control and impact treatments)
unique(verifSN[,.(dataset_id)])
# unique(dt[dataset_id == 'ellison_2017a' & site == 'HF' & block == 6])


## N > S
verifNS <- dt[, .(N = sum(ap), S=length(unique(species))), by = .(dataset_id, site, block, plot, subplot, year)][N>S] # this shows that in some cases species are not present in only one row as they should.
unique(verifNS[,.(dataset_id)])
dt[dataset_id == 'fridley_2009' & site == 'B' & block == 'B9' & year == 2009] # One species is present in two rows.
dt[dataset_id == 'hershey_2016'] # One species is present in two rows.

# end of testing
dt[, ap := NULL]


## Counting the study cases
study_cases <- unique(dt[grep('C', dt$design, invert = T), c('dataset_id','treatment')])
nrow(study_cases)
sort(table(study_cases$dataset_id), decreasing=T)


# Saving

data.table::fwrite(dt, 'data/long_table.csv', row.names = F)
