## merging Wrangled data.frames
library(data.table)

# Merging
listfiles <- list.files('data/wrangled data', pattern = '.csv',
                        full.names = TRUE, recursive = T)

template <- read.csv('data/template long format.txt', h = TRUE, sep = '\t')
column_names_template <- template[,1]

lst <- lapply(listfiles, data.table::fread)
dt <- data.table::rbindlist(lst, fill = TRUE)
data.table::setcolorder(dt, column_names_template)



# Checking data
indispensable_variables <- column_names_template[as.logical(template[,2])]

if (any(is.na(dt$site) & !is.na(dt$block)) ||
    any(is.na(dt$block) & !is.na(dt$plot)) ||
    any(is.na(dt$plot) & !is.na(dt$subplot))
) {
   problematic_datasets <- unique(dt[is.na(dt$site) & !is.na(dt$block) |
                                        is.na(dt$block) & !is.na(dt$plot) |
                                        is.na(dt$plot) & !is.na(dt$subplot), "dataset_id"])
   warning(paste0('Review hierarchical structure in: ', paste(problematic_datasets, collapse = ", ")))
}

na_variables <- apply(dt[, .(indispensable_variables)], 2, function(variable) any(is.na(variable)))
if (any(na_variables))   {

   na_variables_names <- indispensable_variables[na_variables]
   # warning(paste0('NA values in columns ', paste(na_variables_names, collapse = ", ")))

   for (na_variable in na_variables_names) {
      warning(paste0('The variable -', na_variable, '- has missing values in the following datasets: ', paste(unique(dt[is.na(dt[, .(na_variable)]), 'dataset_id']), collapse = ', ')))
   }

}
if ( any(!is.na(dt$time_since_disturbance_days) & dt$time_since_disturbance_days < 0) ) {
   problematic_studies <- unique(dt[!is.na(dt$time_since_disturbance_days) & dt$time_since_disturbance_days < 0, 'dataset_id'])
   warning(paste0('Negative values in "time_since_disturbance_days" in: ', paste(problematic_studies, collapse = ', ')))
}



## Counting the study cases
study_cases <- unique(dt[grep('C', dt$design, invert = T), c('dataset_id','treatment')])
nrow(study_cases)
sort(table(study_cases$dataset_id), decreasing = T)


# Saving

data.table::fwrite(dt, 'data/long_table.csv', row.names = F, quote = TRUE)
# data.table::fwrite(dt, 'C:/Users/as80fywe/Dropbox/BioTIMEx/long_table.csv', row.names = F)

