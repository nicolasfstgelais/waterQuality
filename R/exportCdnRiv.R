
dir="C:/Users/nicol/Dropbox/ReseauLab/data/water quality/canadian rivers/to extract"

files=list.files(dir)

dbMerged=data.frame()

for(i in files){
db=as.data.frame(readxl::read_excel(paste0(dir,"/",i), sheet = 2))
db$VariablePhase=paste(db$VariableEn,db$PhaseEn)
db$MeasurementUnit=gsub("µ","u",db$MeasurementUnit)
dbMerged=rbind(db,dbMerged)
}

write.csv(dbMerged,"C:/Users/nicol/Dropbox/ReseauLab/data/water quality/canadian rivers/CdnRivMerged.csv")

i="Info5 (1).xlsx"
