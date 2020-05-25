## johnson_2019

# Package ID: knb-lter-pie.191.4 Cataloging System:https://pasta.edirepository.org.
# Data set title: Macroinfaunal counts, 2003-2017, from marsh cores along Rowley River tidal creeks associated with long term fertilization experiments, Rowley, MA..
# Data set creator:  David Johnson -
# Data set creator:  Linda Deegan -
# Data set creator:    - Plum Island Ecosystems LTER
# Metadata Provider:    - Plum Island Ecosystems LTER
# Contact:    -  Plum Island Ecosystems LTER  -
# Stylesheet v2.10 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu



infile1 <- 'data/raw data/johnson_2019/LTE-TIDE-Macroinfauna.csv'
if(!dir.exists('data/raw data/johnson_2019/') || !file.exists(infile1))   {
   dir.create('data/raw data/johnson_2019/', showWarnings = FALSE)
   inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-pie/191/4/f1b40cadfded5328437b439f4752d05b"
   download.file(inUrl1, infile1, method="curl")
}


dt1 <-read.csv(infile1,header=F
               ,skip=1
               ,sep=","
               , col.names=c(
                  "Period",
                  "Year",
                  "Month",
                  "Creek",
                  "Nutrient",
                  "Branch",
                  "Fish",
                  "Transect",
                  "Habitat",
                  "Rep",
                  "num.Fabricia.sabella",
                  "num.Manayunkia.aestuarina",
                  "num.Nereis.diversicolor",
                  "num.Eteone.heteropoda",
                  "num.Captiella.capitata",
                  "num.Streblospio.benedicti",
                  "num.Polydora.cornuta",
                  "num.Pygospio.elegans",
                  "num.Marenzelleria.viridis",
                  "num.Hobsonia.florida",
                  "num.Orbiniidae",
                  "num.Total.polychaetes",
                  "num.Paranais.litoralis",
                  "num.Tubificoides.benedeni",
                  "num.Tubificoides.wasselli",
                  "num.Tubificoides.brownae",
                  "num.Monopylephorus.sp.",
                  "num.Psammoryctides.sp.",
                  "num.Cernosvitoviella.immota",
                  "num.other_enchytraeids",
                  "num.Unidentified.oligochaetes",
                  "Total.Oligochaetes",
                  "num.amphipods",
                  "num.talitrid.amphipods",
                  "num.Orchestia.grillus",
                  "num.gamarid.amphipods",
                  "Total.amphipods",
                  "num.Littorophiloscia.vittata",
                  "num.Erichsonella.attenuata",
                  "num.Edotea.triloba",
                  "num.Hargeria.rapax",
                  "num.Ceratopogonidae",
                  "num.Tabanidae",
                  "num.Dolichopodidae",
                  "num.Insect",
                  "Total.Insect",
                  "num.Isopoda",
                  "num.Cyathura.polita",
                  "Total.Isopoda",
                  "num.mussels",
                  "num.Geukensia.demissa",
                  "num.Bivalve",
                  "Total.Bivalve",
                  "num.Melampus.b.",
                  "num.Gastropoda",
                  "num.Mites",
                  "num.Ostracod",
                  "num.Springtail",
                  "num.Psuedoscorpion",
                  "num.Spider",
                  "num.Turbellaria",
                  "num.flatworm",
                  "total.flatworm",
                  "num.Nematostella.vectensis",
                  "num..Actiniaria",
                  "total..Actiniaria",
                  "num.Nemertea",
                  "num.Oxyurostylis.smithi",
                  "num.unknown",
                  "num.Limulus"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt1$Period)!="factor") dt1$Period<- as.factor(dt1$Period)
if (class(dt1$Month)!="factor") dt1$Month<- as.factor(dt1$Month)
if (class(dt1$Creek)!="factor") dt1$Creek<- as.factor(dt1$Creek)
if (class(dt1$Nutrient)!="factor") dt1$Nutrient<- as.factor(dt1$Nutrient)
if (class(dt1$Branch)!="factor") dt1$Branch<- as.factor(dt1$Branch)
if (class(dt1$Fish)!="factor") dt1$Fish<- as.factor(dt1$Fish)
if (class(dt1$Transect)!="factor") dt1$Transect<- as.factor(dt1$Transect)
if (class(dt1$Habitat)!="factor") dt1$Habitat<- as.factor(dt1$Habitat)
if (class(dt1$Rep)!="factor") dt1$Rep<- as.factor(dt1$Rep)
if (class(dt1$num.Fabricia.sabella)=="factor") dt1$num.Fabricia.sabella <-as.numeric(levels(dt1$num.Fabricia.sabella))[as.integer(dt1$num.Fabricia.sabella) ]
if (class(dt1$num.Fabricia.sabella)=="character") dt1$num.Fabricia.sabella <-as.numeric(dt1$num.Fabricia.sabella)
if (class(dt1$num.Manayunkia.aestuarina)=="factor") dt1$num.Manayunkia.aestuarina <-as.numeric(levels(dt1$num.Manayunkia.aestuarina))[as.integer(dt1$num.Manayunkia.aestuarina) ]
if (class(dt1$num.Manayunkia.aestuarina)=="character") dt1$num.Manayunkia.aestuarina <-as.numeric(dt1$num.Manayunkia.aestuarina)
if (class(dt1$num.Nereis.diversicolor)=="factor") dt1$num.Nereis.diversicolor <-as.numeric(levels(dt1$num.Nereis.diversicolor))[as.integer(dt1$num.Nereis.diversicolor) ]
if (class(dt1$num.Nereis.diversicolor)=="character") dt1$num.Nereis.diversicolor <-as.numeric(dt1$num.Nereis.diversicolor)
if (class(dt1$num.Eteone.heteropoda)=="factor") dt1$num.Eteone.heteropoda <-as.numeric(levels(dt1$num.Eteone.heteropoda))[as.integer(dt1$num.Eteone.heteropoda) ]
if (class(dt1$num.Eteone.heteropoda)=="character") dt1$num.Eteone.heteropoda <-as.numeric(dt1$num.Eteone.heteropoda)
if (class(dt1$num.Captiella.capitata)=="factor") dt1$num.Captiella.capitata <-as.numeric(levels(dt1$num.Captiella.capitata))[as.integer(dt1$num.Captiella.capitata) ]
if (class(dt1$num.Captiella.capitata)=="character") dt1$num.Captiella.capitata <-as.numeric(dt1$num.Captiella.capitata)
if (class(dt1$num.Streblospio.benedicti)=="factor") dt1$num.Streblospio.benedicti <-as.numeric(levels(dt1$num.Streblospio.benedicti))[as.integer(dt1$num.Streblospio.benedicti) ]
if (class(dt1$num.Streblospio.benedicti)=="character") dt1$num.Streblospio.benedicti <-as.numeric(dt1$num.Streblospio.benedicti)
if (class(dt1$num.Polydora.cornuta)=="factor") dt1$num.Polydora.cornuta <-as.numeric(levels(dt1$num.Polydora.cornuta))[as.integer(dt1$num.Polydora.cornuta) ]
if (class(dt1$num.Polydora.cornuta)=="character") dt1$num.Polydora.cornuta <-as.numeric(dt1$num.Polydora.cornuta)
if (class(dt1$num.Pygospio.elegans)=="factor") dt1$num.Pygospio.elegans <-as.numeric(levels(dt1$num.Pygospio.elegans))[as.integer(dt1$num.Pygospio.elegans) ]
if (class(dt1$num.Pygospio.elegans)=="character") dt1$num.Pygospio.elegans <-as.numeric(dt1$num.Pygospio.elegans)
if (class(dt1$num.Marenzelleria.viridis)=="factor") dt1$num.Marenzelleria.viridis <-as.numeric(levels(dt1$num.Marenzelleria.viridis))[as.integer(dt1$num.Marenzelleria.viridis) ]
if (class(dt1$num.Marenzelleria.viridis)=="character") dt1$num.Marenzelleria.viridis <-as.numeric(dt1$num.Marenzelleria.viridis)
if (class(dt1$num.Hobsonia.florida)=="factor") dt1$num.Hobsonia.florida <-as.numeric(levels(dt1$num.Hobsonia.florida))[as.integer(dt1$num.Hobsonia.florida) ]
if (class(dt1$num.Hobsonia.florida)=="character") dt1$num.Hobsonia.florida <-as.numeric(dt1$num.Hobsonia.florida)
if (class(dt1$num.Orbiniidae)=="factor") dt1$num.Orbiniidae <-as.numeric(levels(dt1$num.Orbiniidae))[as.integer(dt1$num.Orbiniidae) ]
if (class(dt1$num.Orbiniidae)=="character") dt1$num.Orbiniidae <-as.numeric(dt1$num.Orbiniidae)
if (class(dt1$num.Total.polychaetes)=="factor") dt1$num.Total.polychaetes <-as.numeric(levels(dt1$num.Total.polychaetes))[as.integer(dt1$num.Total.polychaetes) ]
if (class(dt1$num.Total.polychaetes)=="character") dt1$num.Total.polychaetes <-as.numeric(dt1$num.Total.polychaetes)
if (class(dt1$num.Paranais.litoralis)=="factor") dt1$num.Paranais.litoralis <-as.numeric(levels(dt1$num.Paranais.litoralis))[as.integer(dt1$num.Paranais.litoralis) ]
if (class(dt1$num.Paranais.litoralis)=="character") dt1$num.Paranais.litoralis <-as.numeric(dt1$num.Paranais.litoralis)
if (class(dt1$num.Tubificoides.benedeni)=="factor") dt1$num.Tubificoides.benedeni <-as.numeric(levels(dt1$num.Tubificoides.benedeni))[as.integer(dt1$num.Tubificoides.benedeni) ]
if (class(dt1$num.Tubificoides.benedeni)=="character") dt1$num.Tubificoides.benedeni <-as.numeric(dt1$num.Tubificoides.benedeni)
if (class(dt1$num.Tubificoides.wasselli)=="factor") dt1$num.Tubificoides.wasselli <-as.numeric(levels(dt1$num.Tubificoides.wasselli))[as.integer(dt1$num.Tubificoides.wasselli) ]
if (class(dt1$num.Tubificoides.wasselli)=="character") dt1$num.Tubificoides.wasselli <-as.numeric(dt1$num.Tubificoides.wasselli)
if (class(dt1$num.Tubificoides.brownae)=="factor") dt1$num.Tubificoides.brownae <-as.numeric(levels(dt1$num.Tubificoides.brownae))[as.integer(dt1$num.Tubificoides.brownae) ]
if (class(dt1$num.Tubificoides.brownae)=="character") dt1$num.Tubificoides.brownae <-as.numeric(dt1$num.Tubificoides.brownae)
if (class(dt1$num.Monopylephorus.sp.)=="factor") dt1$num.Monopylephorus.sp. <-as.numeric(levels(dt1$num.Monopylephorus.sp.))[as.integer(dt1$num.Monopylephorus.sp.) ]
if (class(dt1$num.Monopylephorus.sp.)=="character") dt1$num.Monopylephorus.sp. <-as.numeric(dt1$num.Monopylephorus.sp.)
if (class(dt1$num.Psammoryctides.sp.)=="factor") dt1$num.Psammoryctides.sp. <-as.numeric(levels(dt1$num.Psammoryctides.sp.))[as.integer(dt1$num.Psammoryctides.sp.) ]
if (class(dt1$num.Psammoryctides.sp.)=="character") dt1$num.Psammoryctides.sp. <-as.numeric(dt1$num.Psammoryctides.sp.)
if (class(dt1$num.Cernosvitoviella.immota)=="factor") dt1$num.Cernosvitoviella.immota <-as.numeric(levels(dt1$num.Cernosvitoviella.immota))[as.integer(dt1$num.Cernosvitoviella.immota) ]
if (class(dt1$num.Cernosvitoviella.immota)=="character") dt1$num.Cernosvitoviella.immota <-as.numeric(dt1$num.Cernosvitoviella.immota)
if (class(dt1$num.other_enchytraeids)=="factor") dt1$num.other_enchytraeids <-as.numeric(levels(dt1$num.other_enchytraeids))[as.integer(dt1$num.other_enchytraeids) ]
if (class(dt1$num.other_enchytraeids)=="character") dt1$num.other_enchytraeids <-as.numeric(dt1$num.other_enchytraeids)
if (class(dt1$num.Unidentified.oligochaetes)=="factor") dt1$num.Unidentified.oligochaetes <-as.numeric(levels(dt1$num.Unidentified.oligochaetes))[as.integer(dt1$num.Unidentified.oligochaetes) ]
if (class(dt1$num.Unidentified.oligochaetes)=="character") dt1$num.Unidentified.oligochaetes <-as.numeric(dt1$num.Unidentified.oligochaetes)
if (class(dt1$Total.Oligochaetes)=="factor") dt1$Total.Oligochaetes <-as.numeric(levels(dt1$Total.Oligochaetes))[as.integer(dt1$Total.Oligochaetes) ]
if (class(dt1$Total.Oligochaetes)=="character") dt1$Total.Oligochaetes <-as.numeric(dt1$Total.Oligochaetes)
if (class(dt1$num.amphipods)=="factor") dt1$num.amphipods <-as.numeric(levels(dt1$num.amphipods))[as.integer(dt1$num.amphipods) ]
if (class(dt1$num.amphipods)=="character") dt1$num.amphipods <-as.numeric(dt1$num.amphipods)
if (class(dt1$num.talitrid.amphipods)=="factor") dt1$num.talitrid.amphipods <-as.numeric(levels(dt1$num.talitrid.amphipods))[as.integer(dt1$num.talitrid.amphipods) ]
if (class(dt1$num.talitrid.amphipods)=="character") dt1$num.talitrid.amphipods <-as.numeric(dt1$num.talitrid.amphipods)
if (class(dt1$num.Orchestia.grillus)=="factor") dt1$num.Orchestia.grillus <-as.numeric(levels(dt1$num.Orchestia.grillus))[as.integer(dt1$num.Orchestia.grillus) ]
if (class(dt1$num.Orchestia.grillus)=="character") dt1$num.Orchestia.grillus <-as.numeric(dt1$num.Orchestia.grillus)
if (class(dt1$num.gamarid.amphipods)=="factor") dt1$num.gamarid.amphipods <-as.numeric(levels(dt1$num.gamarid.amphipods))[as.integer(dt1$num.gamarid.amphipods) ]
if (class(dt1$num.gamarid.amphipods)=="character") dt1$num.gamarid.amphipods <-as.numeric(dt1$num.gamarid.amphipods)
if (class(dt1$Total.amphipods)=="factor") dt1$Total.amphipods <-as.numeric(levels(dt1$Total.amphipods))[as.integer(dt1$Total.amphipods) ]
if (class(dt1$Total.amphipods)=="character") dt1$Total.amphipods <-as.numeric(dt1$Total.amphipods)
if (class(dt1$num.Littorophiloscia.vittata)=="factor") dt1$num.Littorophiloscia.vittata <-as.numeric(levels(dt1$num.Littorophiloscia.vittata))[as.integer(dt1$num.Littorophiloscia.vittata) ]
if (class(dt1$num.Littorophiloscia.vittata)=="character") dt1$num.Littorophiloscia.vittata <-as.numeric(dt1$num.Littorophiloscia.vittata)
if (class(dt1$num.Erichsonella.attenuata)=="factor") dt1$num.Erichsonella.attenuata <-as.numeric(levels(dt1$num.Erichsonella.attenuata))[as.integer(dt1$num.Erichsonella.attenuata) ]
if (class(dt1$num.Erichsonella.attenuata)=="character") dt1$num.Erichsonella.attenuata <-as.numeric(dt1$num.Erichsonella.attenuata)
if (class(dt1$num.Edotea.triloba)=="factor") dt1$num.Edotea.triloba <-as.numeric(levels(dt1$num.Edotea.triloba))[as.integer(dt1$num.Edotea.triloba) ]
if (class(dt1$num.Edotea.triloba)=="character") dt1$num.Edotea.triloba <-as.numeric(dt1$num.Edotea.triloba)
if (class(dt1$num.Hargeria.rapax)=="factor") dt1$num.Hargeria.rapax <-as.numeric(levels(dt1$num.Hargeria.rapax))[as.integer(dt1$num.Hargeria.rapax) ]
if (class(dt1$num.Hargeria.rapax)=="character") dt1$num.Hargeria.rapax <-as.numeric(dt1$num.Hargeria.rapax)
if (class(dt1$num.Ceratopogonidae)=="factor") dt1$num.Ceratopogonidae <-as.numeric(levels(dt1$num.Ceratopogonidae))[as.integer(dt1$num.Ceratopogonidae) ]
if (class(dt1$num.Ceratopogonidae)=="character") dt1$num.Ceratopogonidae <-as.numeric(dt1$num.Ceratopogonidae)
if (class(dt1$num.Tabanidae)=="factor") dt1$num.Tabanidae <-as.numeric(levels(dt1$num.Tabanidae))[as.integer(dt1$num.Tabanidae) ]
if (class(dt1$num.Tabanidae)=="character") dt1$num.Tabanidae <-as.numeric(dt1$num.Tabanidae)
if (class(dt1$num.Dolichopodidae)=="factor") dt1$num.Dolichopodidae <-as.numeric(levels(dt1$num.Dolichopodidae))[as.integer(dt1$num.Dolichopodidae) ]
if (class(dt1$num.Dolichopodidae)=="character") dt1$num.Dolichopodidae <-as.numeric(dt1$num.Dolichopodidae)
if (class(dt1$num.Insect)=="factor") dt1$num.Insect <-as.numeric(levels(dt1$num.Insect))[as.integer(dt1$num.Insect) ]
if (class(dt1$num.Insect)=="character") dt1$num.Insect <-as.numeric(dt1$num.Insect)
if (class(dt1$Total.Insect)=="factor") dt1$Total.Insect <-as.numeric(levels(dt1$Total.Insect))[as.integer(dt1$Total.Insect) ]
if (class(dt1$Total.Insect)=="character") dt1$Total.Insect <-as.numeric(dt1$Total.Insect)
if (class(dt1$num.Isopoda)=="factor") dt1$num.Isopoda <-as.numeric(levels(dt1$num.Isopoda))[as.integer(dt1$num.Isopoda) ]
if (class(dt1$num.Isopoda)=="character") dt1$num.Isopoda <-as.numeric(dt1$num.Isopoda)
if (class(dt1$num.Cyathura.polita)=="factor") dt1$num.Cyathura.polita <-as.numeric(levels(dt1$num.Cyathura.polita))[as.integer(dt1$num.Cyathura.polita) ]
if (class(dt1$num.Cyathura.polita)=="character") dt1$num.Cyathura.polita <-as.numeric(dt1$num.Cyathura.polita)
if (class(dt1$Total.Isopoda)=="factor") dt1$Total.Isopoda <-as.numeric(levels(dt1$Total.Isopoda))[as.integer(dt1$Total.Isopoda) ]
if (class(dt1$Total.Isopoda)=="character") dt1$Total.Isopoda <-as.numeric(dt1$Total.Isopoda)
if (class(dt1$num.mussels)=="factor") dt1$num.mussels <-as.numeric(levels(dt1$num.mussels))[as.integer(dt1$num.mussels) ]
if (class(dt1$num.mussels)=="character") dt1$num.mussels <-as.numeric(dt1$num.mussels)
if (class(dt1$num.Geukensia.demissa)=="factor") dt1$num.Geukensia.demissa <-as.numeric(levels(dt1$num.Geukensia.demissa))[as.integer(dt1$num.Geukensia.demissa) ]
if (class(dt1$num.Geukensia.demissa)=="character") dt1$num.Geukensia.demissa <-as.numeric(dt1$num.Geukensia.demissa)
if (class(dt1$num.Bivalve)=="factor") dt1$num.Bivalve <-as.numeric(levels(dt1$num.Bivalve))[as.integer(dt1$num.Bivalve) ]
if (class(dt1$num.Bivalve)=="character") dt1$num.Bivalve <-as.numeric(dt1$num.Bivalve)
if (class(dt1$Total.Bivalve)=="factor") dt1$Total.Bivalve <-as.numeric(levels(dt1$Total.Bivalve))[as.integer(dt1$Total.Bivalve) ]
if (class(dt1$Total.Bivalve)=="character") dt1$Total.Bivalve <-as.numeric(dt1$Total.Bivalve)
if (class(dt1$num.Melampus.b.)=="factor") dt1$num.Melampus.b. <-as.numeric(levels(dt1$num.Melampus.b.))[as.integer(dt1$num.Melampus.b.) ]
if (class(dt1$num.Melampus.b.)=="character") dt1$num.Melampus.b. <-as.numeric(dt1$num.Melampus.b.)
if (class(dt1$num.Gastropoda)=="factor") dt1$num.Gastropoda <-as.numeric(levels(dt1$num.Gastropoda))[as.integer(dt1$num.Gastropoda) ]
if (class(dt1$num.Gastropoda)=="character") dt1$num.Gastropoda <-as.numeric(dt1$num.Gastropoda)
if (class(dt1$num.Mites)=="factor") dt1$num.Mites <-as.numeric(levels(dt1$num.Mites))[as.integer(dt1$num.Mites) ]
if (class(dt1$num.Mites)=="character") dt1$num.Mites <-as.numeric(dt1$num.Mites)
if (class(dt1$num.Ostracod)=="factor") dt1$num.Ostracod <-as.numeric(levels(dt1$num.Ostracod))[as.integer(dt1$num.Ostracod) ]
if (class(dt1$num.Ostracod)=="character") dt1$num.Ostracod <-as.numeric(dt1$num.Ostracod)
if (class(dt1$num.Springtail)=="factor") dt1$num.Springtail <-as.numeric(levels(dt1$num.Springtail))[as.integer(dt1$num.Springtail) ]
if (class(dt1$num.Springtail)=="character") dt1$num.Springtail <-as.numeric(dt1$num.Springtail)
if (class(dt1$num.Psuedoscorpion)=="factor") dt1$num.Psuedoscorpion <-as.numeric(levels(dt1$num.Psuedoscorpion))[as.integer(dt1$num.Psuedoscorpion) ]
if (class(dt1$num.Psuedoscorpion)=="character") dt1$num.Psuedoscorpion <-as.numeric(dt1$num.Psuedoscorpion)
if (class(dt1$num.Spider)=="factor") dt1$num.Spider <-as.numeric(levels(dt1$num.Spider))[as.integer(dt1$num.Spider) ]
if (class(dt1$num.Spider)=="character") dt1$num.Spider <-as.numeric(dt1$num.Spider)
if (class(dt1$num.Turbellaria)=="factor") dt1$num.Turbellaria <-as.numeric(levels(dt1$num.Turbellaria))[as.integer(dt1$num.Turbellaria) ]
if (class(dt1$num.Turbellaria)=="character") dt1$num.Turbellaria <-as.numeric(dt1$num.Turbellaria)
if (class(dt1$num.flatworm)=="factor") dt1$num.flatworm <-as.numeric(levels(dt1$num.flatworm))[as.integer(dt1$num.flatworm) ]
if (class(dt1$num.flatworm)=="character") dt1$num.flatworm <-as.numeric(dt1$num.flatworm)
if (class(dt1$total.flatworm)=="factor") dt1$total.flatworm <-as.numeric(levels(dt1$total.flatworm))[as.integer(dt1$total.flatworm) ]
if (class(dt1$total.flatworm)=="character") dt1$total.flatworm <-as.numeric(dt1$total.flatworm)
if (class(dt1$num.Nematostella.vectensis)=="factor") dt1$num.Nematostella.vectensis <-as.numeric(levels(dt1$num.Nematostella.vectensis))[as.integer(dt1$num.Nematostella.vectensis) ]
if (class(dt1$num.Nematostella.vectensis)=="character") dt1$num.Nematostella.vectensis <-as.numeric(dt1$num.Nematostella.vectensis)
if (class(dt1$num..Actiniaria)=="factor") dt1$num..Actiniaria <-as.numeric(levels(dt1$num..Actiniaria))[as.integer(dt1$num..Actiniaria) ]
if (class(dt1$num..Actiniaria)=="character") dt1$num..Actiniaria <-as.numeric(dt1$num..Actiniaria)
if (class(dt1$total..Actiniaria)=="factor") dt1$total..Actiniaria <-as.numeric(levels(dt1$total..Actiniaria))[as.integer(dt1$total..Actiniaria) ]
if (class(dt1$total..Actiniaria)=="character") dt1$total..Actiniaria <-as.numeric(dt1$total..Actiniaria)
if (class(dt1$num.Nemertea)=="factor") dt1$num.Nemertea <-as.numeric(levels(dt1$num.Nemertea))[as.integer(dt1$num.Nemertea) ]
if (class(dt1$num.Nemertea)=="character") dt1$num.Nemertea <-as.numeric(dt1$num.Nemertea)
if (class(dt1$num.Oxyurostylis.smithi)=="factor") dt1$num.Oxyurostylis.smithi <-as.numeric(levels(dt1$num.Oxyurostylis.smithi))[as.integer(dt1$num.Oxyurostylis.smithi) ]
if (class(dt1$num.Oxyurostylis.smithi)=="character") dt1$num.Oxyurostylis.smithi <-as.numeric(dt1$num.Oxyurostylis.smithi)
if (class(dt1$num.unknown)=="factor") dt1$num.unknown <-as.numeric(levels(dt1$num.unknown))[as.integer(dt1$num.unknown) ]
if (class(dt1$num.unknown)=="character") dt1$num.unknown <-as.numeric(dt1$num.unknown)
if (class(dt1$num.Limulus)=="factor") dt1$num.Limulus <-as.numeric(levels(dt1$num.Limulus))[as.integer(dt1$num.Limulus) ]
if (class(dt1$num.Limulus)=="character") dt1$num.Limulus <-as.numeric(dt1$num.Limulus)

# Convert Missing Values to NA for non-dates

dt1$Period <- as.factor(ifelse((trimws(as.character(dt1$Period))==trimws("NA")),NA,as.character(dt1$Period)))
dt1$Creek <- as.factor(ifelse((trimws(as.character(dt1$Creek))==trimws("NA")),NA,as.character(dt1$Creek)))
dt1$Nutrient <- as.factor(ifelse((trimws(as.character(dt1$Nutrient))==trimws("NA")),NA,as.character(dt1$Nutrient)))
dt1$Branch <- as.factor(ifelse((trimws(as.character(dt1$Branch))==trimws("NA")),NA,as.character(dt1$Branch)))
dt1$Fish <- as.factor(ifelse((trimws(as.character(dt1$Fish))==trimws("NA")),NA,as.character(dt1$Fish)))
dt1$Habitat <- as.factor(ifelse((trimws(as.character(dt1$Habitat))==trimws("NA")),NA,as.character(dt1$Habitat)))
dt1$num.Fabricia.sabella <- ifelse((trimws(as.character(dt1$num.Fabricia.sabella))==trimws("NA")),NA,dt1$num.Fabricia.sabella)
dt1$num.Manayunkia.aestuarina <- ifelse((trimws(as.character(dt1$num.Manayunkia.aestuarina))==trimws("NA")),NA,dt1$num.Manayunkia.aestuarina)
dt1$num.Nereis.diversicolor <- ifelse((trimws(as.character(dt1$num.Nereis.diversicolor))==trimws("NA")),NA,dt1$num.Nereis.diversicolor)
dt1$num.Eteone.heteropoda <- ifelse((trimws(as.character(dt1$num.Eteone.heteropoda))==trimws("NA")),NA,dt1$num.Eteone.heteropoda)
dt1$num.Captiella.capitata <- ifelse((trimws(as.character(dt1$num.Captiella.capitata))==trimws("NA")),NA,dt1$num.Captiella.capitata)
dt1$num.Streblospio.benedicti <- ifelse((trimws(as.character(dt1$num.Streblospio.benedicti))==trimws("NA")),NA,dt1$num.Streblospio.benedicti)
dt1$num.Polydora.cornuta <- ifelse((trimws(as.character(dt1$num.Polydora.cornuta))==trimws("NA")),NA,dt1$num.Polydora.cornuta)
dt1$num.Pygospio.elegans <- ifelse((trimws(as.character(dt1$num.Pygospio.elegans))==trimws("NA")),NA,dt1$num.Pygospio.elegans)
dt1$num.Marenzelleria.viridis <- ifelse((trimws(as.character(dt1$num.Marenzelleria.viridis))==trimws("NA")),NA,dt1$num.Marenzelleria.viridis)
dt1$num.Hobsonia.florida <- ifelse((trimws(as.character(dt1$num.Hobsonia.florida))==trimws("NA")),NA,dt1$num.Hobsonia.florida)
dt1$num.Orbiniidae <- ifelse((trimws(as.character(dt1$num.Orbiniidae))==trimws("NA")),NA,dt1$num.Orbiniidae)
dt1$num.Total.polychaetes <- ifelse((trimws(as.character(dt1$num.Total.polychaetes))==trimws("NA")),NA,dt1$num.Total.polychaetes)
dt1$num.Paranais.litoralis <- ifelse((trimws(as.character(dt1$num.Paranais.litoralis))==trimws("NA")),NA,dt1$num.Paranais.litoralis)
dt1$num.Tubificoides.benedeni <- ifelse((trimws(as.character(dt1$num.Tubificoides.benedeni))==trimws("NA")),NA,dt1$num.Tubificoides.benedeni)
dt1$num.Tubificoides.wasselli <- ifelse((trimws(as.character(dt1$num.Tubificoides.wasselli))==trimws("NA")),NA,dt1$num.Tubificoides.wasselli)
dt1$num.Tubificoides.brownae <- ifelse((trimws(as.character(dt1$num.Tubificoides.brownae))==trimws("NA")),NA,dt1$num.Tubificoides.brownae)
dt1$num.Monopylephorus.sp. <- ifelse((trimws(as.character(dt1$num.Monopylephorus.sp.))==trimws("NA")),NA,dt1$num.Monopylephorus.sp.)
dt1$num.Psammoryctides.sp. <- ifelse((trimws(as.character(dt1$num.Psammoryctides.sp.))==trimws("NA")),NA,dt1$num.Psammoryctides.sp.)
dt1$num.Cernosvitoviella.immota <- ifelse((trimws(as.character(dt1$num.Cernosvitoviella.immota))==trimws("NA")),NA,dt1$num.Cernosvitoviella.immota)
dt1$num.other_enchytraeids <- ifelse((trimws(as.character(dt1$num.other_enchytraeids))==trimws("NA")),NA,dt1$num.other_enchytraeids)
dt1$num.Unidentified.oligochaetes <- ifelse((trimws(as.character(dt1$num.Unidentified.oligochaetes))==trimws("NA")),NA,dt1$num.Unidentified.oligochaetes)
dt1$Total.Oligochaetes <- ifelse((trimws(as.character(dt1$Total.Oligochaetes))==trimws("NA")),NA,dt1$Total.Oligochaetes)
dt1$num.amphipods <- ifelse((trimws(as.character(dt1$num.amphipods))==trimws("NA")),NA,dt1$num.amphipods)
dt1$num.talitrid.amphipods <- ifelse((trimws(as.character(dt1$num.talitrid.amphipods))==trimws("NA")),NA,dt1$num.talitrid.amphipods)
dt1$num.Orchestia.grillus <- ifelse((trimws(as.character(dt1$num.Orchestia.grillus))==trimws("NA")),NA,dt1$num.Orchestia.grillus)
dt1$num.gamarid.amphipods <- ifelse((trimws(as.character(dt1$num.gamarid.amphipods))==trimws("NA")),NA,dt1$num.gamarid.amphipods)
dt1$Total.amphipods <- ifelse((trimws(as.character(dt1$Total.amphipods))==trimws("NA")),NA,dt1$Total.amphipods)
dt1$num.Littorophiloscia.vittata <- ifelse((trimws(as.character(dt1$num.Littorophiloscia.vittata))==trimws("NA")),NA,dt1$num.Littorophiloscia.vittata)
dt1$num.Erichsonella.attenuata <- ifelse((trimws(as.character(dt1$num.Erichsonella.attenuata))==trimws("NA")),NA,dt1$num.Erichsonella.attenuata)
dt1$num.Edotea.triloba <- ifelse((trimws(as.character(dt1$num.Edotea.triloba))==trimws("NA")),NA,dt1$num.Edotea.triloba)
dt1$num.Hargeria.rapax <- ifelse((trimws(as.character(dt1$num.Hargeria.rapax))==trimws("NA")),NA,dt1$num.Hargeria.rapax)
dt1$num.Ceratopogonidae <- ifelse((trimws(as.character(dt1$num.Ceratopogonidae))==trimws("NA")),NA,dt1$num.Ceratopogonidae)
dt1$num.Tabanidae <- ifelse((trimws(as.character(dt1$num.Tabanidae))==trimws("NA")),NA,dt1$num.Tabanidae)
dt1$num.Dolichopodidae <- ifelse((trimws(as.character(dt1$num.Dolichopodidae))==trimws("NA")),NA,dt1$num.Dolichopodidae)
dt1$num.Insect <- ifelse((trimws(as.character(dt1$num.Insect))==trimws("NA")),NA,dt1$num.Insect)
dt1$Total.Insect <- ifelse((trimws(as.character(dt1$Total.Insect))==trimws("NA")),NA,dt1$Total.Insect)
dt1$num.Isopoda <- ifelse((trimws(as.character(dt1$num.Isopoda))==trimws("NA")),NA,dt1$num.Isopoda)
dt1$num.Cyathura.polita <- ifelse((trimws(as.character(dt1$num.Cyathura.polita))==trimws("NA")),NA,dt1$num.Cyathura.polita)
dt1$Total.Isopoda <- ifelse((trimws(as.character(dt1$Total.Isopoda))==trimws("NA")),NA,dt1$Total.Isopoda)
dt1$num.mussels <- ifelse((trimws(as.character(dt1$num.mussels))==trimws("NA")),NA,dt1$num.mussels)
dt1$num.Geukensia.demissa <- ifelse((trimws(as.character(dt1$num.Geukensia.demissa))==trimws("NA")),NA,dt1$num.Geukensia.demissa)
dt1$num.Bivalve <- ifelse((trimws(as.character(dt1$num.Bivalve))==trimws("NA")),NA,dt1$num.Bivalve)
dt1$Total.Bivalve <- ifelse((trimws(as.character(dt1$Total.Bivalve))==trimws("NA")),NA,dt1$Total.Bivalve)
dt1$num.Melampus.b. <- ifelse((trimws(as.character(dt1$num.Melampus.b.))==trimws("NA")),NA,dt1$num.Melampus.b.)
dt1$num.Gastropoda <- ifelse((trimws(as.character(dt1$num.Gastropoda))==trimws("NA")),NA,dt1$num.Gastropoda)
dt1$num.Mites <- ifelse((trimws(as.character(dt1$num.Mites))==trimws("NA")),NA,dt1$num.Mites)
dt1$num.Ostracod <- ifelse((trimws(as.character(dt1$num.Ostracod))==trimws("NA")),NA,dt1$num.Ostracod)
dt1$num.Springtail <- ifelse((trimws(as.character(dt1$num.Springtail))==trimws("NA")),NA,dt1$num.Springtail)
dt1$num.Psuedoscorpion <- ifelse((trimws(as.character(dt1$num.Psuedoscorpion))==trimws("NA")),NA,dt1$num.Psuedoscorpion)
dt1$num.Spider <- ifelse((trimws(as.character(dt1$num.Spider))==trimws("NA")),NA,dt1$num.Spider)
dt1$num.Turbellaria <- ifelse((trimws(as.character(dt1$num.Turbellaria))==trimws("NA")),NA,dt1$num.Turbellaria)
dt1$num.flatworm <- ifelse((trimws(as.character(dt1$num.flatworm))==trimws("NA")),NA,dt1$num.flatworm)
dt1$total.flatworm <- ifelse((trimws(as.character(dt1$total.flatworm))==trimws("NA")),NA,dt1$total.flatworm)
dt1$num.Nematostella.vectensis <- ifelse((trimws(as.character(dt1$num.Nematostella.vectensis))==trimws("NA")),NA,dt1$num.Nematostella.vectensis)
dt1$num..Actiniaria <- ifelse((trimws(as.character(dt1$num..Actiniaria))==trimws("NA")),NA,dt1$num..Actiniaria)
dt1$total..Actiniaria <- ifelse((trimws(as.character(dt1$total..Actiniaria))==trimws("NA")),NA,dt1$total..Actiniaria)
dt1$num.Nemertea <- ifelse((trimws(as.character(dt1$num.Nemertea))==trimws("NA")),NA,dt1$num.Nemertea)
dt1$num.Oxyurostylis.smithi <- ifelse((trimws(as.character(dt1$num.Oxyurostylis.smithi))==trimws("NA")),NA,dt1$num.Oxyurostylis.smithi)
dt1$num.unknown <- ifelse((trimws(as.character(dt1$num.unknown))==trimws("NA")),NA,dt1$num.unknown)
dt1$num.Limulus <- ifelse((trimws(as.character(dt1$num.Limulus))==trimws("NA")),NA,dt1$num.Limulus)

ddata <- dt1
save(ddata, file = 'data/raw data/johnson_2019/ddata')



if(FALSE) {
      # Here is the structure of the input data frame:
      str(dt1)
      attach(dt1)
      # The analyses below are basic descriptions of the variables. After testing, they should be replaced.

      summary(Period)
      summary(Year)
      summary(Month)
      summary(Creek)
      summary(Nutrient)
      summary(Branch)
      summary(Fish)
      summary(Transect)
      summary(Habitat)
      summary(Rep)
      summary(num.Fabricia.sabella)
      summary(num.Manayunkia.aestuarina)
      summary(num.Nereis.diversicolor)
      summary(num.Eteone.heteropoda)
      summary(num.Captiella.capitata)
      summary(num.Streblospio.benedicti)
      summary(num.Polydora.cornuta)
      summary(num.Pygospio.elegans)
      summary(num.Marenzelleria.viridis)
      summary(num.Hobsonia.florida)
      summary(num.Orbiniidae)
      summary(num.Total.polychaetes)
      summary(num.Paranais.litoralis)
      summary(num.Tubificoides.benedeni)
      summary(num.Tubificoides.wasselli)
      summary(num.Tubificoides.brownae)
      summary(num.Monopylephorus.sp.)
      summary(num.Psammoryctides.sp.)
      summary(num.Cernosvitoviella.immota)
      summary(num.other_enchytraeids)
      summary(num.Unidentified.oligochaetes)
      summary(Total.Oligochaetes)
      summary(num.amphipods)
      summary(num.talitrid.amphipods)
      summary(num.Orchestia.grillus)
      summary(num.gamarid.amphipods)
      summary(Total.amphipods)
      summary(num.Littorophiloscia.vittata)
      summary(num.Erichsonella.attenuata)
      summary(num.Edotea.triloba)
      summary(num.Hargeria.rapax)
      summary(num.Ceratopogonidae)
      summary(num.Tabanidae)
      summary(num.Dolichopodidae)
      summary(num.Insect)
      summary(Total.Insect)
      summary(num.Isopoda)
      summary(num.Cyathura.polita)
      summary(Total.Isopoda)
      summary(num.mussels)
      summary(num.Geukensia.demissa)
      summary(num.Bivalve)
      summary(Total.Bivalve)
      summary(num.Melampus.b.)
      summary(num.Gastropoda)
      summary(num.Mites)
      summary(num.Ostracod)
      summary(num.Springtail)
      summary(num.Psuedoscorpion)
      summary(num.Spider)
      summary(num.Turbellaria)
      summary(num.flatworm)
      summary(total.flatworm)
      summary(num.Nematostella.vectensis)
      summary(num..Actiniaria)
      summary(total..Actiniaria)
      summary(num.Nemertea)
      summary(num.Oxyurostylis.smithi)
      summary(num.unknown)
      summary(num.Limulus)
      detach(dt1)

}
