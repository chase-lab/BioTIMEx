## merging Wrangled data.frames


# Merging
listfiles <- list.files('data/wrangled data', pattern = '.csv',
                        full.names = TRUE, recursive = T)

template <- read.csv('data/template long format.csv', h = FALSE, nrows = 2)[,-1]
column_names_template <- unlist(template[1,])

long_table <- data.frame()
for(path in listfiles) {
   tmp <- read.csv(path, header = TRUE)
   if(!setequal(colnames(tmp), column_names_template)) warning(paste0('Check column names for ', path))
   tmp <- tmp[, match(column_names_template, colnames(tmp))]
   long_table <- rbind(long_table, tmp)
}





# Checking data
indispensable_variables <- column_names_template[as.logical(template[2,])]

if(any(is.na(long_table$site) & !is.na(long_table$block)) ||
   any(is.na(long_table$block) & !is.na(long_table$plot)) ||
   any(is.na(long_table$plot) & !is.na(long_table$subplot))
) {
   problematic_datasets <- unique(long_table[is.na(long_table$site) & !is.na(long_table$block) |
                 is.na(long_table$block) & !is.na(long_table$plot) |
                 is.na(long_table$plot) & !is.na(long_table$subplot), "dataset_id"])
   warning(paste0('Review hierarchical structure in: ', paste(problematic_datasets, collapse = ", ")))
}

na_variables <- apply(long_table[, indispensable_variables], 2, function(variable) any(is.na(variable)))
if(any(na_variables))   {

   na_variables_names <- indispensable_variables[na_variables]
   # warning(paste0('NA values in columns ', paste(na_variables_names, collapse = ", ")))

   for(na_variable in na_variables_names) {
      warning(paste0('The variable -', na_variable, '- has missing values in the following datasets: ', paste(unique(long_table[is.na(long_table[, na_variable]), 'dataset_id']), collapse = ', ')))
   }

}
if( any(!is.na(long_table$time_since_disturbance_days) & long_table$time_since_disturbance_days < 0) ) {
   problematic_studies <- unique(long_table[!is.na(long_table$time_since_disturbance_days) & long_table$time_since_disturbance_days < 0, 'dataset_id'])
   warning(paste0('Negative values in "time_since_disturbance_days" in: ', paste(problematic_studies, collapse = ', ')))
}


## Counting the study cases
study_cases <- unique(long_table[grep('cont', long_table$treatment, invert = T), c('dataset_id','treatment')])
nrow(study_cases)
sort(table(study_cases$dataset_id), decreasing=T)


# Saving
write.csv(long_table, 'data/long_table.csv', row.names = F)
