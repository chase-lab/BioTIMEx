### fridley_2009

infile1csv <- 'data/raw data/fridley_2009/doi 10.5063_AA_fridley.5.1.data.csv'
if(!dir.exists('data/raw data/fridley_2009/') || !file.exists(infile1csv)){
   dir.create('data/raw data/fridley_2009/')
   infile1 <- 'data/raw data/fridley_2009/doi 10.5063_AA_fridley.5.1.data'
   inURL1 <- 'https://knb.ecoinformatics.org/knb/d1/mn/v2/object/doi%3A10.5063%2FAA%2Ffridley.5.1'
   download.file(inUrl1, infile1, method="auto")
   file.append(infile1csv, infile1)
}
