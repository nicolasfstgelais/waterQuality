rm(list=ls(all=TRUE))


# class 


import="data/dataCDN.RData"
db_wide="db_wide_ym"
selSpaces=c("oligotrophic","mesotrophic","eutrophic","aquatic","recreational","drink","irrigation","livestock")


sitesClassification<-function(import,db_wide,selSpaces)
{
source("R/functions.R")
load(import)
db_wide=get(db_wide)
selVar=colnames(db_wide)

# forced to have fc measures
#db_wide=db_wide[!is.na(db_wide$fc),]
db_wide=db_wide[1:100,]


sitesClass=matrix(NA,nrow(db_wide),length(selSpaces),dimnames=list(rownames(db_wide),selSpaces))
limFreqTable=matrix(0,length(selVar),length(selSpaces),dimnames=list(selVar,selSpaces))
limTotTable=matrix(0,length(selVar),length(selSpaces),dimnames=list(selVar,selSpaces))

c=1
pb <- txtProgressBar(min = 0, max = nrow(sitesClass), style = 3)

for(i in rownames(sitesClass)){
  Sys.sleep(0.1)
  for(j in selSpaces){
    incLow=NA
    incUp=NA
    crit=NULL
    critLim=NULL
    for(m in selVar ){
      upper=LtoN(guide[guide$Pollutant==m&guide$Category==j&guide$Limit=="upper","Concentration"])
      lower=LtoN(guide[guide$Pollutant==m&guide$Category==j&guide$Limit=="lower","Concentration"])
      if(length( upper)==0&length(lower)==0)next
      if(is.na(db_wide[i,m]))next
      crit[length(crit)+1]=m
      if(length( upper)==0)upper=Inf
      if(length(lower)==0)lower=0
      if(db_wide[i,m]<upper){incUp=min(incUp,1,na.rm = T)}
      if(db_wide[i,m]<lower){
        incLow=max(incLow,0,na.rm = T)
        critLim[length(critLim)+1]=m}
      if(db_wide[i,m]>=upper){
        incUp=min(incUp,0,na.rm = T)
        critLim[length(critLim)+1]=m}
      if(db_wide[i,m]>=lower){incLow=max(incLow,1,na.rm = T)}
      # print(paste0(m,":",incUp,incLow))
      #if(incUp==0)break
    }
    sitesClass[i,j]=min(incUp,incLow)
    if(!is.na(min(incUp,incLow))&min(incUp,incLow)==0){
      limTotTable[crit[!is.na(db_wide[i,crit])],j]=  limTotTable[crit[!is.na(db_wide[i,crit])],j]+1
      limFreqTable[critLim[!is.na(db_wide[i,critLim])],j]=  limFreqTable[critLim[!is.na(db_wide[i,critLim])],j]+1
    }
    #}
    
  }
  print(c);
  c=c+1
  setTxtProgressBar(pb, c)
}
close(pb)


save(sitesClass,limFreqTable,limTotTable,file="data/sitesClass.RData")
}

