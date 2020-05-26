## knops_2018a

# Package ID: knb-lter-cdr.310.8 Cataloging System:https://pasta.edirepository.org.
# Data set title: Arthropod sweepnet sampling: Interactive Effects of Deer, Fire and Nitrogen.
# Data set creator:  Johannes Knops -
# Metadata Provider:    - Cedar Creek LTER
# Contact:  Dan Bahauddin - Information Manager Cedar Creek Ecosystem Science Reserve  - webmaster@cedarcreek.umn.edu
# Stylesheet v2.10 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu





infile1 <- 'data/raw data/knops_2018a/e153_Arthropod sweepnet sampling.txt'
if(!dir.exists('data/raw data/knops_2018a/') || !file.exists(infile1))   {
   dir.create('data/raw data/knops_2018a/', showWarnings = FALSE)
   inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-cdr/310/8/03cac5186165dec2523a1b3bbe3b432a"
   download.file(inUrl1, infile1, method="curl")
}


dt1 <-read.csv(infile1,header=F
               ,skip=1
               ,sep="\t"
               , col.names=c(
                  "Exp",
                  "Location",
                  "Plot",
                  "Exclosure",
                  "Fertilized",
                  "Burned",
                  "Date",
                  "Order",
                  "Family.paren.Subfamily.paren.",
                  "Genus",
                  "Specific.epithet",
                  "Further.ID",
                  "Life.stage",
                  "nSpecimens"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt1$Exp)!="factor") dt1$Exp<- as.factor(dt1$Exp)
if (class(dt1$Location)!="factor") dt1$Location<- as.factor(dt1$Location)
if (class(dt1$Plot)!="factor") dt1$Plot<- as.factor(dt1$Plot)
if (class(dt1$Exclosure)!="factor") dt1$Exclosure<- as.factor(dt1$Exclosure)
if (class(dt1$Fertilized)!="factor") dt1$Fertilized<- as.factor(dt1$Fertilized)
if (class(dt1$Burned)!="factor") dt1$Burned<- as.factor(dt1$Burned)
# attempting to convert dt1$Date dateTime string to R date structure (date or POSIXct)
tmpDateFormat<-"%m/%d/%Y"
tmp1Date<-as.Date(dt1$Date,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp1Date) == length(tmp1Date[!is.na(tmp1Date)])){dt1$Date <- tmp1Date } else {print("Date conversion failed for dt1$Date. Please inspect the data and do the date conversion yourself.")}
rm(tmpDateFormat,tmp1Date)
if (class(dt1$Order)!="factor") dt1$Order<- as.factor(dt1$Order)
if (class(dt1$Family.paren.Subfamily.paren.)!="factor") dt1$Family.paren.Subfamily.paren.<- as.factor(dt1$Family.paren.Subfamily.paren.)
if (class(dt1$Genus)!="factor") dt1$Genus<- as.factor(dt1$Genus)
if (class(dt1$Specific.epithet)!="factor") dt1$Specific.epithet<- as.factor(dt1$Specific.epithet)
if (class(dt1$Further.ID)!="factor") dt1$Further.ID<- as.factor(dt1$Further.ID)
if (class(dt1$Life.stage)!="factor") dt1$Life.stage<- as.factor(dt1$Life.stage)
if (class(dt1$nSpecimens)=="factor") dt1$nSpecimens <-as.numeric(levels(dt1$nSpecimens))[as.integer(dt1$nSpecimens) ]
if (class(dt1$nSpecimens)=="character") dt1$nSpecimens <-as.numeric(dt1$nSpecimens)

                    # Convert Missing Values to NA for non-dates

ddata <- dt1
save(ddata, file = 'data/raw data/knops_2018a/ddata')




if(FALSE) {
                    # Here is the structure of the input data frame:
                    str(dt1)
                    attach(dt1)
                    # The analyses below are basic descriptions of the variables. After testing, they should be replaced.

                    summary(Exp)
                    summary(Location)
                    summary(Plot)
                    summary(Exclosure)
                    summary(Fertilized)
                    summary(Burned)
                    summary(Date)
                    summary(Order)
                    summary(Family.paren.Subfamily.paren.)
                    summary(Genus)
                    summary(Specific.epithet)
                    summary(Further.ID)
                    summary(Life.stage)
                    summary(nSpecimens)
                       detach(dt1)
}




