rm(list=ls(all=TRUE))

### Adding a new variable###
#1- Add variable + keywords in inputs/categories.csv
#2- Check the log (in /log) to make sure that keywords are ok

## Adding a database###
#1- add database information in inputs/inputs.csv


source("R/dbExtract.R")
#bExtract(inputFile = "dbInput_cdnRiv_loc.csv",catFile="categories.csv",output="cdnRiv")

source("R/DBnormStations.R")
#DBnormStations(inputFile = "dbInputStations.csv")

source("R/dataPrep.R")
dataPrep(dbPath="data/cdnRiv_norm.csv",stationsPath="data/stations_norm.csv",guidePath="data/CDN_guidelines.csv",
                     outputPath="data/dataCDN",selOut="e.coli")
  
source("R/sitesClassification.R")
selSpaces=c("oligotrophic","mesotrophic","eutrophic","aquatic","recreational","drink","irrigation","livestock")
sitesClassification(import="data/dataCDN.RData",db_wide="db_wide_ym",selSpaces=selSpaces,selOut="e.coli")
  


