## walker_2010

# Package ID: knb-lter-luq.15.614200 Cataloging System:https://pasta.lternet.edu.
# Data set title: Revegetation of landslides, vegetation <0.1m (Small landslide plots at the Luquillo Experimental Forest).
# Data set creator:  Lawrence R. Walker -
# Contact:    - Information Manager LTER Network Office  - tech-support@lternet.edu
# Contact:  Lawrence R. Walker -    - lwalker@lternet.edu
# Metadata Link: https://portal.lternet.edu/nis/metadataviewer?packageid=knb-lter-luq.15.614200
# Stylesheet v2.10 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu

infile1 <- 'data/raw data/walker_2010/lssmes1_0.csv'
if(!dir.exists('data/raw data/walker_2010/') || !file.exists(infile1))   {
   dir.create('data/raw data/walker_2010/',  showWarnings = FALSE)
   inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-luq/15/614200/261f08872b76147e59bcc1abca38c632"
   download.file(inUrl1,infile1,method="curl")
}


dt1 <-read.csv(infile1,header=F
               ,skip=1
               ,sep=","
               , col.names=c(
                  "Transect",
                  "Plot",
                  "Tag.Number",
                  "Height",
                  "Diameter",
                  "Species",
                  "lt10cm",
                  "gt10cm",
                  "Comments",
                  "Start.date"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt1$Transect)!="factor") dt1$Transect<- as.factor(dt1$Transect)
if (class(dt1$Plot)!="factor") dt1$Plot<- as.factor(dt1$Plot)
if (class(dt1$Tag.Number)!="factor") dt1$Tag.Number<- as.factor(dt1$Tag.Number)
if (class(dt1$Height)=="factor") dt1$Height <-as.numeric(levels(dt1$Height))[as.integer(dt1$Height) ]
if (class(dt1$Height)=="character") dt1$Height <-as.numeric(dt1$Height)
if (class(dt1$Diameter)=="factor") dt1$Diameter <-as.numeric(levels(dt1$Diameter))[as.integer(dt1$Diameter) ]
if (class(dt1$Diameter)=="character") dt1$Diameter <-as.numeric(dt1$Diameter)
if (class(dt1$Species)!="factor") dt1$Species<- as.factor(dt1$Species)
if (class(dt1$lt10cm)=="factor") dt1$lt10cm <-as.numeric(levels(dt1$lt10cm))[as.integer(dt1$lt10cm) ]
if (class(dt1$lt10cm)=="character") dt1$lt10cm <-as.numeric(dt1$lt10cm)
if (class(dt1$gt10cm)=="factor") dt1$gt10cm <-as.numeric(levels(dt1$gt10cm))[as.integer(dt1$gt10cm) ]
if (class(dt1$gt10cm)=="character") dt1$gt10cm <-as.numeric(dt1$gt10cm)
if (class(dt1$Comments)!="factor") dt1$Comments<- as.factor(dt1$Comments)

# Convert Missing Values to NA for non-dates



# Here is the structure of the input data frame:
str(dt1)
attach(dt1)
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.

summary(Transect)
summary(Plot)
summary(Tag.Number)
summary(Height)
summary(Diameter)
summary(Species)
summary(lt10cm)
summary(gt10cm)
summary(Comments)
summary(Start.date)
detach(dt1)



infile2 <- 'data/raw data/walker_2010/lssmes2_1.csv'
if(!dir.exists('data/raw data/walker_2010/') || !file.exists(infile2))   {
   inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-luq/15/614200/6d3312c3b3fa9767dd2feacf38b32baf"
   download.file(inUrl2, infile2, method="curl")
}


dt2 <-read.csv(infile2,header=F
               ,skip=1
               ,sep=","
               , col.names=c(
                  "Transect",
                  "Plot",
                  "Tag.Number",
                  "Height",
                  "Diameter",
                  "Species",
                  "gt10cm",
                  "lt10cm",
                  "Comments",
                  "Start.date"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt2$Transect)!="factor") dt2$Transect<- as.factor(dt2$Transect)
if (class(dt2$Plot)!="factor") dt2$Plot<- as.factor(dt2$Plot)
if (class(dt2$Tag.Number)!="factor") dt2$Tag.Number<- as.factor(dt2$Tag.Number)
if (class(dt2$Height)=="factor") dt2$Height <-as.numeric(levels(dt2$Height))[as.integer(dt2$Height) ]
if (class(dt2$Height)=="character") dt2$Height <-as.numeric(dt2$Height)
if (class(dt2$Diameter)=="factor") dt2$Diameter <-as.numeric(levels(dt2$Diameter))[as.integer(dt2$Diameter) ]
if (class(dt2$Diameter)=="character") dt2$Diameter <-as.numeric(dt2$Diameter)
if (class(dt2$Species)!="factor") dt2$Species<- as.factor(dt2$Species)
if (class(dt2$gt10cm)=="factor") dt2$gt10cm <-as.numeric(levels(dt2$gt10cm))[as.integer(dt2$gt10cm) ]
if (class(dt2$gt10cm)=="character") dt2$gt10cm <-as.numeric(dt2$gt10cm)
if (class(dt2$lt10cm)=="factor") dt2$lt10cm <-as.numeric(levels(dt2$lt10cm))[as.integer(dt2$lt10cm) ]
if (class(dt2$lt10cm)=="character") dt2$lt10cm <-as.numeric(dt2$lt10cm)
if (class(dt2$Comments)!="factor") dt2$Comments<- as.factor(dt2$Comments)

# Convert Missing Values to NA for non-dates



# Here is the structure of the input data frame:
str(dt2)
attach(dt2)
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.

summary(Transect)
summary(Plot)
summary(Tag.Number)
summary(Height)
summary(Diameter)
summary(Species)
summary(gt10cm)
summary(lt10cm)
summary(Comments)
summary(Start.date)
detach(dt2)



infile3 <- 'data/raw data/walker_2010/lssmrb2.csv'
if(!dir.exists('data/raw data/walker_2010/') || !file.exists(infile3))   {
   inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-luq/15/614200/b666fe9985a24c39ad3259171b98271d"

   download.file(inUrl3, infile3, method="curl")
}

dt3 <-read.csv(infile3,header=F
               ,skip=1
               ,sep=","
               , col.names=c(
                  "Transect",
                  "Plot",
                  "Tag.Number",
                  "Height",
                  "Diameter",
                  "Species",
                  "Comments",
                  "Start.date"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt3$Transect)!="factor") dt3$Transect<- as.factor(dt3$Transect)
if (class(dt3$Plot)!="factor") dt3$Plot<- as.factor(dt3$Plot)
if (class(dt3$Tag.Number)!="factor") dt3$Tag.Number<- as.factor(dt3$Tag.Number)
if (class(dt3$Height)=="factor") dt3$Height <-as.numeric(levels(dt3$Height))[as.integer(dt3$Height) ]
if (class(dt3$Height)=="character") dt3$Height <-as.numeric(dt3$Height)
if (class(dt3$Diameter)=="factor") dt3$Diameter <-as.numeric(levels(dt3$Diameter))[as.integer(dt3$Diameter) ]
if (class(dt3$Diameter)=="character") dt3$Diameter <-as.numeric(dt3$Diameter)
if (class(dt3$Species)!="factor") dt3$Species<- as.factor(dt3$Species)
if (class(dt3$Comments)!="factor") dt3$Comments<- as.factor(dt3$Comments)

# Convert Missing Values to NA for non-dates





