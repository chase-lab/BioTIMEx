## hershey_2016


# Package ID: knb-lter-arc.1125.3 Cataloging System:https://pasta.lternet.edu.
# Data set title: Total numbers and species of insects taken from rock scrubbings during the summer of 1984-1988, 1993-1994, 1996-1998, in the Kuparuk River experimental reach near Toolik Field Station, North Slope Alaska...
# Data set creator:  Ann Hershey -
# Metadata Provider:  Arctic LTER MBL -
# Contact:    - Information Manager LTER Network Office  - tech-support@lternet.edu
# Contact:  Arctic_LTER Information Manager -    - arc_im@mbl.edu
# Metadata Link: https://portal.lternet.edu/nis/metadataviewer?packageid=knb-lter-arc.1125.3
# Stylesheet v2.10 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu

dataset_id <- 'hershey_2016'
infile1 <- 'data/raw data/hershey_2016/84-98hektot.csv'
if(!dir.exists('data/raw data/hershey_2016/') || !file.exists(infile1))   {
   dir.create('data/raw data/hershey_2016/',  showWarnings = FALSE)
   inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-arc/1125/3/9e3ce25f9861c0dccc40f2258a7babef"
   download.file(inUrl1, infile1, method="curl")
}


dt1 <-read.csv(infile1,header=F
               ,skip=1
               ,sep=","
               ,quot='"'
               , col.names=c(
                  "Site",
                  "Stream.Type",
                  "Sample.Type",
                  "Date",
                  "station.m",   # modified
                  "Trial",
                  "RHYAC",
                  "BRACHY",
                  "NATARSIA",
                  "ORTHO",
                  "OTHCHIR",
                  "CHIPUPA",
                  "BLACK",
                  "BLKPUPA",
                  "BAETIS",
                  "BAETSP3",
                  "EPHEM",
                  "CINYG",
                  "NEMOURA",
                  "TIPULA",
                  "SNAILS"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt1$Site)!="factor") dt1$Site<- as.factor(dt1$Site)
if (class(dt1$Stream.Type)!="factor") dt1$Stream.Type<- as.factor(dt1$Stream.Type)
if (class(dt1$Sample.Type)!="factor") dt1$Sample.Type<- as.factor(dt1$Sample.Type)
if (class(dt1$station.m)!="factor") dt1$station.m<- as.factor(dt1$station.m)
if (class(dt1$Trial)!="factor") dt1$Trial<- as.factor(dt1$Trial)
if (class(dt1$RHYAC)=="factor") dt1$RHYAC <-as.numeric(levels(dt1$RHYAC))[as.integer(dt1$RHYAC) ]
if (class(dt1$RHYAC)=="character") dt1$RHYAC <-as.numeric(dt1$RHYAC)
if (class(dt1$BRACHY)=="factor") dt1$BRACHY <-as.numeric(levels(dt1$BRACHY))[as.integer(dt1$BRACHY) ]
if (class(dt1$BRACHY)=="character") dt1$BRACHY <-as.numeric(dt1$BRACHY)
if (class(dt1$NATARSIA)=="factor") dt1$NATARSIA <-as.numeric(levels(dt1$NATARSIA))[as.integer(dt1$NATARSIA) ]
if (class(dt1$NATARSIA)=="character") dt1$NATARSIA <-as.numeric(dt1$NATARSIA)
if (class(dt1$ORTHO)=="factor") dt1$ORTHO <-as.numeric(levels(dt1$ORTHO))[as.integer(dt1$ORTHO) ]
if (class(dt1$ORTHO)=="character") dt1$ORTHO <-as.numeric(dt1$ORTHO)
if (class(dt1$OTHCHIR)=="factor") dt1$OTHCHIR <-as.numeric(levels(dt1$OTHCHIR))[as.integer(dt1$OTHCHIR) ]
if (class(dt1$OTHCHIR)=="character") dt1$OTHCHIR <-as.numeric(dt1$OTHCHIR)
if (class(dt1$CHIPUPA)=="factor") dt1$CHIPUPA <-as.numeric(levels(dt1$CHIPUPA))[as.integer(dt1$CHIPUPA) ]
if (class(dt1$CHIPUPA)=="character") dt1$CHIPUPA <-as.numeric(dt1$CHIPUPA)
if (class(dt1$BLACK)=="factor") dt1$BLACK <-as.numeric(levels(dt1$BLACK))[as.integer(dt1$BLACK) ]
if (class(dt1$BLACK)=="character") dt1$BLACK <-as.numeric(dt1$BLACK)
if (class(dt1$BLKPUPA)=="factor") dt1$BLKPUPA <-as.numeric(levels(dt1$BLKPUPA))[as.integer(dt1$BLKPUPA) ]
if (class(dt1$BLKPUPA)=="character") dt1$BLKPUPA <-as.numeric(dt1$BLKPUPA)
if (class(dt1$BAETIS)=="factor") dt1$BAETIS <-as.numeric(levels(dt1$BAETIS))[as.integer(dt1$BAETIS) ]
if (class(dt1$BAETIS)=="character") dt1$BAETIS <-as.numeric(dt1$BAETIS)
if (class(dt1$BAETSP3)=="factor") dt1$BAETSP3 <-as.numeric(levels(dt1$BAETSP3))[as.integer(dt1$BAETSP3) ]
if (class(dt1$BAETSP3)=="character") dt1$BAETSP3 <-as.numeric(dt1$BAETSP3)
if (class(dt1$EPHEM)=="factor") dt1$EPHEM <-as.numeric(levels(dt1$EPHEM))[as.integer(dt1$EPHEM) ]
if (class(dt1$EPHEM)=="character") dt1$EPHEM <-as.numeric(dt1$EPHEM)
if (class(dt1$CINYG)=="factor") dt1$CINYG <-as.numeric(levels(dt1$CINYG))[as.integer(dt1$CINYG) ]
if (class(dt1$CINYG)=="character") dt1$CINYG <-as.numeric(dt1$CINYG)
if (class(dt1$NEMOURA)=="factor") dt1$NEMOURA <-as.numeric(levels(dt1$NEMOURA))[as.integer(dt1$NEMOURA) ]
if (class(dt1$NEMOURA)=="character") dt1$NEMOURA <-as.numeric(dt1$NEMOURA)
if (class(dt1$TIPULA)=="factor") dt1$TIPULA <-as.numeric(levels(dt1$TIPULA))[as.integer(dt1$TIPULA) ]
if (class(dt1$TIPULA)=="character") dt1$TIPULA <-as.numeric(dt1$TIPULA)
if (class(dt1$SNAILS)=="factor") dt1$SNAILS <-as.numeric(levels(dt1$SNAILS))[as.integer(dt1$SNAILS) ]
if (class(dt1$SNAILS)=="character") dt1$SNAILS <-as.numeric(dt1$SNAILS)

# Convert Missing Values to NA for non-dates


ddata <- dt1
save(ddata, file=paste0('data/raw data/', dataset_id,'/ddata'))



