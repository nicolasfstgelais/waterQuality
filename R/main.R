rm(list=ls(all=TRUE))

source("R/DBnorm.R")
#DBnorm(inputFile = "dbInput_cdnRiv_loc.csv",catFile="categories.csv",output="cdnRiv")

source("R/DBnormStations.R")
#DBnormStations(inputFile = "dbInputStations.csv")

source("R/dataPrep.R")
dataPrep(dbPath="data/cdnRiv_norm.csv",stationsPath="data/stations_norm.csv",guidePath="data/CDN_guidelines.csv",
                     outputPath="data/dataCDN.RData")
  
source("R/sitesClassification2.R")
selSpaces=c("oligotrophic","mesotrophic","eutrophic","aquatic","recreational","drink","irrigation","livestock")
sitesClassification(import="data/dataCDN.RData",db_wide="db_wide_ym",selSpaces=selSpaces)


