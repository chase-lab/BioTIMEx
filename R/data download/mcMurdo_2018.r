### mcMurdo_2018

# Package ID: knb-lter-mcm.3004.1 Cataloging System:https://pasta.edirepository.org.
# Data set title: McMurdo Dry Valleys LTER: Transplant Lake Integrated Connectivity Experiment (tLICE) in Taylor Valley, Antarctica, January 2018.
# Data set creator:    - McMurdo Dry Valleys LTER
# Data set creator:  Rachael Morgan-Kiss -
# Metadata Provider:    - McMurdo Dry Valleys LTER
# Contact:  McMurdo Dry Valleys LTER Information Manager -    - im@mcmlter.org
# Stylesheet v2.7 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu


infile1 <- 'data/raw data/mcMurdo_2018/LIMNO_TLICE.csv'
if(!dir.exists('data/raw data/mcMurdo_2018/') || !file.exists(infile1)) {
   dir.create('data/raw data/mcMurdo_2018/')
   inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/3004/1/e63fd9bf394fac51670e2a2dd4657695"
   download.file(inUrl1, infile1, method="auto")
}

dt1 <-read.csv(infile1, header=F
               ,skip=1
               ,sep=","
               ,quot='"'
               , col.names=c(
                  "DATASET_CODE",
                  "COLLECTION_DATE",
                  "LOCATION",
                  "SAMPLE_TYPE",
                  "TREATMENT",
                  "REPLICATE",
                  "TIMEPOINT",
                  "DEPTH_M",
                  "SRP_MM",
                  "NO2_MM",
                  "NO3_MM",
                  "NH4_MM",
                  "CHLA_UG_L",
                  "CHLA_BL_UG_L",
                  "CHLA_GR_UG_L",
                  "CHLA_BR_UG_L",
                  "CHLA_PE_UG_L",
                  "CHLA_TOTAL_UG_L",
                  "FV_FM_BL",
                  "FV_FM_GR",
                  "FV_FM_BR",
                  "FV_FM_PE",
                  "YII_BL",
                  "YII_GR",
                  "YII_BR",
                  "YII_PE",
                  "NPQ_BL",
                  "NPQ_GR",
                  "NPQ_BR",
                  "NPQ_PE",
                  "NO_BL",
                  "NO_GR",
                  "NO_BR",
                  "NO_PE",
                  "PHOTOTROPHS_CELLS_ML",
                  "HETEROTROPHS_LARGE_CELLS_ML",
                  "HETEROTROPHS_SMALL_CELLS_ML",
                  "ACCN_16S",
                  "ACCN_18S",
                  "COMMENTS"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt1$DATASET_CODE)!="factor") dt1$DATASET_CODE<- as.factor(dt1$DATASET_CODE)
# attempting to convert dt1$COLLECTION_DATE dateTime string to R date structure (date or POSIXct)
tmpDateFormat<-"%m/%d/%y"
tmp1COLLECTION_DATE<-as.Date(dt1$COLLECTION_DATE,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp1COLLECTION_DATE) == length(tmp1COLLECTION_DATE[!is.na(tmp1COLLECTION_DATE)])){dt1$COLLECTION_DATE <- tmp1COLLECTION_DATE } else {print("Date conversion failed for dt1$COLLECTION_DATE. Please inspect the data and do the date conversion yourself.")}
rm(tmpDateFormat,tmp1COLLECTION_DATE)
if (class(dt1$LOCATION)!="factor") dt1$LOCATION<- as.factor(dt1$LOCATION)
if (class(dt1$SAMPLE_TYPE)!="factor") dt1$SAMPLE_TYPE<- as.factor(dt1$SAMPLE_TYPE)
if (class(dt1$TREATMENT)!="factor") dt1$TREATMENT<- as.factor(dt1$TREATMENT)
if (class(dt1$REPLICATE)!="factor") dt1$REPLICATE<- as.factor(dt1$REPLICATE)
if (class(dt1$TIMEPOINT)!="factor") dt1$TIMEPOINT<- as.factor(dt1$TIMEPOINT)
if (class(dt1$DEPTH_M)=="factor") dt1$DEPTH_M <-as.numeric(levels(dt1$DEPTH_M))[as.integer(dt1$DEPTH_M) ]
if (class(dt1$SRP_MM)=="factor") dt1$SRP_MM <-as.numeric(levels(dt1$SRP_MM))[as.integer(dt1$SRP_MM) ]
if (class(dt1$NO2_MM)=="factor") dt1$NO2_MM <-as.numeric(levels(dt1$NO2_MM))[as.integer(dt1$NO2_MM) ]
if (class(dt1$NO3_MM)=="factor") dt1$NO3_MM <-as.numeric(levels(dt1$NO3_MM))[as.integer(dt1$NO3_MM) ]
if (class(dt1$NH4_MM)=="factor") dt1$NH4_MM <-as.numeric(levels(dt1$NH4_MM))[as.integer(dt1$NH4_MM) ]
if (class(dt1$CHLA_UG_L)=="factor") dt1$CHLA_UG_L <-as.numeric(levels(dt1$CHLA_UG_L))[as.integer(dt1$CHLA_UG_L) ]
if (class(dt1$CHLA_BL_UG_L)=="factor") dt1$CHLA_BL_UG_L <-as.numeric(levels(dt1$CHLA_BL_UG_L))[as.integer(dt1$CHLA_BL_UG_L) ]
if (class(dt1$CHLA_GR_UG_L)=="factor") dt1$CHLA_GR_UG_L <-as.numeric(levels(dt1$CHLA_GR_UG_L))[as.integer(dt1$CHLA_GR_UG_L) ]
if (class(dt1$CHLA_BR_UG_L)=="factor") dt1$CHLA_BR_UG_L <-as.numeric(levels(dt1$CHLA_BR_UG_L))[as.integer(dt1$CHLA_BR_UG_L) ]
if (class(dt1$CHLA_PE_UG_L)=="factor") dt1$CHLA_PE_UG_L <-as.numeric(levels(dt1$CHLA_PE_UG_L))[as.integer(dt1$CHLA_PE_UG_L) ]
if (class(dt1$CHLA_TOTAL_UG_L)=="factor") dt1$CHLA_TOTAL_UG_L <-as.numeric(levels(dt1$CHLA_TOTAL_UG_L))[as.integer(dt1$CHLA_TOTAL_UG_L) ]
if (class(dt1$FV_FM_BL)!="factor") dt1$FV_FM_BL<- as.factor(dt1$FV_FM_BL)
if (class(dt1$FV_FM_GR)!="factor") dt1$FV_FM_GR<- as.factor(dt1$FV_FM_GR)
if (class(dt1$FV_FM_BR)!="factor") dt1$FV_FM_BR<- as.factor(dt1$FV_FM_BR)
if (class(dt1$FV_FM_PE)!="factor") dt1$FV_FM_PE<- as.factor(dt1$FV_FM_PE)
if (class(dt1$YII_BL)!="factor") dt1$YII_BL<- as.factor(dt1$YII_BL)
if (class(dt1$YII_GR)!="factor") dt1$YII_GR<- as.factor(dt1$YII_GR)
if (class(dt1$YII_BR)!="factor") dt1$YII_BR<- as.factor(dt1$YII_BR)
if (class(dt1$YII_PE)!="factor") dt1$YII_PE<- as.factor(dt1$YII_PE)
if (class(dt1$NPQ_BL)!="factor") dt1$NPQ_BL<- as.factor(dt1$NPQ_BL)
if (class(dt1$NPQ_GR)!="factor") dt1$NPQ_GR<- as.factor(dt1$NPQ_GR)
if (class(dt1$NPQ_BR)!="factor") dt1$NPQ_BR<- as.factor(dt1$NPQ_BR)
if (class(dt1$NPQ_PE)!="factor") dt1$NPQ_PE<- as.factor(dt1$NPQ_PE)
if (class(dt1$NO_BL)!="factor") dt1$NO_BL<- as.factor(dt1$NO_BL)
if (class(dt1$NO_GR)!="factor") dt1$NO_GR<- as.factor(dt1$NO_GR)
if (class(dt1$NO_BR)!="factor") dt1$NO_BR<- as.factor(dt1$NO_BR)
if (class(dt1$NO_PE)!="factor") dt1$NO_PE<- as.factor(dt1$NO_PE)
if (class(dt1$PHOTOTROPHS_CELLS_ML)=="factor") dt1$PHOTOTROPHS_CELLS_ML <-as.numeric(levels(dt1$PHOTOTROPHS_CELLS_ML))[as.integer(dt1$PHOTOTROPHS_CELLS_ML) ]
if (class(dt1$HETEROTROPHS_LARGE_CELLS_ML)=="factor") dt1$HETEROTROPHS_LARGE_CELLS_ML <-as.numeric(levels(dt1$HETEROTROPHS_LARGE_CELLS_ML))[as.integer(dt1$HETEROTROPHS_LARGE_CELLS_ML) ]
if (class(dt1$HETEROTROPHS_SMALL_CELLS_ML)=="factor") dt1$HETEROTROPHS_SMALL_CELLS_ML <-as.numeric(levels(dt1$HETEROTROPHS_SMALL_CELLS_ML))[as.integer(dt1$HETEROTROPHS_SMALL_CELLS_ML) ]
if (class(dt1$ACCN_16S)!="factor") dt1$ACCN_16S<- as.factor(dt1$ACCN_16S)
if (class(dt1$ACCN_18S)!="factor") dt1$ACCN_18S<- as.factor(dt1$ACCN_18S)
if (class(dt1$COMMENTS)!="factor") dt1$COMMENTS<- as.factor(dt1$COMMENTS)

# Convert Missing Values to NA for non-dates

ddata <- dt1
save(ddata, file = 'data/raw data/mcMurdo_2018/ddata')


extra_downloads <- FALSE
if(extra_downloads) {

         infile2 <- 'data/raw data/mcMurdo_2018/LIMNO_TLICE_CTP.csv'
         if(!file.exists(infile2))   {
            inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/3004/1/6b7f0a3d9c6deb0877ecfaaa3a4008ed"
            download.file(inUrl2,infile2,method="auto")
         }

         dt2 <-read.csv(infile2,header=F
                        ,skip=1
                        ,sep=","
                        ,quot='"'
                        , col.names=c(
                           "DATASET_CODE",
                           "Collection.Date",
                           "LOCATION",
                           "SAMPLE_TYPE",
                           "DEPTH_M",
                           "CONDUCTIVITY_MS_CM",
                           "TEMPERATURE_C",
                           "PAR_UMOL_M2_S",
                           "COMMENTS"    ), check.names=TRUE)


         # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

         if (class(dt2$DATASET_CODE)!="factor") dt2$DATASET_CODE<- as.factor(dt2$DATASET_CODE)
         # attempting to convert dt2$Collection.Date dateTime string to R date structure (date or POSIXct)
         tmpDateFormat<-"%m/%d/%Y"
         tmp2Collection.Date<-as.Date(dt2$Collection.Date,format=tmpDateFormat)
         # Keep the new dates only if they all converted correctly
         if(length(tmp2Collection.Date) == length(tmp2Collection.Date[!is.na(tmp2Collection.Date)])){dt2$Collection.Date <- tmp2Collection.Date } else {print("Date conversion failed for dt2$Collection.Date. Please inspect the data and do the date conversion yourself.")}
         rm(tmpDateFormat,tmp2Collection.Date)
         if (class(dt2$LOCATION)!="factor") dt2$LOCATION<- as.factor(dt2$LOCATION)
         if (class(dt2$SAMPLE_TYPE)!="factor") dt2$SAMPLE_TYPE<- as.factor(dt2$SAMPLE_TYPE)
         if (class(dt2$DEPTH_M)=="factor") dt2$DEPTH_M <-as.numeric(levels(dt2$DEPTH_M))[as.integer(dt2$DEPTH_M) ]
         if (class(dt2$CONDUCTIVITY_MS_CM)=="factor") dt2$CONDUCTIVITY_MS_CM <-as.numeric(levels(dt2$CONDUCTIVITY_MS_CM))[as.integer(dt2$CONDUCTIVITY_MS_CM) ]
         if (class(dt2$TEMPERATURE_C)=="factor") dt2$TEMPERATURE_C <-as.numeric(levels(dt2$TEMPERATURE_C))[as.integer(dt2$TEMPERATURE_C) ]
         if (class(dt2$PAR_UMOL_M2_S)=="factor") dt2$PAR_UMOL_M2_S <-as.numeric(levels(dt2$PAR_UMOL_M2_S))[as.integer(dt2$PAR_UMOL_M2_S) ]
         if (class(dt2$COMMENTS)!="factor") dt2$COMMENTS<- as.factor(dt2$COMMENTS)

         # Convert Missing Values to NA for non-dates
}

