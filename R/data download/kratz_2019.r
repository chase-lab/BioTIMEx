## kratz_2019

# Package ID: knb-lter-ntl.251.3 Cataloging System:https://pasta.edirepository.org.
# Data set title: Little Rock Lake Experiment at North Temperate Lakes LTER: Zooplankton count 1983 - 2000.
# Data set creator:  Timothy Kratz - University of Wisconsin
# Metadata Provider:  NTL Information Manager - University of Wisconsin
# Contact:  NTL Information Manager -  University of Wisconsin  - ntl.infomgr@gmail.com
# Contact:  NTL Lead PI -  University of Wisconsin  - ntl.leadpi@gmail.com
# Stylesheet v2.10 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu



infile1 <- 'data/raw data/kratz_2019/ntl251_v1.csv'
if(!dir.exists('data/raw data/kratz_2019/') || !file.exists(infile1))   {
   dir.create('data/raw data/kratz_2019/',  showWarnings = FALSE)
inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/251/3/66cceb4eb5a18a66dd437d7365405d25"
   download.file(inUrl1, infile1, method="curl")
}


dt1 <-read.csv(infile1,header=F
               ,skip=1
               ,sep=","
               ,quot='"'
               , col.names=c(
                  "lakeid",
                  "year4",
                  "sample_date",
                  "station",
                  "species_code",
                  "species",
                  "number_per_liter"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt1$lakeid)!="factor") dt1$lakeid<- as.factor(dt1$lakeid)
if (class(dt1$year4)=="factor") dt1$year4 <-as.numeric(levels(dt1$year4))[as.integer(dt1$year4) ]
if (class(dt1$year4)=="character") dt1$year4 <-as.numeric(dt1$year4)
# attempting to convert dt1$sample_date dateTime string to R date structure (date or POSIXct)
tmpDateFormat<-"%Y-%m-%d"
tmp1sample_date<-as.Date(dt1$sample_date,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp1sample_date) == length(tmp1sample_date[!is.na(tmp1sample_date)])){dt1$sample_date <- tmp1sample_date } else {print("Date conversion failed for dt1$sample_date. Please inspect the data and do the date conversion yourself.")}
rm(tmpDateFormat,tmp1sample_date)
if (class(dt1$station)!="factor") dt1$station<- as.factor(dt1$station)
if (class(dt1$species_code)!="factor") dt1$species_code<- as.factor(dt1$species_code)
if (class(dt1$species)!="factor") dt1$species<- as.factor(dt1$species)
if (class(dt1$number_per_liter)=="factor") dt1$number_per_liter <-as.numeric(levels(dt1$number_per_liter))[as.integer(dt1$number_per_liter) ]
if (class(dt1$number_per_liter)=="character") dt1$number_per_liter <-as.numeric(dt1$number_per_liter)

# Convert Missing Values to NA for non-dates



# Here is the structure of the input data frame:
str(dt1)
attach(dt1)
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.

summary(lakeid)
summary(year4)
summary(sample_date)
summary(station)
summary(species_code)
summary(species)
summary(number_per_liter)
detach(dt1)



ddata <- dt1
save(ddata, file='data/raw data/kratz_2019/ddata')



