# ellison_2017b
# SPIDERS in CHAMBERS




# Package ID: knb-lter-hfr.113.57 Cataloging System:https://pasta.edirepository.org.
# Data set title: Ants Under Climate Change at Harvard Forest and Duke Forest 2009-2015.
# Data set creator:  Aaron Ellison -
# Data set creator:  Robert Dunn -
# Contact:  Aaron Ellison -  Harvard Forest  - aellison@fas.harvard.edu
# Stylesheet v2.10 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu



# hf113-32-hf-cham-spiders.csv
infile32 <- 'data/raw data/ellison_2017b/hf113-32-hf-cham-spiders.csv'
if(!dir.exists('data/raw data/ellison_2017b/') || !file.exists(infile32))   {
   dir.create('data/raw data/ellison_2017b/', showWarnings = FALSE)
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

ddata <- dt32
save(ddata, file = 'data/raw data/ellison_2017b/ddata')



if(FALSE) {
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
}
