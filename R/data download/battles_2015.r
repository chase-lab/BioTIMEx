## battles_2015

# Package ID: knb-lter-hbr.38.7 Cataloging System:https://pasta.edirepository.org.
# Data set title: Forest Inventory of a Whole Tree Harvest: Hubbard Brook     Experimental Forest Watershed 5, 1994, 10 years     post-harvest.
# Data set creator:  John J. Battles - University of California, Berkeley
# Data set creator:  Tim Fahey - Department of Natural Resources, Cornell University
# Data set creator:  Natalie Cleavitt - Department of Natural Resources, Cornell University
# Metadata Provider:    - Hubbard Brook Experimental Forest LTER
# Contact:    - Information Manager, Hubbard Brook LTER   -     hbr-im@lternet.edu
# Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu


### 1994


infile1 <- 'data/raw data/battles_2015/w5_1994veg.txt'
if(!dir.exists('data/raw data/battles_2015/') || !file.exists(infile1))   {
   dir.create('data/raw data/battles_2015/', showWarnings = FALSE)
   inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-hbr/38/7/7fba976fb7a0c3928d991eec3caa3ec8"
   download.file(inUrl1,infile1,method="curl")
}







dt1 <-read.csv(infile1,header=F
               ,skip=1
               ,sep=","
               , col.names=c(
                  "Plot",
                  "Zone",
                  "Species",
                  "SppNum",
                  "Seq",
                  "Tag",
                  "Dbh",
                  "Vigor",
                  "AbvBmss",
                  "BlwBmss",
                  "Area"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt1$Plot)!="factor") dt1$Plot<- as.factor(dt1$Plot)
if (class(dt1$Zone)!="factor") dt1$Zone<- as.factor(dt1$Zone)
if (class(dt1$Species)!="factor") dt1$Species<- as.factor(dt1$Species)
if (class(dt1$SppNum)!="factor") dt1$SppNum<- as.factor(dt1$SppNum)
if (class(dt1$Seq)!="factor") dt1$Seq<- as.factor(dt1$Seq)
if (class(dt1$Tag)!="factor") dt1$Tag<- as.factor(dt1$Tag)
if (class(dt1$Dbh)=="factor") dt1$Dbh <-as.numeric(levels(dt1$Dbh))[as.integer(dt1$Dbh) ]
if (class(dt1$Dbh)=="character") dt1$Dbh <-as.numeric(dt1$Dbh)
if (class(dt1$Vigor)!="factor") dt1$Vigor<- as.factor(dt1$Vigor)
if (class(dt1$AbvBmss)=="factor") dt1$AbvBmss <-as.numeric(levels(dt1$AbvBmss))[as.integer(dt1$AbvBmss) ]
if (class(dt1$AbvBmss)=="character") dt1$AbvBmss <-as.numeric(dt1$AbvBmss)
if (class(dt1$BlwBmss)=="factor") dt1$BlwBmss <-as.numeric(levels(dt1$BlwBmss))[as.integer(dt1$BlwBmss) ]
if (class(dt1$BlwBmss)=="character") dt1$BlwBmss <-as.numeric(dt1$BlwBmss)
if (class(dt1$Area)=="factor") dt1$Area <-as.numeric(levels(dt1$Area))[as.integer(dt1$Area) ]
if (class(dt1$Area)=="character") dt1$Area <-as.numeric(dt1$Area)

# Convert Missing Values to NA for non-dates

dt1$Tag <- as.factor(ifelse((trimws(as.character(dt1$Tag))==trimws("0")),NA,as.character(dt1$Tag)))
dt1$AbvBmss <- ifelse((trimws(as.character(dt1$AbvBmss))==trimws("-999.99")),NA,dt1$AbvBmss)
suppressWarnings(dt1$AbvBmss <- ifelse(!is.na(as.numeric("-999.99")) & (trimws(as.character(dt1$AbvBmss))==as.character(as.numeric("-999.99"))),NA,dt1$AbvBmss))
dt1$BlwBmss <- ifelse((trimws(as.character(dt1$BlwBmss))==trimws("-999.99")),NA,dt1$BlwBmss)
suppressWarnings(dt1$BlwBmss <- ifelse(!is.na(as.numeric("-999.99")) & (trimws(as.character(dt1$BlwBmss))==as.character(as.numeric("-999.99"))),NA,dt1$BlwBmss))


if(FALSE) {
      # Here is the structure of the input data frame:
      str(dt1)
      attach(dt1)
      # The analyses below are basic descriptions of the variables. After testing, they should be replaced.

      summary(Plot)
      summary(Zone)
      summary(Species)
      summary(SppNum)
      summary(Seq)
      summary(Tag)
      summary(Dbh)
      summary(Vigor)
      summary(AbvBmss)
      summary(BlwBmss)
      summary(Area)
      # Get more details on character variables

      summary(as.factor(dt1$Plot))
      summary(as.factor(dt1$Zone))
      summary(as.factor(dt1$Species))
      summary(as.factor(dt1$SppNum))
      summary(as.factor(dt1$Seq))
      summary(as.factor(dt1$Tag))
      summary(as.factor(dt1$Vigor))
      detach(dt1)
}











### 1999

# Package ID: knb-lter-hbr.39.7 Cataloging System:https://pasta.edirepository.org.
# Data set title: Forest Inventory of a Whole Tree Harvest: Hubbard Brook     Experimental Forest Watershed 5, 1999, 15 years     post-harvest.
# Data set creator:  John J. Battles - University of California, Berkeley
# Data set creator:  Tim Fahey - Department of Natural Resources, Cornell University
# Data set creator:  Natalie Cleavitt - Department of Natural Resources, Cornell University
# Metadata Provider:    - Hubbard Brook Experimental Forest LTER
# Contact:    - Information Manager, Hubbard Brook LTER   -     hbr-im@lternet.edu
# Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu

infile2 <- 'data/raw data/battles_2015/w5_1999veg.txt'
if(!dir.exists('data/raw data/battles_2015/') || !file.exists(infile2))   {
   dir.create('data/raw data/battles_2015/', showWarnings = FALSE)
   inurl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-hbr/39/7/fb73ff81296b01fdd1269cf1c689194d"
   download.file(inurl2,infile2,method="curl")
}






dt2 <-read.csv(infile2,header=F
               ,skip=1
               ,sep=","
               , col.names=c(
                  "Plot",
                  "Zone",
                  "Species",
                  "SppNum",
                  "Seq",
                  "Tag",
                  "Dbh",
                  "Vigor",
                  "AbvBmss",
                  "BlwBmss",
                  "Area"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt2$Plot)!="factor") dt2$Plot<- as.factor(dt2$Plot)
if (class(dt2$Zone)!="factor") dt2$Zone<- as.factor(dt2$Zone)
if (class(dt2$Species)!="factor") dt2$Species<- as.factor(dt2$Species)
if (class(dt2$SppNum)!="factor") dt2$SppNum<- as.factor(dt2$SppNum)
if (class(dt2$Seq)!="factor") dt2$Seq<- as.factor(dt2$Seq)
if (class(dt2$Tag)!="factor") dt2$Tag<- as.factor(dt2$Tag)
if (class(dt2$Dbh)=="factor") dt2$Dbh <-as.numeric(levels(dt2$Dbh))[as.integer(dt2$Dbh) ]
if (class(dt2$Dbh)=="character") dt2$Dbh <-as.numeric(dt2$Dbh)
if (class(dt2$Vigor)!="factor") dt2$Vigor<- as.factor(dt2$Vigor)
if (class(dt2$AbvBmss)=="factor") dt2$AbvBmss <-as.numeric(levels(dt2$AbvBmss))[as.integer(dt2$AbvBmss) ]
if (class(dt2$AbvBmss)=="character") dt2$AbvBmss <-as.numeric(dt2$AbvBmss)
if (class(dt2$BlwBmss)=="factor") dt2$BlwBmss <-as.numeric(levels(dt2$BlwBmss))[as.integer(dt2$BlwBmss) ]
if (class(dt2$BlwBmss)=="character") dt2$BlwBmss <-as.numeric(dt2$BlwBmss)
if (class(dt2$Area)=="factor") dt2$Area <-as.numeric(levels(dt2$Area))[as.integer(dt2$Area) ]
if (class(dt2$Area)=="character") dt2$Area <-as.numeric(dt2$Area)

# Convert Missing Values to NA for non-dates

dt2$Tag <- as.factor(ifelse((trimws(as.character(dt2$Tag))==trimws("0")),NA,as.character(dt2$Tag)))
dt2$AbvBmss <- ifelse((trimws(as.character(dt2$AbvBmss))==trimws("-999.99")),NA,dt2$AbvBmss)
suppressWarnings(dt2$AbvBmss <- ifelse(!is.na(as.numeric("-999.99")) & (trimws(as.character(dt2$AbvBmss))==as.character(as.numeric("-999.99"))),NA,dt2$AbvBmss))
dt2$BlwBmss <- ifelse((trimws(as.character(dt2$BlwBmss))==trimws("-999.99")),NA,dt2$BlwBmss)
suppressWarnings(dt2$BlwBmss <- ifelse(!is.na(as.numeric("-999.99")) & (trimws(as.character(dt2$BlwBmss))==as.character(as.numeric("-999.99"))),NA,dt2$BlwBmss))

 if(FALSE) {
      # Here is the structure of the input data frame:
      str(dt2)
      attach(dt2)
      # The analyses below are basic descriptions of the variables. After testing, they should be replaced.

      summary(Plot)
      summary(Zone)
      summary(Species)
      summary(SppNum)
      summary(Seq)
      summary(Tag)
      summary(Dbh)
      summary(Vigor)
      summary(AbvBmss)
      summary(BlwBmss)
      summary(Area)
      # Get more details on character variables

      summary(as.factor(dt2$Plot))
      summary(as.factor(dt2$Zone))
      summary(as.factor(dt2$Species))
      summary(as.factor(dt2$SppNum))
      summary(as.factor(dt2$Seq))
      summary(as.factor(dt2$Tag))
      summary(as.factor(dt2$Vigor))
      detach(dt2)
}



# merging both datasets
ddata <- data.frame(year = c(rep(1994, nrow(dt1)), rep(1999, nrow(dt2))),
                    rbind(dt1, dt2)
)
save(ddata, file = 'data/raw data/battles_2015/ddata')
