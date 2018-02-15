
dir="C:/Users/nicol/Dropbox/ReseauLab/data/water quality/canadian rivers/to extract_Genie"

files=list.files(dir)

dbMerged=data.frame()

c=1
for(i in files){
db=as.data.frame(readxl::read_excel(paste0(dir,"/",i), sheet = 1))
db$VariablePhase=paste(db$VariableEn,db$PhaseEn)
db$MeasurementUnit=gsub("µ","u",db$MeasurementUnit)
unique(db$VariableEn)
inter=intersect(colnames(dbMerged),colnames(db))
if(c==1)dbMerged=rbind(db,dbMerged)
if(c!=1)dbMerged=rbind(db[,inter],dbMerged[,inter])
c=1+1
}

write.csv(dbMerged,"C:/Users/nicol/Dropbox/ReseauLab/data/water quality/canadian rivers/CdnRivMerged.csv")


