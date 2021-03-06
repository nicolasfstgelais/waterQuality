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
selSpaces=c("aquatic")

selOut=""

sitesClassification<-function(import,db_wide,selSpaces,selOut="")
{
source("R/functions.R")
load(paste0("data/dataCDN",selOut,".RData"))
db_wide=get(db_wide)
selVar=colnames(db_wide)

# forced to have fc measures
#db_wide=db_wide[!is.na(db_wide$fc),]
#import="data/dataCDN.RData"

#load(paste0("data/sitesClass",selOut,".RData"))




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
critLim=matrix(NA,length(selSpaces),length(selVar),dimnames=list(selSpaces,selVar))

indic<-function(x)length(which(is.nan(x)))/(length(which(is.nan(x)))+(length(which(is.infinite(x)))))

j="aquatic"
for(j in selSpaces){

# Initiate cluster
cl <- makeCluster(no_cores)
registerDoSNOW(cl)

subGuide=guide[guide$Pollutant%in%selVar&guide$Category==j,]
subGuide$Concentration=LtoN(subGuide$Concentration)

guideUpper=guide[guide$Pollutant%in%selVar&guide$Category==j&guide$Limit=="upper",c("Pollutant","Concentration")]
rn=guideUpper$Pollutant;guideUpper=unlist(guideUpper[,2]);names(guideUpper)=rn


guideLower=guide[guide$Pollutant%in%selVar&guide$Category==j&guide$Limit=="lower",c("Pollutant","Concentration")]
rn=guideLower$Pollutant;guideLower=unlist(guideLower[,2]);names(guideLower)=rn


db_wide=as.matrix(db_wide[1:1000,])


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
      upper=as.numeric(guideUpper[m])
      lower=as.numeric(guideLower[m])
      if(is.na( upper)&is.na(lower))nExT=T
      if(is.na(enviro[m]))nExT=T
      if(nExT==F){
        #crit[length(crit)+1]=m
        if(is.na( upper))upper=Inf
        if(is.na(lower))lower=0
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

if(file.exists(paste0("data/sitesClass",selOut,".RData"))){
  load(paste0("data/sitesClass",selOut,".RData"))
  
  if(j%in%colnames(sitesClass))
  {
    sitesClass[,j]=apply(x,1,min,na.rm=T)
    sitesClass[is.infinite(sitesClass)]=NA
    
  }
  if(!j%in%colnames(sitesClass))
  {
    sitesClass=cbind(sitesClass,apply(x,1,min,na.rm=T))
    colnames(sitesClass)[ncol(sitesClass)]=j
    sitesClass[is.infinite(sitesClass)]=NA
    }
  }


#-save(sitesClass,sitesClass_raw,critLim,file=paste0("data/sitesClass",selOut,".RData"))

save(sitesClass,file=paste0("data/sitesClass",selOut,".RData"))



s=sweep(sitesClass_raw[[j]],MARGIN=1,sitesClass[,j],`/`)
temp=apply(s,2,indic)
temp[is.nan(temp)]=NA
critLim[j,]=temp

stopCluster(cl)
print(j)
}

save(sitesClass_raw,file=paste0("data/sitesClass_raw",selOut,".RData"))
save(critLim,file=paste0("data/critLim",selOut,".RData"))
close(pb)


}


