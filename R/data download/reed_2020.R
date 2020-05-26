# reed_2020



# Package ID: knb-lter-sbc.30.18 Cataloging System:https://pasta.edirepository.org.
# Data set title: SBC LTER: Reef: Long-term experiment: Kelp removal: Fish abundance.
# Data set creator:    - Santa Barbara Coastal LTER
# Data set creator:  Daniel C Reed -
# Contact:    - Information Manager, Santa Barbara Coastal LTER   - sbclter@msi.ucsb.edu
# Stylesheet v2.10 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu





infile1 <- 'data/raw data/reed_2020/LTE_All_Fish_All_Years_20200224.csv'
if(!dir.exists('data/raw data/reed_2020/') || !file.exists(infile1))   {
   dir.create('data/raw data/reed_2020/', showWarnings = FALSE)
   inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sbc/30/18/4587fe81c6d2eabf530c70e53b302132"
   download.file(inUrl1, infile1, method="curl")
}


dt1 <-read.csv(infile1,header=F
               ,skip=1
               ,sep=","
               ,quot='"'
               , col.names=c(
                  "YEAR",
                  "MONTH",
                  "DATE",
                  "SITE",
                  "TRANSECT",
                  "TREATMENT",
                  "VIS",
                  "QUAD",
                  "SIDE",
                  "SP_CODE",
                  "SIZE",
                  "COUNT",
                  "AREA",
                  "SCIENTIFIC_NAME",
                  "COMMON_NAME",
                  "TAXON_KINGDOM",
                  "TAXON_PHYLUM",
                  "TAXON_CLASS",
                  "TAXON_ORDER",
                  "TAXON_FAMILY",
                  "TAXON_GENUS",
                  "GROUP",
                  "SURVEY",
                  "MOBILITY",
                  "GROWTH_MORPH"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt1$MONTH)!="factor") dt1$MONTH<- as.factor(dt1$MONTH)
# attempting to convert dt1$DATE dateTime string to R date structure (date or POSIXct)
tmpDateFormat<-"%Y-%m-%d"
tmp1DATE<-as.Date(dt1$DATE,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp1DATE) == length(tmp1DATE[!is.na(tmp1DATE)])){dt1$DATE <- tmp1DATE } else {print("Date conversion failed for dt1$DATE. Please inspect the data and do the date conversion yourself.")}
rm(tmpDateFormat,tmp1DATE)
if (class(dt1$SITE)!="factor") dt1$SITE<- as.factor(dt1$SITE)
if (class(dt1$TRANSECT)!="factor") dt1$TRANSECT<- as.factor(dt1$TRANSECT)
if (class(dt1$TREATMENT)!="factor") dt1$TREATMENT<- as.factor(dt1$TREATMENT)
if (class(dt1$VIS)=="factor") dt1$VIS <-as.numeric(levels(dt1$VIS))[as.integer(dt1$VIS) ]
if (class(dt1$VIS)=="character") dt1$VIS <-as.numeric(dt1$VIS)
if (class(dt1$QUAD)!="factor") dt1$QUAD<- as.factor(dt1$QUAD)
if (class(dt1$SIDE)!="factor") dt1$SIDE<- as.factor(dt1$SIDE)
if (class(dt1$SP_CODE)!="factor") dt1$SP_CODE<- as.factor(dt1$SP_CODE)
if (class(dt1$SIZE)=="factor") dt1$SIZE <-as.numeric(levels(dt1$SIZE))[as.integer(dt1$SIZE) ]
if (class(dt1$SIZE)=="character") dt1$SIZE <-as.numeric(dt1$SIZE)
if (class(dt1$COUNT)=="factor") dt1$COUNT <-as.numeric(levels(dt1$COUNT))[as.integer(dt1$COUNT) ]
if (class(dt1$COUNT)=="character") dt1$COUNT <-as.numeric(dt1$COUNT)
if (class(dt1$AREA)=="factor") dt1$AREA <-as.numeric(levels(dt1$AREA))[as.integer(dt1$AREA) ]
if (class(dt1$AREA)=="character") dt1$AREA <-as.numeric(dt1$AREA)
if (class(dt1$SCIENTIFIC_NAME)!="factor") dt1$SCIENTIFIC_NAME<- as.factor(dt1$SCIENTIFIC_NAME)
if (class(dt1$COMMON_NAME)!="factor") dt1$COMMON_NAME<- as.factor(dt1$COMMON_NAME)
if (class(dt1$TAXON_KINGDOM)!="factor") dt1$TAXON_KINGDOM<- as.factor(dt1$TAXON_KINGDOM)
if (class(dt1$TAXON_PHYLUM)!="factor") dt1$TAXON_PHYLUM<- as.factor(dt1$TAXON_PHYLUM)
if (class(dt1$TAXON_CLASS)!="factor") dt1$TAXON_CLASS<- as.factor(dt1$TAXON_CLASS)
if (class(dt1$TAXON_ORDER)!="factor") dt1$TAXON_ORDER<- as.factor(dt1$TAXON_ORDER)
if (class(dt1$TAXON_FAMILY)!="factor") dt1$TAXON_FAMILY<- as.factor(dt1$TAXON_FAMILY)
if (class(dt1$TAXON_GENUS)!="factor") dt1$TAXON_GENUS<- as.factor(dt1$TAXON_GENUS)
if (class(dt1$GROUP)!="factor") dt1$GROUP<- as.factor(dt1$GROUP)
if (class(dt1$SURVEY)!="factor") dt1$SURVEY<- as.factor(dt1$SURVEY)
if (class(dt1$MOBILITY)!="factor") dt1$MOBILITY<- as.factor(dt1$MOBILITY)
if (class(dt1$GROWTH_MORPH)!="factor") dt1$GROWTH_MORPH<- as.factor(dt1$GROWTH_MORPH)

# Convert Missing Values to NA for non-dates

dt1$VIS <- ifelse((trimws(as.character(dt1$VIS))==trimws("-99999")),NA,dt1$VIS)
dt1$QUAD <- ifelse((trimws(as.character(dt1$QUAD))==trimws("-99999")),NA,dt1$QUAD)   # added
dt1$SIDE <- ifelse((trimws(as.character(dt1$SIDE))==trimws("-99999")),NA,dt1$SIDE)   # added
dt1$SP_CODE <- as.factor(ifelse((trimws(as.character(dt1$SP_CODE))==trimws("-99999")),NA,as.character(dt1$SP_CODE)))
dt1$SIZE <- ifelse((trimws(as.character(dt1$SIZE))==trimws("-99999")),NA,dt1$SIZE)
dt1$COUNT <- ifelse((trimws(as.character(dt1$COUNT))==trimws("-99999")),NA,dt1$COUNT)
dt1$AREA <- ifelse((trimws(as.character(dt1$AREA))==trimws("-99999")),NA,dt1$AREA)
dt1$SCIENTIFIC_NAME <- as.factor(ifelse((trimws(as.character(dt1$SCIENTIFIC_NAME))==trimws("-99999")),NA,as.character(dt1$SCIENTIFIC_NAME)))

ddata <- dt1
save(ddata, file = 'data/raw data/reed_2020/ddata')



if(FALSE) {
      # Here is the structure of the input data frame:
      str(dt1)
      attach(dt1)
      # The analyses below are basic descriptions of the variables. After testing, they should be replaced.

      summary(YEAR)
      summary(MONTH)
      summary(DATE)
      summary(SITE)
      summary(TRANSECT)
      summary(TREATMENT)
      summary(VIS)
      summary(QUAD)
      summary(SIDE)
      summary(SP_CODE)
      summary(SIZE)
      summary(COUNT)
      summary(AREA)
      summary(SCIENTIFIC_NAME)
      summary(COMMON_NAME)
      summary(TAXON_KINGDOM)
      summary(TAXON_PHYLUM)
      summary(TAXON_CLASS)
      summary(TAXON_ORDER)
      summary(TAXON_FAMILY)
      summary(TAXON_GENUS)
      summary(GROUP)
      summary(SURVEY)
      summary(MOBILITY)
      summary(GROWTH_MORPH)
      detach(dt1)

}



