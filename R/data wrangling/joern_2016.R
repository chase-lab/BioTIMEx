## joern_2016
   # Package ID: knb-lter-knz.32.7 Cataloging System:https://pasta.lternet.edu.
   # Data set title: CGR05 Effects of fire frequency on composition of grasshopper assemblages on Konza Prairie LTER Watersheds(1983).
   # Data set creator:  Anthony Joern -
   # Contact:    - Information Manager LTER Network Office  - tech-support@lternet.edu
   # Contact:    - KNZ-LTER Data Manager   - knzlter@ksu.edu
   # Metadata Link: https://portal.lternet.edu/nis/metadataviewer?packageid=knb-lter-knz.32.7
   # Stylesheet v2.7 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu

infile1 <- 'data/raw data/joern_2016/dt1.csv'
if(!dir.exists('data/raw data/joern_2016/') || !file.exists(infile1))   {
   dir.create('data/raw data/joern_2016/')
   inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-knz/32/7/d9a1a1d137657204fdc5a4d5e76d57a4"
   download.file(inUrl1,infile1,method="auto")
}
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
                     "Repsite",
                     "Spcode",
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
                     "Total"    ), check.names=TRUE)


   # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

   if (class(dt1$DataCode)!="factor") dt1$DataCode<- as.factor(dt1$DataCode)
   if (class(dt1$RecType)!="factor") dt1$RecType<- as.factor(dt1$RecType)
   if (class(dt1$Watershed)!="factor") dt1$Watershed<- as.factor(dt1$Watershed)
   if (class(dt1$Repsite)!="factor") dt1$Repsite<- as.factor(dt1$Repsite)
   if (class(dt1$Spcode)!="factor") dt1$Spcode<- as.factor(dt1$Spcode)
   if (class(dt1$Species)!="factor") dt1$Species<- as.factor(dt1$Species)
   if (class(dt1$S1)=="factor") dt1$S1 <-as.numeric(levels(dt1$S1))[as.integer(dt1$S1) ]
   if (class(dt1$S2)=="factor") dt1$S2 <-as.numeric(levels(dt1$S2))[as.integer(dt1$S2) ]
   if (class(dt1$S3)=="factor") dt1$S3 <-as.numeric(levels(dt1$S3))[as.integer(dt1$S3) ]
   if (class(dt1$S4)=="factor") dt1$S4 <-as.numeric(levels(dt1$S4))[as.integer(dt1$S4) ]
   if (class(dt1$S5)=="factor") dt1$S5 <-as.numeric(levels(dt1$S5))[as.integer(dt1$S5) ]
   if (class(dt1$S6)=="factor") dt1$S6 <-as.numeric(levels(dt1$S6))[as.integer(dt1$S6) ]
   if (class(dt1$S7)=="factor") dt1$S7 <-as.numeric(levels(dt1$S7))[as.integer(dt1$S7) ]
   if (class(dt1$S8)=="factor") dt1$S8 <-as.numeric(levels(dt1$S8))[as.integer(dt1$S8) ]
   if (class(dt1$S9)=="factor") dt1$S9 <-as.numeric(levels(dt1$S9))[as.integer(dt1$S9) ]
   if (class(dt1$S10)=="factor") dt1$S10 <-as.numeric(levels(dt1$S10))[as.integer(dt1$S10) ]
   if (class(dt1$Total)=="factor") dt1$Total <-as.numeric(levels(dt1$Total))[as.integer(dt1$Total) ]

   # Convert Missing Values to NA for non-dates



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
   summary(Repsite)
   summary(Spcode)
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
   detach(dt1)


   infile2 <- 'data/raw data/joern_2016/dt2.csv'
if(!file.exists(infile2)){
   inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-knz/32/7/ff44c93fe3b3fa503fee56c4adb1daea"
   download.file(inUrl2,infile2,method="auto")
}

   dt2 <-read.csv(infile2,header=F
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
                     "Repsite",
                     "Spcode",
                     "Species",
                     "S11",
                     "S12",
                     "S13",
                     "S14",
                     "S15",
                     "S16",
                     "S17",
                     "S18",
                     "S19",
                     "S20",
                     "Total"    ), check.names=TRUE)


   # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

   if (class(dt2$DataCode)!="factor") dt2$DataCode<- as.factor(dt2$DataCode)
   if (class(dt2$RecType)!="factor") dt2$RecType<- as.factor(dt2$RecType)
   if (class(dt2$Watershed)!="factor") dt2$Watershed<- as.factor(dt2$Watershed)
   if (class(dt2$Repsite)!="factor") dt2$Repsite<- as.factor(dt2$Repsite)
   if (class(dt2$Spcode)!="factor") dt2$Spcode<- as.factor(dt2$Spcode)
   if (class(dt2$Species)!="factor") dt2$Species<- as.factor(dt2$Species)
   if (class(dt2$S11)=="factor") dt2$S11 <-as.numeric(levels(dt2$S11))[as.integer(dt2$S11) ]
   if (class(dt2$S12)=="factor") dt2$S12 <-as.numeric(levels(dt2$S12))[as.integer(dt2$S12) ]
   if (class(dt2$S13)=="factor") dt2$S13 <-as.numeric(levels(dt2$S13))[as.integer(dt2$S13) ]
   if (class(dt2$S14)=="factor") dt2$S14 <-as.numeric(levels(dt2$S14))[as.integer(dt2$S14) ]
   if (class(dt2$S15)=="factor") dt2$S15 <-as.numeric(levels(dt2$S15))[as.integer(dt2$S15) ]
   if (class(dt2$S16)=="factor") dt2$S16 <-as.numeric(levels(dt2$S16))[as.integer(dt2$S16) ]
   if (class(dt2$S17)=="factor") dt2$S17 <-as.numeric(levels(dt2$S17))[as.integer(dt2$S17) ]
   if (class(dt2$S18)=="factor") dt2$S18 <-as.numeric(levels(dt2$S18))[as.integer(dt2$S18) ]
   if (class(dt2$S19)=="factor") dt2$S19 <-as.numeric(levels(dt2$S19))[as.integer(dt2$S19) ]
   if (class(dt2$S20)=="factor") dt2$S20 <-as.numeric(levels(dt2$S20))[as.integer(dt2$S20) ]
   if (class(dt2$Total)=="factor") dt2$Total <-as.numeric(levels(dt2$Total))[as.integer(dt2$Total) ]

   # Convert Missing Values to NA for non-dates



   # Here is the structure of the input data frame:
   str(dt2)
   attach(dt2)
   # The analyses below are basic descriptions of the variables. After testing, they should be replaced.

   summary(DataCode)
   summary(RecType)
   summary(RecYear)
   summary(RecMonth)
   summary(RecDay)
   summary(Watershed)
   summary(Repsite)
   summary(Spcode)
   summary(Species)
   summary(S11)
   summary(S12)
   summary(S13)
   summary(S14)
   summary(S15)
   summary(S16)
   summary(S17)
   summary(S18)
   summary(S19)
   summary(S20)
   summary(Total)
   detach(dt2)


   infile3 <- 'data/raw data/joern_2016/dt3.csv'
   if(!file.exists(infile3)){
   inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-knz/32/7/67cd5fc63ad43160d8db1efe50fba7e2"
   download.file(inUrl3,infile3,method="auto")
}

   dt3 <-read.csv(infile3,header=F
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
                     "Repsite",
                     "Spcode",
                     "Species",
                     "FirstInstar",
                     "SecondInstar",
                     "ThirdInstar",
                     "FourthInstar",
                     "FifthInstar",
                     "Female",
                     "Male",
                     "Total"    ), check.names=TRUE)


   # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

   if (class(dt3$DataCode)!="factor") dt3$DataCode<- as.factor(dt3$DataCode)
   if (class(dt3$RecType)!="factor") dt3$RecType<- as.factor(dt3$RecType)
   if (class(dt3$Watershed)!="factor") dt3$Watershed<- as.factor(dt3$Watershed)
   if (class(dt3$Repsite)!="factor") dt3$Repsite<- as.factor(dt3$Repsite)
   if (class(dt3$Spcode)!="factor") dt3$Spcode<- as.factor(dt3$Spcode)
   if (class(dt3$Species)!="factor") dt3$Species<- as.factor(dt3$Species)
   if (class(dt3$FirstInstar)=="factor") dt3$FirstInstar <-as.numeric(levels(dt3$FirstInstar))[as.integer(dt3$FirstInstar) ]
   if (class(dt3$SecondInstar)=="factor") dt3$SecondInstar <-as.numeric(levels(dt3$SecondInstar))[as.integer(dt3$SecondInstar) ]
   if (class(dt3$ThirdInstar)=="factor") dt3$ThirdInstar <-as.numeric(levels(dt3$ThirdInstar))[as.integer(dt3$ThirdInstar) ]
   if (class(dt3$FourthInstar)=="factor") dt3$FourthInstar <-as.numeric(levels(dt3$FourthInstar))[as.integer(dt3$FourthInstar) ]
   if (class(dt3$FifthInstar)=="factor") dt3$FifthInstar <-as.numeric(levels(dt3$FifthInstar))[as.integer(dt3$FifthInstar) ]
   if (class(dt3$Female)=="factor") dt3$Female <-as.numeric(levels(dt3$Female))[as.integer(dt3$Female) ]
   if (class(dt3$Male)=="factor") dt3$Male <-as.numeric(levels(dt3$Male))[as.integer(dt3$Male) ]
   if (class(dt3$Total)=="factor") dt3$Total <-as.numeric(levels(dt3$Total))[as.integer(dt3$Total) ]

   # Convert Missing Values to NA for non-dates



   # Here is the structure of the input data frame:
   str(dt3)
   attach(dt3)
   # The analyses below are basic descriptions of the variables. After testing, they should be replaced.

   summary(DataCode)
   summary(RecType)
   summary(RecYear)
   summary(RecMonth)
   summary(RecDay)
   summary(Watershed)
   summary(Repsite)
   summary(Spcode)
   summary(Species)
   summary(FirstInstar)
   summary(SecondInstar)
   summary(ThirdInstar)
   summary(FourthInstar)
   summary(FifthInstar)
   summary(Female)
   summary(Male)
   summary(Total)
   detach(dt3)





