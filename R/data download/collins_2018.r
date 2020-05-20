### collins_2018 data wrangling

## Metadata from the authors

      # Package ID: edi.15.5 Cataloging System:https://pasta.edirepository.org.
      # Data set title: Compiled long-term community composition datasets of primary producers and consumers in       both freshwater and terrestrial communities.
      # Data set creator:  Scott Collins - University of New Mexico
      # Data set creator:  Meghan Avolio - National Socio-Environmental Synthesis Center
      # Data set creator:  Corinna Gries - University of Wisconsin-Madison
      # Data set creator:  Lauren Hallett - University of Oregon
      # Data set creator:  Sally Koerner - University of South Florida
      # Data set creator:  Kimberly La Pierre - Smithsonian Environmental Research Center
      # Data set creator:  Andrew Rypel - Wisconsin Department of Natural Resources
      # Data set creator:  Eric Sokol - University of Colorado Boulder
      # Data set creator:  Samuel Fey - Yale University
      # Data set creator:  Dan Flynn - Harvard Univsersity
      # Data set creator:  Sydney Jones - University of New Mexico
      # Data set creator:  Laura Ladwig - University of Wisconsin-Madison
      # Data set creator:  Julie Ripplinger - University of California-Riverside
      # Data set creator:  Matt  Jones - National Center for Ecological Analysis and Synthesis
      # Contact:  Scott Collins -  University of New Mexico  - scollins@sevilleta.unm.edu
      # Contact:  Corinna Gries -  University of Wisconsin-Madison  - cgries@wisc.edu
      # Contact:  Matt  Jones -  National Center for Ecological Analysis and Synthesis  - jones@nceas.ucsb.edu
      # Stylesheet v2.7 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu


   infile1 <- 'data/raw data/collins_2018/dt1.csv'
   if(!file.exists(infile1)) {  # if  directory does not exist or file is absent from directory
   inUrl1  <- "https://pasta.lternet.edu/package/data/eml/edi/15/5/f69c8fe563067164191d61b6e33eff03"
   download.file(inUrl1, infile1, method="auto")
}

   dt1 <-read.csv(infile1,header=F
                  ,skip=1
                  ,sep=","
                  ,quot='"'
                  , col.names=c(
                     "rowID",
                     "sitesubplot",
                     "experiment_year",
                     "site_code",
                     "project_name",
                     "community_type",
                     "site_project_comm",
                     "plot_id",
                     "species",
                     "relcover"    ), check.names=TRUE)


   # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

   if (class(dt1$rowID)!="factor") dt1$rowID<- as.factor(dt1$rowID)
   if (class(dt1$sitesubplot)!="factor") dt1$sitesubplot<- as.factor(dt1$sitesubplot)
   if (class(dt1$experiment_year)=="factor") dt1$experiment_year <-as.numeric(levels(dt1$experiment_year))[as.integer(dt1$experiment_year) ]
   if (class(dt1$site_code)!="factor") dt1$site_code<- as.factor(dt1$site_code)
   if (class(dt1$project_name)!="factor") dt1$project_name<- as.factor(dt1$project_name)
   if (class(dt1$community_type)!="factor") dt1$community_type<- as.factor(dt1$community_type)
   if (class(dt1$site_project_comm)!="factor") dt1$site_project_comm<- as.factor(dt1$site_project_comm)
   if (class(dt1$plot_id)!="factor") dt1$plot_id<- as.factor(dt1$plot_id)
   if (class(dt1$species)!="factor") dt1$species<- as.factor(dt1$species)
   if (class(dt1$relcover)=="factor") dt1$relcover <-as.numeric(levels(dt1$relcover))[as.integer(dt1$relcover) ]

   # Convert Missing Values to NA for non-dates


if(FALSE) {
   # Here is the structure of the input data frame:
   ##str(dt1)
   attach(dt1)
   # The analyses below are basic descriptions of the variables. After testing, they should be replaced.

   summary(rowID)
   summary(sitesubplot)
   summary(experiment_year)
   summary(site_code)
   summary(project_name)
   summary(community_type)
   summary(site_project_comm)
   summary(plot_id)
   summary(species)
   summary(relcover)
   detach(dt1)
}



   infile2 <- 'data/raw data/collins_2018/dt2.csv'
if(!file.exists(infile2))   {
   inUrl2  <- "https://pasta.lternet.edu/package/data/eml/edi/15/5/8284876afe3a1cb0a919d37e1164357f"
   download.file(inUrl2, infile2, method="auto")
}

   dt2 <-read.csv(infile2, header=F
                  ,skip=1
                  ,sep=","
                  ,quot='"'
                  , col.names=c(
                     "site_code",
                     "site_project_comm",
                     "project_name",
                     "community_type",
                     "location",
                     "Country",
                     "Continent",
                     "Lat",
                     "Long",
                     "MAP_mm",
                     "plot_size",
                     "spatial_extent",
                     "succession",
                     "lifespan",
                     "trophic_level",
                     "taxa",
                     "ANPP",
                     "broad_ecosystem_type",
                     "num_plots",
                     "temp_C",
                     "dataset_length",
                     "time_step"    ), check.names=TRUE)


   # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

   if (class(dt2$site_code)!="factor") dt2$site_code<- as.factor(dt2$site_code)
   if (class(dt2$site_project_comm)!="factor") dt2$site_project_comm<- as.factor(dt2$site_project_comm)
   if (class(dt2$project_name)!="factor") dt2$project_name<- as.factor(dt2$project_name)
   if (class(dt2$community_type)!="factor") dt2$community_type<- as.factor(dt2$community_type)
   if (class(dt2$location)!="factor") dt2$location<- as.factor(dt2$location)
   if (class(dt2$Country)!="factor") dt2$Country<- as.factor(dt2$Country)
   if (class(dt2$Continent)!="factor") dt2$Continent<- as.factor(dt2$Continent)
   if (class(dt2$Lat)=="factor") dt2$Lat <-as.numeric(levels(dt2$Lat))[as.integer(dt2$Lat) ]
   if (class(dt2$Long)=="factor") dt2$Long <-as.numeric(levels(dt2$Long))[as.integer(dt2$Long) ]
   if (class(dt2$MAP_mm)=="factor") dt2$MAP_mm <-as.numeric(levels(dt2$MAP_mm))[as.integer(dt2$MAP_mm) ]
   if (class(dt2$plot_size)=="factor") dt2$plot_size <-as.numeric(levels(dt2$plot_size))[as.integer(dt2$plot_size) ]
   if (class(dt2$spatial_extent)=="factor") dt2$spatial_extent <-as.numeric(levels(dt2$spatial_extent))[as.integer(dt2$spatial_extent) ]
   if (class(dt2$succession)!="factor") dt2$succession<- as.factor(dt2$succession)
   if (class(dt2$lifespan)!="factor") dt2$lifespan<- as.factor(dt2$lifespan)
   if (class(dt2$trophic_level)!="factor") dt2$trophic_level<- as.factor(dt2$trophic_level)
   if (class(dt2$taxa)!="factor") dt2$taxa<- as.factor(dt2$taxa)
   if (class(dt2$ANPP)=="factor") dt2$ANPP <-as.numeric(levels(dt2$ANPP))[as.integer(dt2$ANPP) ]
   if (class(dt2$broad_ecosystem_type)!="factor") dt2$broad_ecosystem_type<- as.factor(dt2$broad_ecosystem_type)
   if (class(dt2$num_plots)=="factor") dt2$num_plots <-as.numeric(levels(dt2$num_plots))[as.integer(dt2$num_plots) ]
   if (class(dt2$temp_C)=="factor") dt2$temp_C <-as.numeric(levels(dt2$temp_C))[as.integer(dt2$temp_C) ]
   if (class(dt2$dataset_length)=="factor") dt2$dataset_length <-as.numeric(levels(dt2$dataset_length))[as.integer(dt2$dataset_length) ]
   if (class(dt2$time_step)=="factor") dt2$time_step <-as.numeric(levels(dt2$time_step))[as.integer(dt2$time_step) ]

   # Convert Missing Values to NA for non-dates

   dt2$site_code <- as.factor(ifelse((trimws(as.character(dt2$site_code))==trimws("NA")),NA,as.character(dt2$site_code)))
   dt2$site_project_comm <- as.factor(ifelse((trimws(as.character(dt2$site_project_comm))==trimws("NA")),NA,as.character(dt2$site_project_comm)))
   dt2$project_name <- as.factor(ifelse((trimws(as.character(dt2$project_name))==trimws("NA")),NA,as.character(dt2$project_name)))
   dt2$community_type <- as.factor(ifelse((trimws(as.character(dt2$community_type))==trimws("NA")),NA,as.character(dt2$community_type)))
   dt2$location <- as.factor(ifelse((trimws(as.character(dt2$location))==trimws("NA")),NA,as.character(dt2$location)))
   dt2$Country <- as.factor(ifelse((trimws(as.character(dt2$Country))==trimws("NA")),NA,as.character(dt2$Country)))
   dt2$Continent <- as.factor(ifelse((trimws(as.character(dt2$Continent))==trimws("NA")),NA,as.character(dt2$Continent)))
   dt2$Lat <- ifelse((trimws(as.character(dt2$Lat))==trimws("NA")),NA,dt2$Lat)
   dt2$Long <- ifelse((trimws(as.character(dt2$Long))==trimws("NA")),NA,dt2$Long)
   dt2$MAP_mm <- ifelse((trimws(as.character(dt2$MAP_mm))==trimws("NA")),NA,dt2$MAP_mm)
   dt2$plot_size <- ifelse((trimws(as.character(dt2$plot_size))==trimws("NA")),NA,dt2$plot_size)
   dt2$spatial_extent <- ifelse((trimws(as.character(dt2$spatial_extent))==trimws("NA")),NA,dt2$spatial_extent)
   dt2$succession <- as.factor(ifelse((trimws(as.character(dt2$succession))==trimws("NA")),NA,as.character(dt2$succession)))
   dt2$lifespan <- as.factor(ifelse((trimws(as.character(dt2$lifespan))==trimws("NA")),NA,as.character(dt2$lifespan)))
   dt2$trophic_level <- as.factor(ifelse((trimws(as.character(dt2$trophic_level))==trimws("NA")),NA,as.character(dt2$trophic_level)))
   dt2$taxa <- as.factor(ifelse((trimws(as.character(dt2$taxa))==trimws("NA")),NA,as.character(dt2$taxa)))
   dt2$ANPP <- ifelse((trimws(as.character(dt2$ANPP))==trimws("NA")),NA,dt2$ANPP)
   dt2$broad_ecosystem_type <- as.factor(ifelse((trimws(as.character(dt2$broad_ecosystem_type))==trimws("NA")),NA,as.character(dt2$broad_ecosystem_type)))
   dt2$num_plots <- ifelse((trimws(as.character(dt2$num_plots))==trimws("NA")),NA,dt2$num_plots)
   dt2$temp_C <- ifelse((trimws(as.character(dt2$temp_C))==trimws("NA")),NA,dt2$temp_C)
   dt2$dataset_length <- ifelse((trimws(as.character(dt2$dataset_length))==trimws("NA")),NA,dt2$dataset_length)
   dt2$time_step <- ifelse((trimws(as.character(dt2$time_step))==trimws("NA")),NA,dt2$time_step)

if(FALSE){
   # Here is the structure of the input data frame:
   ##str(dt2)
   attach(dt2)
   # The analyses below are basic descriptions of the variables. After testing, they should be replaced.

   summary(site_code)
   summary(site_project_comm)
   summary(project_name)
   summary(community_type)
   summary(location)
   summary(Country)
   summary(Continent)
   summary(Lat)
   summary(Long)
   summary(MAP_mm)
   summary(plot_size)
   summary(spatial_extent)
   summary(succession)
   summary(lifespan)
   summary(trophic_level)
   summary(taxa)
   summary(ANPP)
   summary(broad_ecosystem_type)
   summary(num_plots)
   summary(temp_C)
   summary(dataset_length)
   summary(time_step)
   detach(dt2)
}


