## allison_2018


# Package ID: knb-lter-hfr.160.20 Cataloging System:https://pasta.edirepository.org.
# Data set title: Ants and Ecosystem Function in Hemlock Removal Experiment at Harvard Forest since 2006.
# Data set creator:  Aaron Ellison -
# Contact:  Aaron Ellison -  Harvard Forest  - aellison@fas.harvard.edu
# Stylesheet v2.10 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu

infile1 <- 'data/raw data/allison_2018/hf160-01-ibuttons.csv'
if(!dir.exists('data/raw data/allison_2018/') || !file.exists(infile1))   {
   dir.create('data/raw data/allison_2018/',  showWarnings = FALSE)
   inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-hfr/160/20/b1610a7d2f2a95a509af82a7bd01a108"
   download.file(inUrl1, infile1, method="curl")
}


dt1 <-read.csv(infile1,header=F
               ,skip=1
               ,sep=","
               , col.names=c(
                  "datetime",
                  "date",
                  "time.24hr",
                  "soilt",
                  "block",
                  "treatment",
                  "plot",
                  "subplot",
                  "subplot.t"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

# attempting to convert dt1$datetime dateTime string to R date structure (date or POSIXct)
tmpDateFormat<-"%Y-%m-%dT%H:%M"
tmp1datetime<-as.POSIXct(dt1$datetime,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp1datetime) == length(tmp1datetime[!is.na(tmp1datetime)])){dt1$datetime <- tmp1datetime } else {print("Date conversion failed for dt1$datetime. Please inspect the data and do the date conversion yourself.")}
rm(tmpDateFormat,tmp1datetime)
# attempting to convert dt1$date dateTime string to R date structure (date or POSIXct)
tmpDateFormat<-"%Y-%m-%d"
tmp1date<-as.Date(dt1$date,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp1date) == length(tmp1date[!is.na(tmp1date)])){dt1$date <- tmp1date } else {print("Date conversion failed for dt1$date. Please inspect the data and do the date conversion yourself.")}
rm(tmpDateFormat,tmp1date)
if (class(dt1$soilt)=="factor") dt1$soilt <-as.numeric(levels(dt1$soilt))[as.integer(dt1$soilt) ]
if (class(dt1$soilt)=="character") dt1$soilt <-as.numeric(dt1$soilt)
if (class(dt1$block)!="factor") dt1$block<- as.factor(dt1$block)
if (class(dt1$treatment)!="factor") dt1$treatment<- as.factor(dt1$treatment)
if (class(dt1$plot)!="factor") dt1$plot<- as.factor(dt1$plot)
if (class(dt1$subplot)!="factor") dt1$subplot<- as.factor(dt1$subplot)
if (class(dt1$subplot.t)!="factor") dt1$subplot.t<- as.factor(dt1$subplot.t)

# Convert Missing Values to NA for non-dates

dt1$soilt <- ifelse((trimws(as.character(dt1$soilt))==trimws("NA")),NA,dt1$soilt)


infile2 <- 'data/raw data/allison_2018/hf160-02-subplots.csv'
if(!dir.exists('data/raw data/allison_2018/') || !file.exists(infile2))   {
   dir.create('data/raw data/allison_2018/',  showWarnings = FALSE)
   inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-hfr/160/20/4b3cebe94958392ef8cff25409565fa1"
   download.file(inUrl2, infile2, method="curl")
}


dt2 <-read.csv(infile2,header=F
               ,skip=1
               ,sep=","
               , col.names=c(
                  "treatment",
                  "block",
                  "plot",
                  "subplot",
                  "subplot.t",
                  "x.m",
                  "y.m",
                  "elevation"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt2$treatment)!="factor") dt2$treatment<- as.factor(dt2$treatment)
if (class(dt2$block)!="factor") dt2$block<- as.factor(dt2$block)
if (class(dt2$plot)!="factor") dt2$plot<- as.factor(dt2$plot)
if (class(dt2$subplot)!="factor") dt2$subplot<- as.factor(dt2$subplot)
if (class(dt2$subplot.t)!="factor") dt2$subplot.t<- as.factor(dt2$subplot.t)
if (class(dt2$x.m)=="factor") dt2$x.m <-as.numeric(levels(dt2$x.m))[as.integer(dt2$x.m) ]
if (class(dt2$x.m)=="character") dt2$x.m <-as.numeric(dt2$x.m)
if (class(dt2$y.m)=="factor") dt2$y.m <-as.numeric(levels(dt2$y.m))[as.integer(dt2$y.m) ]
if (class(dt2$y.m)=="character") dt2$y.m <-as.numeric(dt2$y.m)
if (class(dt2$elevation)=="factor") dt2$elevation <-as.numeric(levels(dt2$elevation))[as.integer(dt2$elevation) ]
if (class(dt2$elevation)=="character") dt2$elevation <-as.numeric(dt2$elevation)

# Convert Missing Values to NA for non-dates

dt2$x.m <- ifelse((trimws(as.character(dt2$x.m))==trimws("NA")),NA,dt2$x.m)
dt2$y.m <- ifelse((trimws(as.character(dt2$y.m))==trimws("NA")),NA,dt2$y.m)
dt2$elevation <- ifelse((trimws(as.character(dt2$elevation))==trimws("NA")),NA,dt2$elevation)





infile3 <- 'data/raw data/allison_2018/hf160-03-ants.csv'
if(!dir.exists('data/raw data/allison_2018/') || !file.exists(infile3))   {
   dir.create('data/raw data/allison_2018/',  showWarnings = FALSE)
   inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-hfr/160/20/8821e0b89318cfb2204f9acc17287e0f"
   download.file(inUrl3, infile3, method="curl")
}

dt3 <-read.csv(infile3, header=F
               ,skip=1
               ,sep=","
               , col.names=c(
                  "date",
                  "treatment",
                  "block",
                  "plot",
                  "subplot",
                  "subplot.t",
                  "vial.num",
                  "subfamily",
                  "genus",
                  "species",
                  "spec.code",
                  "count"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

# attempting to convert dt3$date dateTime string to R date structure (date or POSIXct)
tmpDateFormat<-"%Y-%m-%d"
tmp3date<-as.Date(dt3$date,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp3date) == length(tmp3date[!is.na(tmp3date)])){dt3$date <- tmp3date } else {print("Date conversion failed for dt3$date. Please inspect the data and do the date conversion yourself.")}
rm(tmpDateFormat,tmp3date)
if (class(dt3$treatment)!="factor") dt3$treatment<- as.factor(dt3$treatment)
if (class(dt3$block)!="factor") dt3$block<- as.factor(dt3$block)
if (class(dt3$plot)!="factor") dt3$plot<- as.factor(dt3$plot)
if (class(dt3$subplot)!="factor") dt3$subplot<- as.factor(dt3$subplot)
if (class(dt3$subplot.t)!="factor") dt3$subplot.t<- as.factor(dt3$subplot.t)
if (class(dt3$vial.num)!="factor") dt3$vial.num<- as.factor(dt3$vial.num)
if (class(dt3$subfamily)!="factor") dt3$subfamily<- as.factor(dt3$subfamily)
if (class(dt3$genus)!="factor") dt3$genus<- as.factor(dt3$genus)
if (class(dt3$species)!="factor") dt3$species<- as.factor(dt3$species)
if (class(dt3$spec.code)!="factor") dt3$spec.code<- as.factor(dt3$spec.code)
if (class(dt3$count)=="factor") dt3$count <-as.numeric(levels(dt3$count))[as.integer(dt3$count) ]
if (class(dt3$count)=="character") dt3$count <-as.numeric(dt3$count)

# Convert Missing Values to NA for non-dates
dt3$count <- ifelse((trimws(as.character(dt3$count))==trimws("NA")),NA,dt3$count)





# Nitrogen data

infile4 <- 'data/raw data/allison_2018/hf160-04-nitrogen.csv'
if(!dir.exists('data/raw data/allison_2018/') || !file.exists(infile4))   {
   dir.create('data/raw data/allison_2018/',  showWarnings = FALSE)
   inUrl4  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-hfr/160/20/ae3924330258eef88d26f8abe7cdf4d1"
   download.file(inUrl4, infile4, method="curl")
}


dt4 <-read.csv(infile4, header=F
               ,skip=1
               ,sep=","
               , col.names=c(
                  "year",
                  "quarter",
                  "treatment",
                  "block",
                  "plot",
                  "subplot",
                  "subplot.t",
                  "res.mass",
                  "tot.nh4",
                  "tot.no3",
                  "res.nh4",
                  "res.no3",
                  "tot.n",
                  "res.n",
                  "daily.nh4",
                  "daily.no3",
                  "daily.n"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt4$quarter)!="factor") dt4$quarter<- as.factor(dt4$quarter)
if (class(dt4$treatment)!="factor") dt4$treatment<- as.factor(dt4$treatment)
if (class(dt4$block)!="factor") dt4$block<- as.factor(dt4$block)
if (class(dt4$plot)!="factor") dt4$plot<- as.factor(dt4$plot)
if (class(dt4$subplot)!="factor") dt4$subplot<- as.factor(dt4$subplot)
if (class(dt4$subplot.t)!="factor") dt4$subplot.t<- as.factor(dt4$subplot.t)
if (class(dt4$res.mass)=="factor") dt4$res.mass <-as.numeric(levels(dt4$res.mass))[as.integer(dt4$res.mass) ]
if (class(dt4$res.mass)=="character") dt4$res.mass <-as.numeric(dt4$res.mass)
if (class(dt4$tot.nh4)=="factor") dt4$tot.nh4 <-as.numeric(levels(dt4$tot.nh4))[as.integer(dt4$tot.nh4) ]
if (class(dt4$tot.nh4)=="character") dt4$tot.nh4 <-as.numeric(dt4$tot.nh4)
if (class(dt4$tot.no3)=="factor") dt4$tot.no3 <-as.numeric(levels(dt4$tot.no3))[as.integer(dt4$tot.no3) ]
if (class(dt4$tot.no3)=="character") dt4$tot.no3 <-as.numeric(dt4$tot.no3)
if (class(dt4$res.nh4)=="factor") dt4$res.nh4 <-as.numeric(levels(dt4$res.nh4))[as.integer(dt4$res.nh4) ]
if (class(dt4$res.nh4)=="character") dt4$res.nh4 <-as.numeric(dt4$res.nh4)
if (class(dt4$res.no3)=="factor") dt4$res.no3 <-as.numeric(levels(dt4$res.no3))[as.integer(dt4$res.no3) ]
if (class(dt4$res.no3)=="character") dt4$res.no3 <-as.numeric(dt4$res.no3)
if (class(dt4$tot.n)=="factor") dt4$tot.n <-as.numeric(levels(dt4$tot.n))[as.integer(dt4$tot.n) ]
if (class(dt4$tot.n)=="character") dt4$tot.n <-as.numeric(dt4$tot.n)
if (class(dt4$res.n)=="factor") dt4$res.n <-as.numeric(levels(dt4$res.n))[as.integer(dt4$res.n) ]
if (class(dt4$res.n)=="character") dt4$res.n <-as.numeric(dt4$res.n)
if (class(dt4$daily.nh4)=="factor") dt4$daily.nh4 <-as.numeric(levels(dt4$daily.nh4))[as.integer(dt4$daily.nh4) ]
if (class(dt4$daily.nh4)=="character") dt4$daily.nh4 <-as.numeric(dt4$daily.nh4)
if (class(dt4$daily.no3)=="factor") dt4$daily.no3 <-as.numeric(levels(dt4$daily.no3))[as.integer(dt4$daily.no3) ]
if (class(dt4$daily.no3)=="character") dt4$daily.no3 <-as.numeric(dt4$daily.no3)
if (class(dt4$daily.n)=="factor") dt4$daily.n <-as.numeric(levels(dt4$daily.n))[as.integer(dt4$daily.n) ]
if (class(dt4$daily.n)=="character") dt4$daily.n <-as.numeric(dt4$daily.n)

# Convert Missing Values to NA for non-dates

dt4$res.mass <- ifelse((trimws(as.character(dt4$res.mass))==trimws("NA")),NA,dt4$res.mass)
dt4$tot.nh4 <- ifelse((trimws(as.character(dt4$tot.nh4))==trimws("NA")),NA,dt4$tot.nh4)
dt4$tot.no3 <- ifelse((trimws(as.character(dt4$tot.no3))==trimws("NA")),NA,dt4$tot.no3)
dt4$res.nh4 <- ifelse((trimws(as.character(dt4$res.nh4))==trimws("NA")),NA,dt4$res.nh4)
dt4$res.no3 <- ifelse((trimws(as.character(dt4$res.no3))==trimws("NA")),NA,dt4$res.no3)
dt4$tot.n <- ifelse((trimws(as.character(dt4$tot.n))==trimws("NA")),NA,dt4$tot.n)
dt4$res.n <- ifelse((trimws(as.character(dt4$res.n))==trimws("NA")),NA,dt4$res.n)
dt4$daily.nh4 <- ifelse((trimws(as.character(dt4$daily.nh4))==trimws("NA")),NA,dt4$daily.nh4)
dt4$daily.no3 <- ifelse((trimws(as.character(dt4$daily.no3))==trimws("NA")),NA,dt4$daily.no3)
dt4$daily.n <- ifelse((trimws(as.character(dt4$daily.n))==trimws("NA")),NA,dt4$daily.n)


# Here is the structure of the input data frame:
str(dt4)
attach(dt4)
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.

summary(year)
summary(quarter)
summary(treatment)
summary(block)
summary(plot)
summary(subplot)
summary(subplot.t)
summary(res.mass)
summary(tot.nh4)
summary(tot.no3)
summary(res.nh4)
summary(res.no3)
summary(tot.n)
summary(res.n)
summary(daily.nh4)
summary(daily.no3)
summary(daily.n)
detach(dt4)


# Other environmental variable tables not loaded.
