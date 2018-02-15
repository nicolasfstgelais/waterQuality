
dir="C:/Users/nicol/Dropbox/ReseauLab/data/water quality/canadian rivers/to extract_online"

files=list.files(dir)

dbMerged=data.frame()

for(i in files){
db$units=gsub("µ","u",db$units)
dbMerged=rbind(db,dbMerged)
}

write.csv(dbMerged,"C:/Users/nicol/Dropbox/ReseauLab/data/water quality/canadian rivers/CdnRivMerged_online.csv")


i="Water-Qual-Eau-Arctic-2000-present.csv"
