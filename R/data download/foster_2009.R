## foster_2009


# Package ID: knb-lter-hfr.40.17 Cataloging System:https://pasta.edirepository.org.
# Data set title: Hurricane Recovery Plots at Harvard Forest since 1937.
# Data set creator:  David Foster -
# Data set creator:  Steven Spurr -
# Contact:  David Foster -  Harvard Forest  - drfoster@fas.harvard.edu
# Stylesheet v2.10 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu



infile1 <- 'data/raw data/foster_2009/hf040-01-species.csv'
if(!dir.exists('data/raw data/foster_2009/') || !file.exists(infile1))   {
   dir.create('data/raw data/foster_2009/', showWarnings = FALSE)
   inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-hfr/40/17/018c396a6408115989585aa04e5f058e"
   download.file(inUrl1, infile1, method="curl")
}



dt1 <-read.csv(infile1,header=F
               ,skip=1
               ,sep=","
               , col.names=c(
                  "tree.herb",
                  "species",
                  "code"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt1$tree.herb)!="factor") dt1$tree.herb<- as.factor(dt1$tree.herb)
if (class(dt1$species)!="factor") dt1$species<- as.factor(dt1$species)
if (class(dt1$code)!="factor") dt1$code<- as.factor(dt1$code)

ddata_species <- dt1
save(ddata_species, file= 'data/raw data/foster_2009/ddata_species')

# Convert Missing Values to NA for non-dates


if(FALSE) {
      # Here is the structure of the input data frame:
      str(dt1)
      attach(dt1)
      # The analyses below are basic descriptions of the variables. After testing, they should be replaced.

      summary(tree.herb)
      summary(species)
      summary(code)
      detach(dt1)
}



infile2 <- 'data/raw data/foster_2009/hf040-01-hf040-02-tree.csv'
if(!dir.exists('data/raw data/foster_2009/') || !file.exists(infile2))   {
   dir.create('data/raw data/foster_2009/', showWarnings = FALSE)
   inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-hfr/40/17/0ffa8461a5bae68630f79e42610bee93"

   download.file(inUrl2, infile2, method="curl")
}



dt2 <-read.csv(infile2,header=F
               ,skip=1
               ,sep=","
               , col.names=c(
                  "year",
                  "plot",
                  "species",
                  "count"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt2$plot)!="factor") dt2$plot<- as.factor(dt2$plot)
if (class(dt2$species)!="factor") dt2$species<- as.factor(dt2$species)
if (class(dt2$count)=="factor") dt2$count <-as.numeric(levels(dt2$count))[as.integer(dt2$count) ]
if (class(dt2$count)=="character") dt2$count <-as.numeric(dt2$count)

# Convert Missing Values to NA for non-dates

dt2$count <- ifelse((trimws(as.character(dt2$count))==trimws("NA")),NA,dt2$count)

ddata <- dt2
save(ddata, file= 'data/raw data/foster_2009/ddata')



if(FALSE)  {
      # Here is the structure of the input data frame:
      str(dt2)
      attach(dt2)
      # The analyses below are basic descriptions of the variables. After testing, they should be replaced.

      summary(year)
      summary(plot)
      summary(species)
      summary(count)
      detach(dt2)
}



if(FALSE)  {   # herbs are only reported as presence / absence
         inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-hfr/40/17/285220eabcc3e0fa3d30b4c7fb51e2e5"
         infile3 <- tempfile()
         download.file(inUrl3,infile3,method="curl")


         dt3 <-read.csv(infile3,header=F
                        ,skip=1
                        ,sep=","
                        , col.names=c(
                           "case",
                           "year",
                           "plot",
                           "species",
                           "pres.abs"    ), check.names=TRUE)


         # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

         if (class(dt3$case)!="factor") dt3$case<- as.factor(dt3$case)
         if (class(dt3$plot)!="factor") dt3$plot<- as.factor(dt3$plot)
         if (class(dt3$species)!="factor") dt3$species<- as.factor(dt3$species)
         if (class(dt3$pres.abs)!="factor") dt3$pres.abs<- as.factor(dt3$pres.abs)

         # Convert Missing Values to NA for non-dates



         # Here is the structure of the input data frame:
         str(dt3)
         attach(dt3)
         # The analyses below are basic descriptions of the variables. After testing, they should be replaced.

         summary(case)
         summary(year)
         summary(plot)
         summary(species)
         summary(pres.abs)
         detach(dt3)

}



