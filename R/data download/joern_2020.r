## joern_2020

# Package ID: knb-lter-knz.121.5 Cataloging System:https://pasta.edirepository.org.
# Data set title: PBG07 Grasshopper species abundances in the Patch-Burn Grazing experiment at Konza Prairie.
# Data set creator:  Anthony Joern -
# Metadata Provider:  Konza LTER -
# Contact:  Konza LTER -    - knzlter@ksu.edu
# Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu




infile2 <- 'data/raw data/joern_2020/PBG072.csv'
if(!dir.exists('data/raw data/joern_2020/') || !file.exists(infile2))   {
   dir.create('data/raw data/joern_2020/', showWarnings = FALSE)
   inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-knz/121/5/67a04b9c87218fd3c377d99f4e6b834e"
   download.file(inUrl2,infile2,method="curl")
}



dt2 <-read.csv(infile2,header=F
               ,skip=1
               ,sep=","
               ,quot="'"
               , col.names=c(
                  "Datacode",
                  "Rectype",
                  "Recyear",
                  "Recmonth",
                  "Recday",
                  "Watershed",
                  "Repsite",
                  "Spcode",
                  "Genus",
                  "Species",
                  "S1",
                  "S2",
                  "S3",
                  "S4",
                  "S5",
                  "S6",
                  "S7",
                  "S8",
                  "S9",
                  "S10",
                  "Total",
                  "Comments"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt2$Datacode)!="factor") dt2$Datacode<- as.factor(dt2$Datacode)
if (class(dt2$Rectype)=="factor") dt2$Rectype <-as.numeric(levels(dt2$Rectype))[as.integer(dt2$Rectype) ]
if (class(dt2$Rectype)=="character") dt2$Rectype <-as.numeric(dt2$Rectype)
if (class(dt2$Recyear)=="factor") dt2$Recyear <-as.numeric(levels(dt2$Recyear))[as.integer(dt2$Recyear) ]
if (class(dt2$Recyear)=="character") dt2$Recyear <-as.numeric(dt2$Recyear)
if (class(dt2$Recmonth)=="factor") dt2$Recmonth <-as.numeric(levels(dt2$Recmonth))[as.integer(dt2$Recmonth) ]
if (class(dt2$Recmonth)=="character") dt2$Recmonth <-as.numeric(dt2$Recmonth)
if (class(dt2$Recday)=="factor") dt2$Recday <-as.numeric(levels(dt2$Recday))[as.integer(dt2$Recday) ]
if (class(dt2$Recday)=="character") dt2$Recday <-as.numeric(dt2$Recday)
if (class(dt2$Watershed)!="factor") dt2$Watershed<- as.factor(dt2$Watershed)
if (class(dt2$Repsite)!="factor") dt2$Repsite<- as.factor(dt2$Repsite)
if (class(dt2$Spcode)=="factor") dt2$Spcode <-as.numeric(levels(dt2$Spcode))[as.integer(dt2$Spcode) ]
if (class(dt2$Spcode)=="character") dt2$Spcode <-as.numeric(dt2$Spcode)
if (class(dt2$Genus)!="factor") dt2$Genus<- as.factor(dt2$Genus)
if (class(dt2$Species)!="factor") dt2$Species<- as.factor(dt2$Species)
if (class(dt2$S1)=="factor") dt2$S1 <-as.numeric(levels(dt2$S1))[as.integer(dt2$S1) ]
if (class(dt2$S1)=="character") dt2$S1 <-as.numeric(dt2$S1)
if (class(dt2$S2)=="factor") dt2$S2 <-as.numeric(levels(dt2$S2))[as.integer(dt2$S2) ]
if (class(dt2$S2)=="character") dt2$S2 <-as.numeric(dt2$S2)
if (class(dt2$S3)=="factor") dt2$S3 <-as.numeric(levels(dt2$S3))[as.integer(dt2$S3) ]
if (class(dt2$S3)=="character") dt2$S3 <-as.numeric(dt2$S3)
if (class(dt2$S4)=="factor") dt2$S4 <-as.numeric(levels(dt2$S4))[as.integer(dt2$S4) ]
if (class(dt2$S4)=="character") dt2$S4 <-as.numeric(dt2$S4)
if (class(dt2$S5)=="factor") dt2$S5 <-as.numeric(levels(dt2$S5))[as.integer(dt2$S5) ]
if (class(dt2$S5)=="character") dt2$S5 <-as.numeric(dt2$S5)
if (class(dt2$S6)=="factor") dt2$S6 <-as.numeric(levels(dt2$S6))[as.integer(dt2$S6) ]
if (class(dt2$S6)=="character") dt2$S6 <-as.numeric(dt2$S6)
if (class(dt2$S7)=="factor") dt2$S7 <-as.numeric(levels(dt2$S7))[as.integer(dt2$S7) ]
if (class(dt2$S7)=="character") dt2$S7 <-as.numeric(dt2$S7)
if (class(dt2$S8)=="factor") dt2$S8 <-as.numeric(levels(dt2$S8))[as.integer(dt2$S8) ]
if (class(dt2$S8)=="character") dt2$S8 <-as.numeric(dt2$S8)
if (class(dt2$S9)=="factor") dt2$S9 <-as.numeric(levels(dt2$S9))[as.integer(dt2$S9) ]
if (class(dt2$S9)=="character") dt2$S9 <-as.numeric(dt2$S9)
if (class(dt2$S10)=="factor") dt2$S10 <-as.numeric(levels(dt2$S10))[as.integer(dt2$S10) ]
if (class(dt2$S10)=="character") dt2$S10 <-as.numeric(dt2$S10)
if (class(dt2$Total)=="factor") dt2$Total <-as.numeric(levels(dt2$Total))[as.integer(dt2$Total) ]
if (class(dt2$Total)=="character") dt2$Total <-as.numeric(dt2$Total)
if (class(dt2$Comments)!="factor") dt2$Comments<- as.factor(dt2$Comments)

# Convert Missing Values to NA for non-dates

dt2$Spcode <- ifelse((trimws(as.character(dt2$Spcode))==trimws("blank")),NA,dt2$Spcode)
suppressWarnings(dt2$Spcode <- ifelse(!is.na(as.numeric("blank")) & (trimws(as.character(dt2$Spcode))==as.character(as.numeric("blank"))),NA,dt2$Spcode))
dt2$Spcode <- ifelse((trimws(as.character(dt2$Spcode))==trimws(".")),NA,dt2$Spcode)
suppressWarnings(dt2$Spcode <- ifelse(!is.na(as.numeric(".")) & (trimws(as.character(dt2$Spcode))==as.character(as.numeric("."))),NA,dt2$Spcode))
dt2$S1 <- ifelse((trimws(as.character(dt2$S1))==trimws("blank")),NA,dt2$S1)
suppressWarnings(dt2$S1 <- ifelse(!is.na(as.numeric("blank")) & (trimws(as.character(dt2$S1))==as.character(as.numeric("blank"))),NA,dt2$S1))
dt2$S1 <- ifelse((trimws(as.character(dt2$S1))==trimws(".")),NA,dt2$S1)
suppressWarnings(dt2$S1 <- ifelse(!is.na(as.numeric(".")) & (trimws(as.character(dt2$S1))==as.character(as.numeric("."))),NA,dt2$S1))
dt2$S2 <- ifelse((trimws(as.character(dt2$S2))==trimws("blank")),NA,dt2$S2)
suppressWarnings(dt2$S2 <- ifelse(!is.na(as.numeric("blank")) & (trimws(as.character(dt2$S2))==as.character(as.numeric("blank"))),NA,dt2$S2))
dt2$S2 <- ifelse((trimws(as.character(dt2$S2))==trimws(".")),NA,dt2$S2)
suppressWarnings(dt2$S2 <- ifelse(!is.na(as.numeric(".")) & (trimws(as.character(dt2$S2))==as.character(as.numeric("."))),NA,dt2$S2))
dt2$S3 <- ifelse((trimws(as.character(dt2$S3))==trimws("blank")),NA,dt2$S3)
suppressWarnings(dt2$S3 <- ifelse(!is.na(as.numeric("blank")) & (trimws(as.character(dt2$S3))==as.character(as.numeric("blank"))),NA,dt2$S3))
dt2$S3 <- ifelse((trimws(as.character(dt2$S3))==trimws(".")),NA,dt2$S3)
suppressWarnings(dt2$S3 <- ifelse(!is.na(as.numeric(".")) & (trimws(as.character(dt2$S3))==as.character(as.numeric("."))),NA,dt2$S3))
dt2$S4 <- ifelse((trimws(as.character(dt2$S4))==trimws("blank")),NA,dt2$S4)
suppressWarnings(dt2$S4 <- ifelse(!is.na(as.numeric("blank")) & (trimws(as.character(dt2$S4))==as.character(as.numeric("blank"))),NA,dt2$S4))
dt2$S4 <- ifelse((trimws(as.character(dt2$S4))==trimws(".")),NA,dt2$S4)
suppressWarnings(dt2$S4 <- ifelse(!is.na(as.numeric(".")) & (trimws(as.character(dt2$S4))==as.character(as.numeric("."))),NA,dt2$S4))
dt2$S5 <- ifelse((trimws(as.character(dt2$S5))==trimws("blank")),NA,dt2$S5)
suppressWarnings(dt2$S5 <- ifelse(!is.na(as.numeric("blank")) & (trimws(as.character(dt2$S5))==as.character(as.numeric("blank"))),NA,dt2$S5))
dt2$S5 <- ifelse((trimws(as.character(dt2$S5))==trimws(".")),NA,dt2$S5)
suppressWarnings(dt2$S5 <- ifelse(!is.na(as.numeric(".")) & (trimws(as.character(dt2$S5))==as.character(as.numeric("."))),NA,dt2$S5))
dt2$S6 <- ifelse((trimws(as.character(dt2$S6))==trimws("blank")),NA,dt2$S6)
suppressWarnings(dt2$S6 <- ifelse(!is.na(as.numeric("blank")) & (trimws(as.character(dt2$S6))==as.character(as.numeric("blank"))),NA,dt2$S6))
dt2$S6 <- ifelse((trimws(as.character(dt2$S6))==trimws(".")),NA,dt2$S6)
suppressWarnings(dt2$S6 <- ifelse(!is.na(as.numeric(".")) & (trimws(as.character(dt2$S6))==as.character(as.numeric("."))),NA,dt2$S6))
dt2$S7 <- ifelse((trimws(as.character(dt2$S7))==trimws("blank")),NA,dt2$S7)
suppressWarnings(dt2$S7 <- ifelse(!is.na(as.numeric("blank")) & (trimws(as.character(dt2$S7))==as.character(as.numeric("blank"))),NA,dt2$S7))
dt2$S7 <- ifelse((trimws(as.character(dt2$S7))==trimws(".")),NA,dt2$S7)
suppressWarnings(dt2$S7 <- ifelse(!is.na(as.numeric(".")) & (trimws(as.character(dt2$S7))==as.character(as.numeric("."))),NA,dt2$S7))
dt2$S8 <- ifelse((trimws(as.character(dt2$S8))==trimws("blank")),NA,dt2$S8)
suppressWarnings(dt2$S8 <- ifelse(!is.na(as.numeric("blank")) & (trimws(as.character(dt2$S8))==as.character(as.numeric("blank"))),NA,dt2$S8))
dt2$S8 <- ifelse((trimws(as.character(dt2$S8))==trimws(".")),NA,dt2$S8)
suppressWarnings(dt2$S8 <- ifelse(!is.na(as.numeric(".")) & (trimws(as.character(dt2$S8))==as.character(as.numeric("."))),NA,dt2$S8))
dt2$S9 <- ifelse((trimws(as.character(dt2$S9))==trimws("blank")),NA,dt2$S9)
suppressWarnings(dt2$S9 <- ifelse(!is.na(as.numeric("blank")) & (trimws(as.character(dt2$S9))==as.character(as.numeric("blank"))),NA,dt2$S9))
dt2$S9 <- ifelse((trimws(as.character(dt2$S9))==trimws(".")),NA,dt2$S9)
suppressWarnings(dt2$S9 <- ifelse(!is.na(as.numeric(".")) & (trimws(as.character(dt2$S9))==as.character(as.numeric("."))),NA,dt2$S9))
dt2$S10 <- ifelse((trimws(as.character(dt2$S10))==trimws("blank")),NA,dt2$S10)
suppressWarnings(dt2$S10 <- ifelse(!is.na(as.numeric("blank")) & (trimws(as.character(dt2$S10))==as.character(as.numeric("blank"))),NA,dt2$S10))
dt2$S10 <- ifelse((trimws(as.character(dt2$S10))==trimws(".")),NA,dt2$S10)
suppressWarnings(dt2$S10 <- ifelse(!is.na(as.numeric(".")) & (trimws(as.character(dt2$S10))==as.character(as.numeric("."))),NA,dt2$S10))
dt2$Total <- ifelse((trimws(as.character(dt2$Total))==trimws("blank")),NA,dt2$Total)
suppressWarnings(dt2$Total <- ifelse(!is.na(as.numeric("blank")) & (trimws(as.character(dt2$Total))==as.character(as.numeric("blank"))),NA,dt2$Total))
dt2$Total <- ifelse((trimws(as.character(dt2$Total))==trimws(".")),NA,dt2$Total)
suppressWarnings(dt2$Total <- ifelse(!is.na(as.numeric(".")) & (trimws(as.character(dt2$Total))==as.character(as.numeric("."))),NA,dt2$Total))

ddata <- dt2
save(ddata, file = 'data/raw data/joern_2020/ddata')



if(FALSE) {
      # Here is the structure of the input data frame:
      str(dt2)
      attach(dt2)
      # The analyses below are basic descriptions of the variables. After testing, they should be replaced.

      summary(Datacode)
      summary(Rectype)
      summary(Recyear)
      summary(Recmonth)
      summary(Recday)
      summary(Watershed)
      summary(Repsite)
      summary(Spcode)
      summary(Genus)
      summary(Species)
      summary(S1)
      summary(S2)
      summary(S3)
      summary(S4)
      summary(S5)
      summary(S6)
      summary(S7)
      summary(S8)
      summary(S9)
      summary(S10)
      summary(Total)
      summary(Comments)
      # Get more details on character variables

      summary(as.factor(dt2$Datacode))
      summary(as.factor(dt2$Watershed))
      summary(as.factor(dt2$Repsite))
      summary(as.factor(dt2$Genus))
      summary(as.factor(dt2$Species))
      summary(as.factor(dt2$Comments))
      detach(dt2)

}





















if(FALSE) {
      inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-knz/121/5/941e5f9fa022e6f1cf2c508cc0aff166"
      infile1 <- tempfile()
      download.file(inUrl1,infile1,method="auto")


      dt1 <-read.csv(infile1,header=F
                     ,skip=1
                     ,sep=","
                     ,quot='"'
                     , col.names=c(
                        "DataCode",
                        "RecType",
                        "RecYear",
                        "RecMonth",
                        "RecDay",
                        "Watershed",
                        "Soiltype",
                        "Repsite",
                        "RecTime",
                        "W1",
                        "W2",
                        "W3",
                        "W4",
                        "W5",
                        "MPH",
                        "AirTemp",
                        "AirTempC",
                        "Cloudcov",
                        "Comments"    ), check.names=TRUE)


      # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

      if (class(dt1$DataCode)!="factor") dt1$DataCode<- as.factor(dt1$DataCode)
      if (class(dt1$RecType)=="factor") dt1$RecType <-as.numeric(levels(dt1$RecType))[as.integer(dt1$RecType) ]
      if (class(dt1$RecType)=="character") dt1$RecType <-as.numeric(dt1$RecType)
      if (class(dt1$RecYear)=="factor") dt1$RecYear <-as.numeric(levels(dt1$RecYear))[as.integer(dt1$RecYear) ]
      if (class(dt1$RecYear)=="character") dt1$RecYear <-as.numeric(dt1$RecYear)
      if (class(dt1$RecMonth)=="factor") dt1$RecMonth <-as.numeric(levels(dt1$RecMonth))[as.integer(dt1$RecMonth) ]
      if (class(dt1$RecMonth)=="character") dt1$RecMonth <-as.numeric(dt1$RecMonth)
      if (class(dt1$RecDay)=="factor") dt1$RecDay <-as.numeric(levels(dt1$RecDay))[as.integer(dt1$RecDay) ]
      if (class(dt1$RecDay)=="character") dt1$RecDay <-as.numeric(dt1$RecDay)
      if (class(dt1$Watershed)!="factor") dt1$Watershed<- as.factor(dt1$Watershed)
      if (class(dt1$Soiltype)!="factor") dt1$Soiltype<- as.factor(dt1$Soiltype)
      if (class(dt1$Repsite)!="factor") dt1$Repsite<- as.factor(dt1$Repsite)
      if (class(dt1$W1)=="factor") dt1$W1 <-as.numeric(levels(dt1$W1))[as.integer(dt1$W1) ]
      if (class(dt1$W1)=="character") dt1$W1 <-as.numeric(dt1$W1)
      if (class(dt1$W2)=="factor") dt1$W2 <-as.numeric(levels(dt1$W2))[as.integer(dt1$W2) ]
      if (class(dt1$W2)=="character") dt1$W2 <-as.numeric(dt1$W2)
      if (class(dt1$W3)=="factor") dt1$W3 <-as.numeric(levels(dt1$W3))[as.integer(dt1$W3) ]
      if (class(dt1$W3)=="character") dt1$W3 <-as.numeric(dt1$W3)
      if (class(dt1$W4)=="factor") dt1$W4 <-as.numeric(levels(dt1$W4))[as.integer(dt1$W4) ]
      if (class(dt1$W4)=="character") dt1$W4 <-as.numeric(dt1$W4)
      if (class(dt1$W5)=="factor") dt1$W5 <-as.numeric(levels(dt1$W5))[as.integer(dt1$W5) ]
      if (class(dt1$W5)=="character") dt1$W5 <-as.numeric(dt1$W5)
      if (class(dt1$MPH)=="factor") dt1$MPH <-as.numeric(levels(dt1$MPH))[as.integer(dt1$MPH) ]
      if (class(dt1$MPH)=="character") dt1$MPH <-as.numeric(dt1$MPH)
      if (class(dt1$AirTemp)=="factor") dt1$AirTemp <-as.numeric(levels(dt1$AirTemp))[as.integer(dt1$AirTemp) ]
      if (class(dt1$AirTemp)=="character") dt1$AirTemp <-as.numeric(dt1$AirTemp)
      if (class(dt1$AirTempC)=="factor") dt1$AirTempC <-as.numeric(levels(dt1$AirTempC))[as.integer(dt1$AirTempC) ]
      if (class(dt1$AirTempC)=="character") dt1$AirTempC <-as.numeric(dt1$AirTempC)
      if (class(dt1$Cloudcov)=="factor") dt1$Cloudcov <-as.numeric(levels(dt1$Cloudcov))[as.integer(dt1$Cloudcov) ]
      if (class(dt1$Cloudcov)=="character") dt1$Cloudcov <-as.numeric(dt1$Cloudcov)
      if (class(dt1$Comments)!="factor") dt1$Comments<- as.factor(dt1$Comments)

      # Convert Missing Values to NA for non-dates

      dt1$Cloudcov <- ifelse((trimws(as.character(dt1$Cloudcov))==trimws(".")),NA,dt1$Cloudcov)
      suppressWarnings(dt1$Cloudcov <- ifelse(!is.na(as.numeric(".")) & (trimws(as.character(dt1$Cloudcov))==as.character(as.numeric("."))),NA,dt1$Cloudcov))


      # Here is the structure of the input data frame:
      str(dt1)
      attach(dt1)
      # The analyses below are basic descriptions of the variables. After testing, they should be replaced.

      summary(DataCode)
      summary(RecType)
      summary(RecYear)
      summary(RecMonth)
      summary(RecDay)
      summary(Watershed)
      summary(Soiltype)
      summary(Repsite)
      summary(RecTime)
      summary(W1)
      summary(W2)
      summary(W3)
      summary(W4)
      summary(W5)
      summary(MPH)
      summary(AirTemp)
      summary(AirTempC)
      summary(Cloudcov)
      summary(Comments)
      # Get more details on character variables

      summary(as.factor(dt1$DataCode))
      summary(as.factor(dt1$Watershed))
      summary(as.factor(dt1$Soiltype))
      summary(as.factor(dt1$Repsite))
      summary(as.factor(dt1$Comments))
      detach(dt1)











      inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-knz/121/5/a5181a5c1b1e130fe74fba1fe5a36746"
      infile3 <- tempfile()
      download.file(inUrl3,infile3,method="auto")


      dt3 <-read.csv(infile3,header=F
                     ,skip=1
                     ,sep=","
                     ,quot='"'
                     , col.names=c(
                        "Datacode",
                        "Rectype",
                        "Recyear",
                        "Recmonth",
                        "Recday",
                        "Watershed",
                        "Repsite",
                        "Spcode",
                        "Genus",
                        "Species",
                        "First",
                        "Secthird",
                        "Forth",
                        "Fifth",
                        "Female",
                        "Male",
                        "Total",
                        "Comments"    ), check.names=TRUE)


      # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

      if (class(dt3$Datacode)!="factor") dt3$Datacode<- as.factor(dt3$Datacode)
      if (class(dt3$Rectype)=="factor") dt3$Rectype <-as.numeric(levels(dt3$Rectype))[as.integer(dt3$Rectype) ]
      if (class(dt3$Rectype)=="character") dt3$Rectype <-as.numeric(dt3$Rectype)
      if (class(dt3$Recyear)=="factor") dt3$Recyear <-as.numeric(levels(dt3$Recyear))[as.integer(dt3$Recyear) ]
      if (class(dt3$Recyear)=="character") dt3$Recyear <-as.numeric(dt3$Recyear)
      if (class(dt3$Recmonth)=="factor") dt3$Recmonth <-as.numeric(levels(dt3$Recmonth))[as.integer(dt3$Recmonth) ]
      if (class(dt3$Recmonth)=="character") dt3$Recmonth <-as.numeric(dt3$Recmonth)
      if (class(dt3$Recday)=="factor") dt3$Recday <-as.numeric(levels(dt3$Recday))[as.integer(dt3$Recday) ]
      if (class(dt3$Recday)=="character") dt3$Recday <-as.numeric(dt3$Recday)
      if (class(dt3$Watershed)!="factor") dt3$Watershed<- as.factor(dt3$Watershed)
      if (class(dt3$Repsite)!="factor") dt3$Repsite<- as.factor(dt3$Repsite)
      if (class(dt3$Spcode)=="factor") dt3$Spcode <-as.numeric(levels(dt3$Spcode))[as.integer(dt3$Spcode) ]
      if (class(dt3$Spcode)=="character") dt3$Spcode <-as.numeric(dt3$Spcode)
      if (class(dt3$Genus)!="factor") dt3$Genus<- as.factor(dt3$Genus)
      if (class(dt3$Species)!="factor") dt3$Species<- as.factor(dt3$Species)
      if (class(dt3$First)=="factor") dt3$First <-as.numeric(levels(dt3$First))[as.integer(dt3$First) ]
      if (class(dt3$First)=="character") dt3$First <-as.numeric(dt3$First)
      if (class(dt3$Secthird)=="factor") dt3$Secthird <-as.numeric(levels(dt3$Secthird))[as.integer(dt3$Secthird) ]
      if (class(dt3$Secthird)=="character") dt3$Secthird <-as.numeric(dt3$Secthird)
      if (class(dt3$Forth)=="factor") dt3$Forth <-as.numeric(levels(dt3$Forth))[as.integer(dt3$Forth) ]
      if (class(dt3$Forth)=="character") dt3$Forth <-as.numeric(dt3$Forth)
      if (class(dt3$Fifth)=="factor") dt3$Fifth <-as.numeric(levels(dt3$Fifth))[as.integer(dt3$Fifth) ]
      if (class(dt3$Fifth)=="character") dt3$Fifth <-as.numeric(dt3$Fifth)
      if (class(dt3$Female)=="factor") dt3$Female <-as.numeric(levels(dt3$Female))[as.integer(dt3$Female) ]
      if (class(dt3$Female)=="character") dt3$Female <-as.numeric(dt3$Female)
      if (class(dt3$Male)=="factor") dt3$Male <-as.numeric(levels(dt3$Male))[as.integer(dt3$Male) ]
      if (class(dt3$Male)=="character") dt3$Male <-as.numeric(dt3$Male)
      if (class(dt3$Total)=="factor") dt3$Total <-as.numeric(levels(dt3$Total))[as.integer(dt3$Total) ]
      if (class(dt3$Total)=="character") dt3$Total <-as.numeric(dt3$Total)
      if (class(dt3$Comments)!="factor") dt3$Comments<- as.factor(dt3$Comments)

      # Convert Missing Values to NA for non-dates

      dt3$Recday <- ifelse((trimws(as.character(dt3$Recday))==trimws(".")),NA,dt3$Recday)
      suppressWarnings(dt3$Recday <- ifelse(!is.na(as.numeric(".")) & (trimws(as.character(dt3$Recday))==as.character(as.numeric("."))),NA,dt3$Recday))
      dt3$Spcode <- ifelse((trimws(as.character(dt3$Spcode))==trimws("blank")),NA,dt3$Spcode)
      suppressWarnings(dt3$Spcode <- ifelse(!is.na(as.numeric("blank")) & (trimws(as.character(dt3$Spcode))==as.character(as.numeric("blank"))),NA,dt3$Spcode))
      dt3$Spcode <- ifelse((trimws(as.character(dt3$Spcode))==trimws(".")),NA,dt3$Spcode)
      suppressWarnings(dt3$Spcode <- ifelse(!is.na(as.numeric(".")) & (trimws(as.character(dt3$Spcode))==as.character(as.numeric("."))),NA,dt3$Spcode))
      dt3$First <- ifelse((trimws(as.character(dt3$First))==trimws("blank")),NA,dt3$First)
      suppressWarnings(dt3$First <- ifelse(!is.na(as.numeric("blank")) & (trimws(as.character(dt3$First))==as.character(as.numeric("blank"))),NA,dt3$First))
      dt3$First <- ifelse((trimws(as.character(dt3$First))==trimws(".")),NA,dt3$First)
      suppressWarnings(dt3$First <- ifelse(!is.na(as.numeric(".")) & (trimws(as.character(dt3$First))==as.character(as.numeric("."))),NA,dt3$First))
      dt3$Secthird <- ifelse((trimws(as.character(dt3$Secthird))==trimws("blank")),NA,dt3$Secthird)
      suppressWarnings(dt3$Secthird <- ifelse(!is.na(as.numeric("blank")) & (trimws(as.character(dt3$Secthird))==as.character(as.numeric("blank"))),NA,dt3$Secthird))
      dt3$Secthird <- ifelse((trimws(as.character(dt3$Secthird))==trimws(".")),NA,dt3$Secthird)
      suppressWarnings(dt3$Secthird <- ifelse(!is.na(as.numeric(".")) & (trimws(as.character(dt3$Secthird))==as.character(as.numeric("."))),NA,dt3$Secthird))
      dt3$Forth <- ifelse((trimws(as.character(dt3$Forth))==trimws("blank")),NA,dt3$Forth)
      suppressWarnings(dt3$Forth <- ifelse(!is.na(as.numeric("blank")) & (trimws(as.character(dt3$Forth))==as.character(as.numeric("blank"))),NA,dt3$Forth))
      dt3$Forth <- ifelse((trimws(as.character(dt3$Forth))==trimws(".")),NA,dt3$Forth)
      suppressWarnings(dt3$Forth <- ifelse(!is.na(as.numeric(".")) & (trimws(as.character(dt3$Forth))==as.character(as.numeric("."))),NA,dt3$Forth))
      dt3$Fifth <- ifelse((trimws(as.character(dt3$Fifth))==trimws("blank")),NA,dt3$Fifth)
      suppressWarnings(dt3$Fifth <- ifelse(!is.na(as.numeric("blank")) & (trimws(as.character(dt3$Fifth))==as.character(as.numeric("blank"))),NA,dt3$Fifth))
      dt3$Fifth <- ifelse((trimws(as.character(dt3$Fifth))==trimws(".")),NA,dt3$Fifth)
      suppressWarnings(dt3$Fifth <- ifelse(!is.na(as.numeric(".")) & (trimws(as.character(dt3$Fifth))==as.character(as.numeric("."))),NA,dt3$Fifth))
      dt3$Female <- ifelse((trimws(as.character(dt3$Female))==trimws("blank")),NA,dt3$Female)
      suppressWarnings(dt3$Female <- ifelse(!is.na(as.numeric("blank")) & (trimws(as.character(dt3$Female))==as.character(as.numeric("blank"))),NA,dt3$Female))
      dt3$Female <- ifelse((trimws(as.character(dt3$Female))==trimws(".")),NA,dt3$Female)
      suppressWarnings(dt3$Female <- ifelse(!is.na(as.numeric(".")) & (trimws(as.character(dt3$Female))==as.character(as.numeric("."))),NA,dt3$Female))
      dt3$Male <- ifelse((trimws(as.character(dt3$Male))==trimws("blank")),NA,dt3$Male)
      suppressWarnings(dt3$Male <- ifelse(!is.na(as.numeric("blank")) & (trimws(as.character(dt3$Male))==as.character(as.numeric("blank"))),NA,dt3$Male))
      dt3$Male <- ifelse((trimws(as.character(dt3$Male))==trimws(".")),NA,dt3$Male)
      suppressWarnings(dt3$Male <- ifelse(!is.na(as.numeric(".")) & (trimws(as.character(dt3$Male))==as.character(as.numeric("."))),NA,dt3$Male))
      dt3$Total <- ifelse((trimws(as.character(dt3$Total))==trimws(".")),NA,dt3$Total)
      suppressWarnings(dt3$Total <- ifelse(!is.na(as.numeric(".")) & (trimws(as.character(dt3$Total))==as.character(as.numeric("."))),NA,dt3$Total))


      # Here is the structure of the input data frame:
      str(dt3)
      attach(dt3)
      # The analyses below are basic descriptions of the variables. After testing, they should be replaced.

      summary(Datacode)
      summary(Rectype)
      summary(Recyear)
      summary(Recmonth)
      summary(Recday)
      summary(Watershed)
      summary(Repsite)
      summary(Spcode)
      summary(Genus)
      summary(Species)
      summary(First)
      summary(Secthird)
      summary(Forth)
      summary(Fifth)
      summary(Female)
      summary(Male)
      summary(Total)
      summary(Comments)
      # Get more details on character variables

      summary(as.factor(dt3$Datacode))
      summary(as.factor(dt3$Watershed))
      summary(as.factor(dt3$Repsite))
      summary(as.factor(dt3$Genus))
      summary(as.factor(dt3$Species))
      summary(as.factor(dt3$Comments))
      detach(dt3)


}


