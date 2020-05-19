## gholz_2019

# Package ID: knb-lter-and.3213.11 Cataloging System:https://pasta.edirepository.org.
# Data set title: Post-logging community structure and biomass accumulation in Watershed 10, Andrews Experimental Forest , 1974 to present.
# Data set creator:    - Andrews Forest LTER Site
# Data set creator:  Henry Gholz -
# Contact:    - Information Manager   - hjaweb@fsl.orst.edu
# Stylesheet v2.10 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu

infile4 <- 'data/raw data/gholz_2019/TP04104.csv'
if(!dir.exists('data/raw data/gholz_2019/') || !file.exists(infile4))   {
   dir.create('data/raw data/gholz_2019/')
   inUrl4  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-and/3213/11/bf3f0adb4d6ad551e2a8896eae1d15a7"
   download.file(inUrl4, infile4, method="curl",  showWarnings = FALSE)
}

dt4 <-read.csv(infile4, header=F
               ,skip=1
               ,sep=","
               ,quot='"'
               , col.names=c(
                  "DBCODE",
                  "ENTITY",
                  "WATERSHED",
                  "PLOTID",
                  "YEAR",
                  "PLOT",
                  "SPECIES",
                  "STRATUM",
                  "COVER",
                  "FREQ"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt4$DBCODE)!="factor") dt4$DBCODE<- as.factor(dt4$DBCODE)
if (class(dt4$ENTITY)=="factor") dt4$ENTITY <-as.numeric(levels(dt4$ENTITY))[as.integer(dt4$ENTITY) ]
if (class(dt4$ENTITY)=="character") dt4$ENTITY <-as.numeric(dt4$ENTITY)
if (class(dt4$WATERSHED)!="factor") dt4$WATERSHED<- as.factor(dt4$WATERSHED)
if (class(dt4$PLOTID)!="factor") dt4$PLOTID<- as.factor(dt4$PLOTID)
if (class(dt4$YEAR)=="factor") dt4$YEAR <-as.numeric(levels(dt4$YEAR))[as.integer(dt4$YEAR) ]
if (class(dt4$YEAR)=="character") dt4$YEAR <-as.numeric(dt4$YEAR)
if (class(dt4$PLOT)=="factor") dt4$PLOT <-as.numeric(levels(dt4$PLOT))[as.integer(dt4$PLOT) ]
if (class(dt4$PLOT)=="character") dt4$PLOT <-as.numeric(dt4$PLOT)
if (class(dt4$SPECIES)!="factor") dt4$SPECIES<- as.factor(dt4$SPECIES)
if (class(dt4$STRATUM)!="factor") dt4$STRATUM<- as.factor(dt4$STRATUM)
if (class(dt4$COVER)=="factor") dt4$COVER <-as.numeric(levels(dt4$COVER))[as.integer(dt4$COVER) ]
if (class(dt4$COVER)=="character") dt4$COVER <-as.numeric(dt4$COVER)
if (class(dt4$FREQ)=="factor") dt4$FREQ <-as.numeric(levels(dt4$FREQ))[as.integer(dt4$FREQ) ]
if (class(dt4$FREQ)=="character") dt4$FREQ <-as.numeric(dt4$FREQ)

#


infile6 <- 'data/raw data/gholz_2019/TP04106.csv'
if(!dir.exists('data/raw data/gholz_2019/') || !file.exists(infile6))   {
   dir.create('data/raw data/gholz_2019/')
   inUrl6  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-and/3213/11/afa28c074902736ec6a86bf048fa17af"
   download.file(inUrl6, infile6, method="curl",  showWarnings = FALSE)
}



dt6 <-read.csv(infile6,header=F
               ,skip=1
               ,sep=","
               ,quot='"'
               , col.names=c(
                  "DBCODE",
                  "ENTITY",
                  "WATERSHED",
                  "YEAR",
                  "PLOTID",
                  "HABTYPE",
                  "PLOT",
                  "TREE_SPP",
                  "SAPCOUNT",
                  "SEEDLCNT"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt6$DBCODE)!="factor") dt6$DBCODE<- as.factor(dt6$DBCODE)
if (class(dt6$ENTITY)=="factor") dt6$ENTITY <-as.numeric(levels(dt6$ENTITY))[as.integer(dt6$ENTITY) ]
if (class(dt6$ENTITY)=="character") dt6$ENTITY <-as.numeric(dt6$ENTITY)
if (class(dt6$WATERSHED)!="factor") dt6$WATERSHED<- as.factor(dt6$WATERSHED)
if (class(dt6$YEAR)=="factor") dt6$YEAR <-as.numeric(levels(dt6$YEAR))[as.integer(dt6$YEAR) ]
if (class(dt6$YEAR)=="character") dt6$YEAR <-as.numeric(dt6$YEAR)
if (class(dt6$PLOTID)!="factor") dt6$PLOTID<- as.factor(dt6$PLOTID)
if (class(dt6$HABTYPE)!="factor") dt6$HABTYPE<- as.factor(dt6$HABTYPE)
if (class(dt6$PLOT)=="factor") dt6$PLOT <-as.numeric(levels(dt6$PLOT))[as.integer(dt6$PLOT) ]
if (class(dt6$PLOT)=="character") dt6$PLOT <-as.numeric(dt6$PLOT)
if (class(dt6$TREE_SPP)!="factor") dt6$TREE_SPP<- as.factor(dt6$TREE_SPP)
if (class(dt6$SAPCOUNT)=="factor") dt6$SAPCOUNT <-as.numeric(levels(dt6$SAPCOUNT))[as.integer(dt6$SAPCOUNT) ]
if (class(dt6$SAPCOUNT)=="character") dt6$SAPCOUNT <-as.numeric(dt6$SAPCOUNT)
if (class(dt6$SEEDLCNT)=="factor") dt6$SEEDLCNT <-as.numeric(levels(dt6$SEEDLCNT))[as.integer(dt6$SEEDLCNT) ]
if (class(dt6$SEEDLCNT)=="character") dt6$SEEDLCNT <-as.numeric(dt6$SEEDLCNT)

dt6$SEEDLCNT) ]
if (class(dt6$SEEDLCNT)=="character") dt6$SEEDLCNT <-as.numeric(dt6$SEEDLCNT)



