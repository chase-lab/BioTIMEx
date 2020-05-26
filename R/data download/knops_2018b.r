## knops_2018b



# Package ID: knb-lter-cdr.317.8 Cataloging System:https://pasta.edirepository.org.
# Data set title: Small mammal abundance: Interactive Effects of Deer, Fire and Nitrogen.
# Data set creator:  Johannes Knops -
# Metadata Provider:    - Cedar Creek LTER
# Contact:  Dan Bahauddin - Information Manager Cedar Creek Ecosystem Science Reserve  - webmaster@cedarcreek.umn.edu
# Stylesheet v2.10 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu





infile1 <- 'data/raw data/knops_2018b/e153_Small mammal abundance.txt'
if(!dir.exists('data/raw data/knops_2018b/') || !file.exists(infile1))   {
   dir.create('data/raw data/knops_2018b/', showWarnings = FALSE)
   inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-cdr/317/8/854936b5b38258e6fd02f2639e9dfa43"
   download.file(inUrl1, infile1, method="curl")
}


dt1 <-read.csv(infile1,header=F
               ,skip=1
               ,sep="\t"
               , col.names=c(
                  "Year",
                  "Plot",
                  "Fencing",
                  "Fertilization",    # modified
                  "Burning",   # modified
                  "Trapnights",
                  "Microtus_pennsylvanicus",
                  "Peromyscus_maniculatus",
                  "Undet_Soricidae.Shrew.",   # modified
                  "Zapus_hudsonicus"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt1$Plot)!="factor") dt1$Plot<- as.factor(dt1$Plot)
if (class(dt1$Fencing)!="factor") dt1$Fencing<- as.factor(dt1$Fencing)
if (class(dt1$Fertilization)=="factor") dt1$Fertilization <-as.numeric(levels(dt1$Fertilization))[as.integer(dt1$Fertilization) ]
if (class(dt1$Fertilization)=="character") dt1$Fertilization <-as.numeric(dt1$Fertilization)
if (class(dt1$Burning)!="factor") dt1$Burning<- as.factor(dt1$Burning)
if (class(dt1$Trapnights)=="factor") dt1$Trapnights <-as.numeric(levels(dt1$Trapnights))[as.integer(dt1$Trapnights) ]
if (class(dt1$Trapnights)=="character") dt1$Trapnights <-as.numeric(dt1$Trapnights)
if (class(dt1$Microtus_pennsylvanicus)=="factor") dt1$Microtus_pennsylvanicus <-as.numeric(levels(dt1$Microtus_pennsylvanicus))[as.integer(dt1$Microtus_pennsylvanicus) ]
if (class(dt1$Microtus_pennsylvanicus)=="character") dt1$Microtus_pennsylvanicus <-as.numeric(dt1$Microtus_pennsylvanicus)
if (class(dt1$Peromyscus_maniculatus)=="factor") dt1$Peromyscus_maniculatus <-as.numeric(levels(dt1$Peromyscus_maniculatus))[as.integer(dt1$Peromyscus_maniculatus) ]
if (class(dt1$Peromyscus_maniculatus)=="character") dt1$Peromyscus_maniculatus <-as.numeric(dt1$Peromyscus_maniculatus)
if (class(dt1$Undet_Soricidae.Shrew.)=="factor") dt1$Undet_Soricidae.Shrew. <-as.numeric(levels(dt1$Undet_Soricidae.Shrew.))[as.integer(dt1$Undet_Soricidae.Shrew.) ]
if (class(dt1$Undet_Soricidae.Shrew.)=="character") dt1$Undet_Soricidae.Shrew. <-as.numeric(dt1$Undet_Soricidae.Shrew.)
if (class(dt1$Zapus_hudsonicus)=="factor") dt1$Zapus_hudsonicus <-as.numeric(levels(dt1$Zapus_hudsonicus))[as.integer(dt1$Zapus_hudsonicus) ]
if (class(dt1$Zapus_hudsonicus)=="character") dt1$Zapus_hudsonicus <-as.numeric(dt1$Zapus_hudsonicus)

# Convert Missing Values to NA for non-dates

ddata <- dt1
save(ddata, file = 'data/raw data/knops_2018b/ddata')

if(FALSE) {
      # Here is the structure of the input data frame:
      str(dt1)
      attach(dt1)
      # The analyses below are basic descriptions of the variables. After testing, they should be replaced.

      summary(Year)
      summary(Plot)
      summary(Fencing)
      summary(Fertilization)
      summary(Burning)
      summary(Trapnights)
      summary(Microtus_pennsylvanicus)
      summary(Peromyscus_maniculatus)
      summary(Undet_Soricidae.Shrew.)
      summary(Zapus_hudsonicus)
      detach(dt1)





}
