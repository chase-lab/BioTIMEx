# ellison_2017b
# ANTS in CHAMBERS


# Package ID: knb-lter-hfr.113.57 Cataloging System:https://pasta.edirepository.org.
# Data set title: Ants Under Climate Change at Harvard Forest and Duke Forest 2009-2015.
# Data set creator:  Aaron Ellison -
# Data set creator:  Robert Dunn -
# Contact:  Aaron Ellison -  Harvard Forest  - aellison@fas.harvard.edu
# Stylesheet v2.10 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu




# hf113-18-hf-cham-ants.csv

infile18 <- 'data/raw data/ellison_2017a/hf113-18-hf-cham-ants.csv'
if(!dir.exists('data/raw data/ellison_2017a/') || !file.exists(infile18))   {
   dir.create('data/raw data/ellison_2017a/', showWarnings = FALSE)
   inUrl18  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-hfr/113/57/3863c9f86b760a9339f7e999d1aab4eb"
   download.file(inUrl18,infile18,method="curl")
}



dt18 <-read.csv(infile18,header=F
                ,skip=1
                ,sep=","
                , col.names=c(
                   "sampling.id",
                   "site",
                   "date",
                   "month",
                   "day",
                   "year",
                   "doy",
                   "cham",
                   "subs",
                   "treat",
                   "warming",
                   "target.delta",
                   "method",
                   "id",
                   "genus",
                   "species",
                   "n",
                   "unique.id",
                   "caste",
                   "notes",
                   "pinned"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt18$sampling.id)!="factor") dt18$sampling.id<- as.factor(dt18$sampling.id)
if (class(dt18$site)!="factor") dt18$site<- as.factor(dt18$site)
# attempting to convert dt18$date dateTime string to R date structure (date or POSIXct)
tmpDateFormat<-"%Y-%m-%d"
tmp18date<-as.Date(dt18$date,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp18date) == length(tmp18date[!is.na(tmp18date)])){dt18$date <- tmp18date } else {print("Date conversion failed for dt18$date. Please inspect the data and do the date conversion yourself.")}
rm(tmpDateFormat,tmp18date)
if (class(dt18$doy)=="factor") dt18$doy <-as.numeric(levels(dt18$doy))[as.integer(dt18$doy) ]
if (class(dt18$doy)=="character") dt18$doy <-as.numeric(dt18$doy)
if (class(dt18$cham)!="factor") dt18$cham<- as.factor(dt18$cham)
if (class(dt18$treat)!="factor") dt18$treat<- as.factor(dt18$treat)
if (class(dt18$warming)!="factor") dt18$warming<- as.factor(dt18$warming)
if (class(dt18$target.delta)=="factor") dt18$target.delta <-as.numeric(levels(dt18$target.delta))[as.integer(dt18$target.delta) ]
if (class(dt18$target.delta)=="character") dt18$target.delta <-as.numeric(dt18$target.delta)
if (class(dt18$method)!="factor") dt18$method<- as.factor(dt18$method)
if (class(dt18$id)!="factor") dt18$id<- as.factor(dt18$id)
if (class(dt18$genus)!="factor") dt18$genus<- as.factor(dt18$genus)
if (class(dt18$species)!="factor") dt18$species<- as.factor(dt18$species)
if (class(dt18$n)=="factor") dt18$n <-as.numeric(levels(dt18$n))[as.integer(dt18$n) ]
if (class(dt18$n)=="character") dt18$n <-as.numeric(dt18$n)
if (class(dt18$unique.id)!="factor") dt18$unique.id<- as.factor(dt18$unique.id)
if (class(dt18$caste)!="factor") dt18$caste<- as.factor(dt18$caste)
if (class(dt18$notes)!="factor") dt18$notes<- as.factor(dt18$notes)
if (class(dt18$pinned)=="factor") dt18$pinned <-as.numeric(levels(dt18$pinned))[as.integer(dt18$pinned) ]
if (class(dt18$pinned)=="character") dt18$pinned <-as.numeric(dt18$pinned)

# Convert Missing Values to NA for non-dates

dt18$target.delta <- ifelse((trimws(as.character(dt18$target.delta))==trimws("NA")),NA,dt18$target.delta)
dt18$genus <- as.factor(ifelse((trimws(as.character(dt18$genus))==trimws("NA")),NA,as.character(dt18$genus)))
dt18$species <- as.factor(ifelse((trimws(as.character(dt18$species))==trimws("NA")),NA,as.character(dt18$species)))
dt18$n <- ifelse((trimws(as.character(dt18$n))==trimws("NA")),NA,dt18$n)
dt18$pinned <- ifelse((trimws(as.character(dt18$pinned))==trimws("NA")),NA,dt18$pinned)

if(FALSE) {      # MANU ISSUES HAVE TO BE CHECKED HERE ID SPECIFICALLY
   # Here is the structure of the input data frame:
   str(dt18)
   attach(dt18)
   # The analyses below are basic descriptions of the variables. After testing, they should be replaced.

   summary(sampling.id)
   summary(site)
   summary(date)
   summary(month)
   summary(day)
   summary(year)
   summary(doy)
   summary(cham)
   summary(subs)
   summary(treat)
   summary(warming)   # NA values when pre treatment
   summary(target.delta)   # NA values when pre treatment
   summary(method)
   summary(id)
   summary(genus)   # NA values for empty cells
   summary(species)   # NA values for empty cells
   summary(n)   # NA values for empty cells
   summary(unique.id)
   summary(caste)
   summary(notes)
   summary(pinned)
   detach(dt18)
}



# hf113-21-df-cham-ants.csv

infile21 <- 'data/raw data/ellison_2017a/hf113-21-df-cham-ants.csv'
if(!dir.exists('data/raw data/ellison_2017a/') || !file.exists(infile21))   {
   dir.create('data/raw data/ellison_2017a/', showWarnings = FALSE)
   inUrl21  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-hfr/113/57/6df2d60f7e3e0d015b93234ab67eac69"
   download.file(inUrl21,infile21,method="curl")
}




dt21 <-read.csv(infile21,header=F
                ,skip=1
                ,sep=","
                , col.names=c(
                   "sampling.id",
                   "site",
                   "date",
                   "month",
                   "day",
                   "year",
                   "doy",
                   "cham",
                   "subs",
                   "treat",
                   "method",
                   "id",
                   "genus",
                   "species",
                   "n",
                   "caste",
                   "notes",
                   "pinned",
                   "warming",
                   "target.delta"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt21$sampling.id)!="factor") dt21$sampling.id<- as.factor(dt21$sampling.id)
if (class(dt21$site)!="factor") dt21$site<- as.factor(dt21$site)
# attempting to convert dt21$date dateTime string to R date structure (date or POSIXct)
tmpDateFormat<-"%Y-%m-%d"
tmp21date<-as.Date(dt21$date,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp21date) == length(tmp21date[!is.na(tmp21date)])){dt21$date <- tmp21date } else {print("Date conversion failed for dt21$date. Please inspect the data and do the date conversion yourself.")}
rm(tmpDateFormat,tmp21date)
if (class(dt21$doy)=="factor") dt21$doy <-as.numeric(levels(dt21$doy))[as.integer(dt21$doy) ]
if (class(dt21$doy)=="character") dt21$doy <-as.numeric(dt21$doy)
if (class(dt21$cham)!="factor") dt21$cham<- as.factor(dt21$cham)
if (class(dt21$subs)!="factor") dt21$subs<- as.factor(dt21$subs)
if (class(dt21$treat)!="factor") dt21$treat<- as.factor(dt21$treat)
if (class(dt21$method)!="factor") dt21$method<- as.factor(dt21$method)
if (class(dt21$id)!="factor") dt21$id<- as.factor(dt21$id)
if (class(dt21$genus)!="factor") dt21$genus<- as.factor(dt21$genus)
if (class(dt21$species)!="factor") dt21$species<- as.factor(dt21$species)
if (class(dt21$n)=="factor") dt21$n <-as.numeric(levels(dt21$n))[as.integer(dt21$n) ]
if (class(dt21$n)=="character") dt21$n <-as.numeric(dt21$n)
if (class(dt21$caste)!="factor") dt21$caste<- as.factor(dt21$caste)
if (class(dt21$notes)!="factor") dt21$notes<- as.factor(dt21$notes)
if (class(dt21$pinned)=="factor") dt21$pinned <-as.numeric(levels(dt21$pinned))[as.integer(dt21$pinned) ]
if (class(dt21$pinned)=="character") dt21$pinned <-as.numeric(dt21$pinned)
if (class(dt21$warming)!="factor") dt21$warming<- as.factor(dt21$warming)
if (class(dt21$target.delta)=="factor") dt21$target.delta <-as.numeric(levels(dt21$target.delta))[as.integer(dt21$target.delta) ]
if (class(dt21$target.delta)=="character") dt21$target.delta <-as.numeric(dt21$target.delta)

# Convert Missing Values to NA for non-dates

dt21$n <- ifelse((trimws(as.character(dt21$n))==trimws("NA")),NA,dt21$n)
dt21$pinned <- ifelse((trimws(as.character(dt21$pinned))==trimws("NA")),NA,dt21$pinned)
dt21$target.delta <- ifelse((trimws(as.character(dt21$target.delta))==trimws("NA")),NA,dt21$target.delta)

if(FALSE) {
      # Here is the structure of the input data frame:
      str(dt21)
      attach(dt21)
      # The analyses below are basic descriptions of the variables. After testing, they should be replaced.

      summary(sampling.id)
      summary(site)
      summary(date)
      summary(month)
      summary(day)
      summary(year)
      summary(doy)
      summary(cham)
      summary(subs)   # typos to correct
      summary(treat)
      summary(method)
      summary(id)
      summary(genus)
      summary(species)
      summary(n)
      summary(caste)
      summary(notes)
      summary(pinned)
      summary(warming)
      summary(target.delta)
      detach(dt21)
}

# Deleting Winkler samples
dt18 <- subset(dt18, method != 'Winkler')

# Merging and saving
dt18 <- dt18[, colnames(dt18) != 'unique.id']
dt21 <- dt21[, match(colnames(dt18), colnames(dt21))]

ddata <- rbind(dt18, dt21)
ddata <- ddata[!is.na(ddata$sampling.id) & !is.na(ddata$genus) & !is.na(ddata$species) & !is.na(ddata$n) & ddata$n > 0, ]

save(ddata, file = 'data/raw data/ellison_2017a/ddata')



