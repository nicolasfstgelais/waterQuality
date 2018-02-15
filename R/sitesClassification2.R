rm(list=ls(all=TRUE))

library(foreach)
library(parallel)
library(doSNOW)


no_cores <- detectCores() - 2

# Initiate cluster
cl <- makeCluster(no_cores)
registerDoSNOW(cl)
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
#db_wide=db_wide[1:1000,]


sitesClass=matrix(NA,nrow(db_wide),length(selSpaces),dimnames=list(rownames(db_wide),selSpaces))
limFreqTable=matrix(0,length(selVar),length(selSpaces),dimnames=list(selVar,selSpaces))
limTotTable=matrix(0,length(selVar),length(selSpaces),dimnames=list(selVar,selSpaces))

c=1
#pb <- txtProgressBar(min = 0, max = nrow(sitesClass), style = 3)

pb <- txtProgressBar(max = nrow(sitesClass)*length(selVar), style = 3)
progress <- function(n) setTxtProgressBar(pb, n)
opts <- list(progress = progress)
class=rep(NA,length(selSpaces));names(class)=selSpaces

sitesClass_raw=list()

for(j in selSpaces){

# Initiate cluster
cl <- makeCluster(no_cores)
registerDoSNOW(cl)

subGuide=guide[guide$Pollutant%in%selVar&guide$Category==j,]
subGuide$Concentration=LtoN(subGuide$Concentration)

x <-foreach(i=rownames(db_wide), .combine='rbind',.options.snow = opts) %:%
  #Sys.sleep(0.1)
  #x <-foreach(i=rownames(sitesClass), .combine='rbind') %:%
  

    foreach(m= selVar, .combine='cbind') %dopar% {
      incLow=NA
      incUp=NA
      enviro=db_wide[i,]
      #crit=NULL
      #critLim=NULL
      nExT=F
      upper=subGuide[subGuide$Pollutant==m&subGuide$Limit=="upper","Concentration"]
      lower=subGuide[subGuide$Pollutant==m&subGuide$Limit=="lower","Concentration"]
      if(length( upper)==0&length(lower)==0)nExT=T
      if(is.na(enviro[m]))nExT=T
      if(nExT==F){
      #crit[length(crit)+1]=m
      if(length( upper)==0)upper=Inf
      if(length(lower)==0)lower=0
      if(enviro[m]<upper){incUp=min(incUp,1,na.rm = T)}
      if(enviro[m]<lower){
        incLow=max(incLow,0,na.rm = T)
        #critLim[length(critLim)+1]=m
        }
      if(enviro[m]>=upper){
        incUp=min(incUp,0,na.rm = T)
       # critLim[length(critLim)+1]=m
        }
      if(enviro[m]>=lower){incLow=max(incLow,1,na.rm = T)}
      # print(paste0(m,":",incUp,incLow))
      #if(incUp==0)break
      }
   min=min(incUp,incLow)
   names(min)=i
   min
    }

colnames(x)=selVar
sitesClass_raw[[j]]=x

stopCluster(cl)
}

sitesClass[,j]=apply(x,1,min,na.rm=T)
sitesClass[is.infinite(sitesClass)]=NA



#sitesClass[i,j]=min(incUp,incLow)
    #data.frame(sitesClass)
    if(!is.na(min(incUp,incLow))&min(incUp,incLow)==0){
      #limTotTable[crit[!is.na(db_wide[i,crit])],j]=  limTotTable[crit[!is.na(db_wide[i,crit])],j]+1
      #limFreqTable[critLim[!is.na(db_wide[i,critLim])],j]=  limFreqTable[critLim[!is.na(db_wide[i,critLim])],j]+1
    }
    #}
 #   setTxtProgressBar(pb, c)
  #  print(c);
   # c=c+1
  }
 


close(pb)


save(sitesClass,limFreqTable,limTotTable,file="data/sitesClass.RData")
}

