## bateman_2018

# Package ID: knb-lter-cap.641.3 Cataloging System:https://pasta.edirepository.org.
# Data set title: Point-count bird censusing: long-term monitoring of bird abundance and diversity along the Salt River in the greater Phoenix metropolitan area, ongoing since 2013.
# Data set creator:  Heather Bateman - Arizona State University
# Data set creator:  Dan Childers - Arizona State University
# Data set creator:  Paige Warren - University of Massachusetts-Amherst
# Metadata Provider:  Stevan Earl - Arizona State University
# Metadata Provider:  Sally Wittlinger - Arizona State University
# Contact:    - Data Manager Julie Ann Wrigley Global Institute of Sustainability, Arizona State University  - caplter.data@asu.edu
# Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu



infile1 <- 'data/raw data/bateman_2018/641_srbp_birds_7ffe7d716e64a4def128217851d6f2d0.csv'
if(!dir.exists('data/raw data/bateman_2018/') || !file.exists(infile1))   {
   dir.create('data/raw data/bateman_2018/', showWarnings = FALSE)
   inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-cap/641/3/a631fee154d9e4caaabb5a423b69c323"
   download.file(inUrl1,infile1,method="curl")
}



dt1 <-read.csv(infile1,header=F
               ,skip=1
               ,sep=","
               ,quot='"'
               , col.names=c(
                  "site_code",
                  "reach",
                  "survey_date",
                  "time_start",
                  "time_end",
                  "observer_initials",
                  "survey_notes",
                  "human_activity_notes",
                  "wind",
                  "precipitation",
                  "disturbances",
                  "sight_obstruct",
                  "noise_level",
                  "site_condition",
                  "non_bird_species",
                  "code",
                  "common_name",
                  "distance",
                  "bird_count",
                  "observation_notes",
                  "seen",
                  "heard",
                  "direction",
                  "QCcomment"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt1$site_code)!="factor") dt1$site_code<- as.factor(dt1$site_code)
if (class(dt1$reach)!="factor") dt1$reach<- as.factor(dt1$reach)
# attempting to convert dt1$survey_date dateTime string to R date structure (date or POSIXct)
tmpDateFormat<-"%Y-%m-%d"
tmp1survey_date<-as.Date(dt1$survey_date,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp1survey_date) == length(tmp1survey_date[!is.na(tmp1survey_date)])){dt1$survey_date <- tmp1survey_date } else {print("Date conversion failed for dt1$survey_date. Please inspect the data and do the date conversion yourself.")}
rm(tmpDateFormat,tmp1survey_date)
if (class(dt1$observer_initials)!="factor") dt1$observer_initials<- as.factor(dt1$observer_initials)
if (class(dt1$survey_notes)!="factor") dt1$survey_notes<- as.factor(dt1$survey_notes)
if (class(dt1$human_activity_notes)!="factor") dt1$human_activity_notes<- as.factor(dt1$human_activity_notes)
if (class(dt1$wind)!="factor") dt1$wind<- as.factor(dt1$wind)
if (class(dt1$precipitation)!="factor") dt1$precipitation<- as.factor(dt1$precipitation)
if (class(dt1$disturbances)!="factor") dt1$disturbances<- as.factor(dt1$disturbances)
if (class(dt1$sight_obstruct)=="factor") dt1$sight_obstruct <-as.numeric(levels(dt1$sight_obstruct))[as.integer(dt1$sight_obstruct) ]
if (class(dt1$sight_obstruct)=="character") dt1$sight_obstruct <-as.numeric(dt1$sight_obstruct)
if (class(dt1$noise_level)!="factor") dt1$noise_level<- as.factor(dt1$noise_level)
if (class(dt1$site_condition)!="factor") dt1$site_condition<- as.factor(dt1$site_condition)
if (class(dt1$non_bird_species)!="factor") dt1$non_bird_species<- as.factor(dt1$non_bird_species)
if (class(dt1$code)!="factor") dt1$code<- as.factor(dt1$code)
if (class(dt1$common_name)!="factor") dt1$common_name<- as.factor(dt1$common_name)
if (class(dt1$distance)!="factor") dt1$distance<- as.factor(dt1$distance)
if (class(dt1$bird_count)=="factor") dt1$bird_count <-as.numeric(levels(dt1$bird_count))[as.integer(dt1$bird_count) ]
if (class(dt1$bird_count)=="character") dt1$bird_count <-as.numeric(dt1$bird_count)
if (class(dt1$observation_notes)!="factor") dt1$observation_notes<- as.factor(dt1$observation_notes)
if (class(dt1$seen)!="factor") dt1$seen<- as.factor(dt1$seen)
if (class(dt1$heard)!="factor") dt1$heard<- as.factor(dt1$heard)
if (class(dt1$direction)!="factor") dt1$direction<- as.factor(dt1$direction)
if (class(dt1$QCcomment)!="factor") dt1$QCcomment<- as.factor(dt1$QCcomment)

# Convert Missing Values to NA for non-dates

ddata <- dt1
save(ddata, file = 'data/raw data/bateman_2018/ddata')


if(FALSE) {
   # Here is the structure of the input data frame:
   str(dt1)
   attach(dt1)
   # The analyses below are basic descriptions of the variables. After testing, they should be replaced.

   summary(site_code)
   summary(reach)
   summary(survey_date)
   summary(time_start)
   summary(time_end)
   summary(observer_initials)
   summary(survey_notes)
   summary(human_activity_notes)
   summary(wind)
   summary(precipitation)
   summary(disturbances)
   summary(sight_obstruct)
   summary(noise_level)
   summary(site_condition)
   summary(non_bird_species)
   summary(code)
   summary(common_name)
   summary(distance)
   summary(bird_count)
   summary(observation_notes)
   summary(seen)
   summary(heard)
   summary(direction)
   summary(QCcomment)
   # Get more details on character variables

   summary(as.factor(dt1$site_code))
   summary(as.factor(dt1$reach))
   summary(as.factor(dt1$observer_initials))
   summary(as.factor(dt1$survey_notes))
   summary(as.factor(dt1$human_activity_notes))
   summary(as.factor(dt1$wind))
   summary(as.factor(dt1$precipitation))
   summary(as.factor(dt1$disturbances))
   summary(as.factor(dt1$noise_level))
   summary(as.factor(dt1$site_condition))
   summary(as.factor(dt1$non_bird_species))
   summary(as.factor(dt1$code))
   summary(as.factor(dt1$common_name))
   summary(as.factor(dt1$distance))
   summary(as.factor(dt1$observation_notes))
   summary(as.factor(dt1$seen))
   summary(as.factor(dt1$heard))
   summary(as.factor(dt1$direction))
   summary(as.factor(dt1$QCcomment))
   detach(dt1)
}


## 641_srbp_reach_characteristics_453adbb454461211a422b296eee869c9.csv
if(FALSE) {
      inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-cap/641/3/a8dc076cc0cce5a25716f536423c71e1"
      infile2 <- tempfile()
      download.file(inUrl2,infile2,method="auto")


      dt2 <-read.csv(infile2,header=F
                     ,skip=1
                     ,sep=","
                     ,quot='"'
                     , col.names=c(
                        "site_code",
                        "reach",
                        "urbanized",
                        "restored",
                        "water"    ), check.names=TRUE)


      # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

      if (class(dt2$site_code)!="factor") dt2$site_code<- as.factor(dt2$site_code)
      if (class(dt2$reach)!="factor") dt2$reach<- as.factor(dt2$reach)
      if (class(dt2$urbanized)!="factor") dt2$urbanized<- as.factor(dt2$urbanized)
      if (class(dt2$restored)!="factor") dt2$restored<- as.factor(dt2$restored)
      if (class(dt2$water)!="factor") dt2$water<- as.factor(dt2$water)

      # Convert Missing Values to NA for non-dates



      # Here is the structure of the input data frame:
      str(dt2)
      attach(dt2)
      # The analyses below are basic descriptions of the variables. After testing, they should be replaced.

      summary(site_code)
      summary(reach)
      summary(urbanized)
      summary(restored)
      summary(water)
      # Get more details on character variables

      summary(as.factor(dt2$site_code))
      summary(as.factor(dt2$reach))
      summary(as.factor(dt2$urbanized))
      summary(as.factor(dt2$restored))
      summary(as.factor(dt2$water))
      detach(dt2)


}


