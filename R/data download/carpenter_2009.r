# Package ID: knb-lter-ntl.80.2 Cataloging System:https://pasta.lternet.edu.
# Data set title: Cascade Project at North Temperate Lakes LTER: Phytoplankton 1984 - 1995.
# Data set creator:  Stephen Carpenter - University of Wisconsin
# Data set creator:  Jim Kitchell - NTL LTER
# Data set creator:  Jon Cole - NTL LTER
# Data set creator:  Mike Pace - NTL LTER
# Metadata Provider:    - North Temperate Lakes LTER
# Contact:    - LNO Information Manager LTER Network Office  -
# Contact:    - NTL LTER Information Manager University of Wisconsin  - infomgr@lter.limnology.wisc.edu
# Contact:    - NTL LTER Lead PI Center for Limnology  - leadpi@lter.limnology.wisc.edu
# Metadata Link: https://portal.lternet.edu/nis/metadataviewer?packageid=knb-lter-ntl.80.2
# Stylesheet v2.7 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu


infile1 <- 'data/raw data/carpenter_2009/dt1.csv'
if(!file.exists(infile1))   {
   inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/80/2/cascade_phytoplankton_q1"
   download.file(inUrl1, infile1, method="auto")
}


dt1 <-read.csv(infile1,header=F
               ,skip=1
               ,sep=","
               ,quot='"'
               , col.names=c(
                  "lakeid",
                  "lakename",
                  "year4",
                  "daynum",
                  "sampledate",
                  "old_taxon_code",
                  "taxon_code",
                  "division",
                  "taxon_name",
                  "concentration",
                  "class",
                  "gal_dimension",
                  "mean_individ_vol",
                  "mean_individ_biovol",
                  "total_vol",
                  "total_biovol"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt1$lakeid)!="factor") dt1$lakeid<- as.factor(dt1$lakeid)
if (class(dt1$lakename)!="factor") dt1$lakename<- as.factor(dt1$lakename)
if (class(dt1$year4)=="factor") dt1$year4 <-as.numeric(levels(dt1$year4))[as.integer(dt1$year4) ]
if (class(dt1$daynum)=="factor") dt1$daynum <-as.numeric(levels(dt1$daynum))[as.integer(dt1$daynum) ]
# attempting to convert dt1$sampledate dateTime string to R date structure (date or POSIXct)
tmpDateFormat<-"%Y-%m-%d"
tmp1sampledate<-as.Date(dt1$sampledate,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp1sampledate) == length(tmp1sampledate[!is.na(tmp1sampledate)])){dt1$sampledate <- tmp1sampledate } else {print("Date conversion failed for dt1$sampledate. Please inspect the data and do the date conversion yourself.")}
rm(tmpDateFormat,tmp1sampledate)
if (class(dt1$old_taxon_code)!="factor") dt1$old_taxon_code<- as.factor(dt1$old_taxon_code)
if (class(dt1$taxon_code)!="factor") dt1$taxon_code<- as.factor(dt1$taxon_code)
if (class(dt1$division)!="factor") dt1$division<- as.factor(dt1$division)
if (class(dt1$taxon_name)!="factor") dt1$taxon_name<- as.factor(dt1$taxon_name)
if (class(dt1$concentration)=="factor") dt1$concentration <-as.numeric(levels(dt1$concentration))[as.integer(dt1$concentration) ]
if (class(dt1$class)!="factor") dt1$class<- as.factor(dt1$class)
if (class(dt1$gal_dimension)=="factor") dt1$gal_dimension <-as.numeric(levels(dt1$gal_dimension))[as.integer(dt1$gal_dimension) ]
if (class(dt1$mean_individ_vol)=="factor") dt1$mean_individ_vol <-as.numeric(levels(dt1$mean_individ_vol))[as.integer(dt1$mean_individ_vol) ]
if (class(dt1$mean_individ_biovol)=="factor") dt1$mean_individ_biovol <-as.numeric(levels(dt1$mean_individ_biovol))[as.integer(dt1$mean_individ_biovol) ]
if (class(dt1$total_vol)=="factor") dt1$total_vol <-as.numeric(levels(dt1$total_vol))[as.integer(dt1$total_vol) ]
if (class(dt1$total_biovol)=="factor") dt1$total_biovol <-as.numeric(levels(dt1$total_biovol))[as.integer(dt1$total_biovol) ]

# Convert Missing Values to NA for non-dates



# Here is the structure of the input data frame:
str(dt1)
attach(dt1)
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.

summary(lakeid)
summary(lakename)
summary(year4)
summary(daynum)
summary(sampledate)
summary(old_taxon_code)
summary(taxon_code)
summary(division)
summary(taxon_name)
summary(concentration)
summary(class)
summary(gal_dimension)
summary(mean_individ_vol)
summary(mean_individ_biovol)
summary(total_vol)
summary(total_biovol)
detach(dt1)





