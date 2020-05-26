









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
      summary(warming)
      summary(target.delta)
      summary(method)
      summary(id)
      summary(genus)
      summary(species)
      summary(n)
      summary(unique.id)
      summary(caste)
      summary(notes)
      summary(pinned)
      detach(dt18)
}



# hf113-19-hf-mini-ants.csv



infile19 <- 'data/raw data/ellison_2017a/hf113-19-hf-mini-ants.csv'
if(!dir.exists('data/raw data/ellison_2017a/') || !file.exists(infile19))   {
   dir.create('data/raw data/ellison_2017a/', showWarnings = FALSE)
   inUrl19  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-hfr/113/57/f1f65a2b3eb1dbc16688b07ca3f6acc5"
   download.file(inUrl19,infile19,method="curl")
}




dt19 <-read.csv(infile19,header=F
                ,skip=1
                ,sep=","
                , col.names=c(
                   "date",
                   "cham",
                   "treat",
                   "method",
                   "id",
                   "id.date",
                   "genus",
                   "species",
                   "code",
                   "caste",
                   "n"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

# attempting to convert dt19$date dateTime string to R date structure (date or POSIXct)
tmpDateFormat<-"%Y-%m-%d"
tmp19date<-as.Date(dt19$date,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp19date) == length(tmp19date[!is.na(tmp19date)])){dt19$date <- tmp19date } else {print("Date conversion failed for dt19$date. Please inspect the data and do the date conversion yourself.")}
rm(tmpDateFormat,tmp19date)
if (class(dt19$cham)!="factor") dt19$cham<- as.factor(dt19$cham)
if (class(dt19$treat)!="factor") dt19$treat<- as.factor(dt19$treat)
if (class(dt19$method)!="factor") dt19$method<- as.factor(dt19$method)
if (class(dt19$id)!="factor") dt19$id<- as.factor(dt19$id)
if (class(dt19$id.date)!="factor") dt19$id.date<- as.factor(dt19$id.date)
if (class(dt19$genus)!="factor") dt19$genus<- as.factor(dt19$genus)
if (class(dt19$species)!="factor") dt19$species<- as.factor(dt19$species)
if (class(dt19$code)!="factor") dt19$code<- as.factor(dt19$code)
if (class(dt19$caste)!="factor") dt19$caste<- as.factor(dt19$caste)
if (class(dt19$n)=="factor") dt19$n <-as.numeric(levels(dt19$n))[as.integer(dt19$n) ]
if (class(dt19$n)=="character") dt19$n <-as.numeric(dt19$n)

# Convert Missing Values to NA for non-dates

dt19$id.date <- as.factor(ifelse((trimws(as.character(dt19$id.date))==trimws("NA")),NA,as.character(dt19$id.date)))
dt19$genus <- as.factor(ifelse((trimws(as.character(dt19$genus))==trimws("NA")),NA,as.character(dt19$genus)))
dt19$species <- as.factor(ifelse((trimws(as.character(dt19$species))==trimws("NA")),NA,as.character(dt19$species)))
dt19$code <- as.factor(ifelse((trimws(as.character(dt19$code))==trimws("NA")),NA,as.character(dt19$code)))
dt19$caste <- as.factor(ifelse((trimws(as.character(dt19$caste))==trimws("NA")),NA,as.character(dt19$caste)))
dt19$n <- ifelse((trimws(as.character(dt19$n))==trimws("NA")),NA,dt19$n)


# Here is the structure of the input data frame:
str(dt19)
attach(dt19)
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.

summary(date)
summary(cham)
summary(treat)
summary(method)
summary(id)
summary(id.date)
summary(genus)
summary(species)
summary(code)
summary(caste)
summary(n)
detach(dt19)



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
summary(subs)
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











# hf113-22-df-mini-ants.csv
infile22 <- 'data/raw data/ellison_2017a/hf113-22-df-mini-ants.csv'
if(!dir.exists('data/raw data/ellison_2017a/') || !file.exists(infile22))   {
   dir.create('data/raw data/ellison_2017a/', showWarnings = FALSE)
   inUrl22  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-hfr/113/57/8c07e31460e0b4691bb5c60420a38bd2"
   download.file(inUrl22,infile22,method="curl")
}



dt22 <-read.csv(infile22,header=F
                ,skip=1
                ,sep=","
                , col.names=c(
                   "date",
                   "cham",
                   "treat",
                   "method",
                   "species",
                   "n"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

# attempting to convert dt22$date dateTime string to R date structure (date or POSIXct)
tmpDateFormat<-"%Y-%m-%d"
tmp22date<-as.Date(dt22$date,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp22date) == length(tmp22date[!is.na(tmp22date)])){dt22$date <- tmp22date } else {print("Date conversion failed for dt22$date. Please inspect the data and do the date conversion yourself.")}
rm(tmpDateFormat,tmp22date)
if (class(dt22$cham)!="factor") dt22$cham<- as.factor(dt22$cham)
if (class(dt22$treat)!="factor") dt22$treat<- as.factor(dt22$treat)
if (class(dt22$method)!="factor") dt22$method<- as.factor(dt22$method)
if (class(dt22$species)!="factor") dt22$species<- as.factor(dt22$species)
if (class(dt22$n)=="factor") dt22$n <-as.numeric(levels(dt22$n))[as.integer(dt22$n) ]
if (class(dt22$n)=="character") dt22$n <-as.numeric(dt22$n)

# Convert Missing Values to NA for non-dates

dt22$n <- ifelse((trimws(as.character(dt22$n))==trimws("NA")),NA,dt22$n)


# Here is the structure of the input data frame:
str(dt22)
attach(dt22)
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.

summary(date)
summary(cham)
summary(treat)
summary(method)
summary(species)
summary(n)
detach(dt22)





# hf113-32-hf-cham-spiders.csv
infile32 <- 'data/raw data/ellison_2017a/hf113-32-hf-cham-spiders.csv'
if(!dir.exists('data/raw data/ellison_2017a/') || !file.exists(infile32))   {
   dir.create('data/raw data/ellison_2017a/', showWarnings = FALSE)
   inUrl32  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-hfr/113/57/41689a38e0a3c6138e24e1c987dc028c"
   download.file(inUrl32,infile32,method="curl")
}






dt32 <-read.csv(infile32,header=F
                ,skip=1
                ,sep=","
                , col.names=c(
                   "date",
                   "cham",
                   "subs",
                   "treat",
                   "warming",
                   "method",
                   "id",
                   "genus",
                   "species",
                   "n"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

# attempting to convert dt32$date dateTime string to R date structure (date or POSIXct)
tmpDateFormat<-"%Y-%m-%d"
tmp32date<-as.Date(dt32$date,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp32date) == length(tmp32date[!is.na(tmp32date)])){dt32$date <- tmp32date } else {print("Date conversion failed for dt32$date. Please inspect the data and do the date conversion yourself.")}
rm(tmpDateFormat,tmp32date)
if (class(dt32$cham)!="factor") dt32$cham<- as.factor(dt32$cham)
if (class(dt32$subs)!="factor") dt32$subs<- as.factor(dt32$subs)
if (class(dt32$treat)!="factor") dt32$treat<- as.factor(dt32$treat)
if (class(dt32$warming)=="factor") dt32$warming <-as.numeric(levels(dt32$warming))[as.integer(dt32$warming) ]
if (class(dt32$warming)=="character") dt32$warming <-as.numeric(dt32$warming)
if (class(dt32$method)!="factor") dt32$method<- as.factor(dt32$method)
if (class(dt32$id)!="factor") dt32$id<- as.factor(dt32$id)
if (class(dt32$genus)!="factor") dt32$genus<- as.factor(dt32$genus)
if (class(dt32$species)!="factor") dt32$species<- as.factor(dt32$species)
if (class(dt32$n)=="factor") dt32$n <-as.numeric(levels(dt32$n))[as.integer(dt32$n) ]
if (class(dt32$n)=="character") dt32$n <-as.numeric(dt32$n)

# Convert Missing Values to NA for non-dates

dt32$warming <- ifelse((trimws(as.character(dt32$warming))==trimws("NA")),NA,dt32$warming)
dt32$n <- ifelse((trimws(as.character(dt32$n))==trimws("NA")),NA,dt32$n)


# Here is the structure of the input data frame:
str(dt32)
attach(dt32)
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.

summary(date)
summary(cham)
summary(subs)
summary(treat)
summary(warming)
summary(method)
summary(id)
summary(genus)
summary(species)
summary(n)
detach(dt32)



# hf113-33-hf-mini-spider.csv
infile33 <- 'data/raw data/ellison_2017a/hf113-33-hf-mini-spider.csv'
if(!dir.exists('data/raw data/ellison_2017a/') || !file.exists(infile33))   {
   dir.create('data/raw data/ellison_2017a/', showWarnings = FALSE)
   inUrl33  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-hfr/113/57/88c2fb3951064c80c9b262776e99d9c9"
   download.file(inUrl33,infile33,method="curl")
}





dt33 <-read.csv(infile33,header=F
                ,skip=1
                ,sep=","
                , col.names=c(
                   "date",
                   "cham",
                   "treat",
                   "method",
                   "genus",
                   "species",
                   "n"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

# attempting to convert dt33$date dateTime string to R date structure (date or POSIXct)
tmpDateFormat<-"%Y-%m-%d"
tmp33date<-as.Date(dt33$date,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp33date) == length(tmp33date[!is.na(tmp33date)])){dt33$date <- tmp33date } else {print("Date conversion failed for dt33$date. Please inspect the data and do the date conversion yourself.")}
rm(tmpDateFormat,tmp33date)
if (class(dt33$cham)!="factor") dt33$cham<- as.factor(dt33$cham)
if (class(dt33$treat)!="factor") dt33$treat<- as.factor(dt33$treat)
if (class(dt33$method)!="factor") dt33$method<- as.factor(dt33$method)
if (class(dt33$genus)!="factor") dt33$genus<- as.factor(dt33$genus)
if (class(dt33$species)!="factor") dt33$species<- as.factor(dt33$species)
if (class(dt33$n)=="factor") dt33$n <-as.numeric(levels(dt33$n))[as.integer(dt33$n) ]
if (class(dt33$n)=="character") dt33$n <-as.numeric(dt33$n)

# Convert Missing Values to NA for non-dates

dt33$n <- ifelse((trimws(as.character(dt33$n))==trimws("NA")),NA,dt33$n)


# Here is the structure of the input data frame:
str(dt33)
attach(dt33)
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.

summary(date)
summary(cham)
summary(treat)
summary(method)
summary(genus)
summary(species)
summary(n)
detach(dt33)



# hf113-40-hf-non-ant-invertebrates.csv
infile40 <- 'data/raw data/ellison_2017a/hf113-40-hf-non-ant-invertebrates.csv'
if(!dir.exists('data/raw data/ellison_2017a/') || !file.exists(infile40))   {
   dir.create('data/raw data/ellison_2017a/', showWarnings = FALSE)
   inUrl40  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-hfr/113/57/2bb7bc8351da74c2aa4c3a6d19635ec8"
   download.file(inUrl40,infile40,method="curl")
}





dt40 <-read.csv(infile40,header=F
                ,skip=1
                ,sep=","
                , col.names=c(
                   "date.processed",
                   "experiment",
                   "current.location",
                   "date",
                   "location",
                   "chamber",
                   "sample",
                   "subsample",
                   "class",
                   "subclass",
                   "order",
                   "suborder",
                   "superfamily",
                   "family",
                   "genus",
                   "species",
                   "common.name",
                   "larvae",
                   "other.juv",
                   "number",
                   "unique.id",
                   "notes"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

# attempting to convert dt40$date.processed dateTime string to R date structure (date or POSIXct)
tmpDateFormat<-"%Y-%m-%d"
tmp40date.processed<-as.Date(dt40$date.processed,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp40date.processed) == length(tmp40date.processed[!is.na(tmp40date.processed)])){dt40$date.processed <- tmp40date.processed } else {print("Date conversion failed for dt40$date.processed. Please inspect the data and do the date conversion yourself.")}
rm(tmpDateFormat,tmp40date.processed)
if (class(dt40$experiment)!="factor") dt40$experiment<- as.factor(dt40$experiment)
if (class(dt40$current.location)!="factor") dt40$current.location<- as.factor(dt40$current.location)
# attempting to convert dt40$date dateTime string to R date structure (date or POSIXct)
tmpDateFormat<-"%Y-%m-%d"
tmp40date<-as.Date(dt40$date,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp40date) == length(tmp40date[!is.na(tmp40date)])){dt40$date <- tmp40date } else {print("Date conversion failed for dt40$date. Please inspect the data and do the date conversion yourself.")}
rm(tmpDateFormat,tmp40date)
if (class(dt40$location)!="factor") dt40$location<- as.factor(dt40$location)
if (class(dt40$chamber)!="factor") dt40$chamber<- as.factor(dt40$chamber)
if (class(dt40$sample)!="factor") dt40$sample<- as.factor(dt40$sample)
if (class(dt40$subsample)!="factor") dt40$subsample<- as.factor(dt40$subsample)
if (class(dt40$class)!="factor") dt40$class<- as.factor(dt40$class)
if (class(dt40$subclass)!="factor") dt40$subclass<- as.factor(dt40$subclass)
if (class(dt40$order)!="factor") dt40$order<- as.factor(dt40$order)
if (class(dt40$suborder)!="factor") dt40$suborder<- as.factor(dt40$suborder)
if (class(dt40$superfamily)!="factor") dt40$superfamily<- as.factor(dt40$superfamily)
if (class(dt40$family)!="factor") dt40$family<- as.factor(dt40$family)
if (class(dt40$genus)!="factor") dt40$genus<- as.factor(dt40$genus)
if (class(dt40$species)!="factor") dt40$species<- as.factor(dt40$species)
if (class(dt40$common.name)!="factor") dt40$common.name<- as.factor(dt40$common.name)
if (class(dt40$larvae)!="factor") dt40$larvae<- as.factor(dt40$larvae)
if (class(dt40$other.juv)!="factor") dt40$other.juv<- as.factor(dt40$other.juv)
if (class(dt40$number)=="factor") dt40$number <-as.numeric(levels(dt40$number))[as.integer(dt40$number) ]
if (class(dt40$number)=="character") dt40$number <-as.numeric(dt40$number)
if (class(dt40$unique.id)!="factor") dt40$unique.id<- as.factor(dt40$unique.id)
if (class(dt40$notes)!="factor") dt40$notes<- as.factor(dt40$notes)

# Convert Missing Values to NA for non-dates

dt40$current.location <- as.factor(ifelse((trimws(as.character(dt40$current.location))==trimws("NA")),NA,as.character(dt40$current.location)))
dt40$location <- as.factor(ifelse((trimws(as.character(dt40$location))==trimws("NA")),NA,as.character(dt40$location)))
dt40$number <- ifelse((trimws(as.character(dt40$number))==trimws("NA")),NA,dt40$number)


# Here is the structure of the input data frame:
str(dt40)
attach(dt40)
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.

summary(date.processed)
summary(experiment)
summary(current.location)
summary(date)
summary(location)
summary(chamber)
summary(sample)
summary(subsample)
summary(class)
summary(subclass)
summary(order)
summary(suborder)
summary(superfamily)
summary(family)
summary(genus)
summary(species)
summary(common.name)
summary(larvae)
summary(other.juv)
summary(number)
summary(unique.id)
summary(notes)
detach(dt40)





