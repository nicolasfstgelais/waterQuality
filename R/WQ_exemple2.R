rm(list=ls(all=TRUE))

options(scipen=999)
#library(vegan)
#library(hypervolume)

source("DBnorm.R")
DBnorm(inputFile = "dbInput_cdnRiv_loc.csv",catFile="categories.csv",output="cdnRiv")

source("DBnormStations.R")
DBnormStations(inputFile = "dbInputStations.csv")


#db=read.csv("yamaska_norm.csv",stringsAsFactors = F)
db=read.csv("cdnRiv_norm.csv",stringsAsFactors = F)

stations=read.csv("stations_norm.csv",stringsAsFactors = F,row.names = 1)

options(scipen=999)

CDN=read.csv("CDN_guidelines.csv",stringsAsFactors=FALSE)
CDN$Pollutant=tolower(CDN$Pollutant)
CDN$Pollutant=gsub(" ","",CDN$Pollutant)


unique(db$variable)

selVar=c("arsenic","lead","cadmium","fc","uranium","tp","chla","tn","chloride","copper","molybdenum","nickel","nitrate","zinc","iron","nitrite","toluene","atrazine","simazine","metolachlor","dicamba","bromoxynil","fluoride" )
selPol=c("arsenic","lead","uranium","cadmium")

realSpace=c("aquatic","drink","irrigation","livestock")
modSpace=c("oligotrophic","mesotrophic","recreational")

selSpaces=c("oligotrophic","mesotrophic","eutrophic","aquatic","recreational","drink","irrigation","livestock")


CDNsel=CDN[CDN$Pollutant%in%selVar,]

CDN=norm.units(CDN)

#verify units
for(i in 1:length(selVar)){
  print(paste0(selVar[i],"-",unique(db$units[grep(selVar[i],db$variable,ignore.case = T)])))
}

db$units=gsub("µ","u",db$units)
db$units=gsub("l","L",db$units)

#only keep common units (maybe to include in DBnorm)

db=db[grep("ug/g",db$units,ignore.case = T,invert = T),]

db_sel=db[db$variable%in%selVar,]

#db_sel[,c("date","ym")]=NULL

length(unique(db$station))

db_mean_ym<- plyr::ddply(db_sel, c("station","ym","variable"), plyr::summarise,
                         value    = mean(value))

db_mean_d<- plyr::ddply(db_sel, c("station","date","variable"), plyr::summarise,
                      value    = mean(value))


db_wide_all<- tidyr::spread(data = db_mean_all, 
                        key = variable,
                        value = value)

db_wide<- tidyr::spread(data = db_mean, 
                       key = variable,
                       value = value)

rownames(db_wide)=paste0(db_wide$station,db_wide$ym)
db_wide=db_wide[,-c(1,2)]

rownames(db_wide_all)=paste0(db_wide_all$station,db_wide_all$date)
db_wide_all=db_wide_all[,-c(1,2)]

db_wide[grep("QU02PH9024",rownames(db_wide)),]

mo=LtoN(stringr::str_sub(db_sel$ym, start= -2))
mo=formatC(mo, width = 2, format = "d", flag = "0")

db_mean_mo<- plyr::ddply(cbind(db_sel,mo), c("station","mo","variable"), plyr::summarise,
                      value    = mean(value))

db_wide_mo<- tidyr::spread(data = db_mean_mo, 
                        key = variable,
                        value = value)


rownames(db_wide_mo)=paste0(db_wide_mo$station,db_wide_mo$mo)
db_wide_mo=db_wide_mo[,-c(1,2)]




#db_wide=db_wide[rowSums(is.na(db_wide)) == 0,]



## inclusion matrix
i="06007605202201405"
j="mesotrophic"
m="tp"
db_wide[i,]

db_wide_long=db_wide

db_wide=db_wide_ym[!is.na(db_wide_ym$fc),]
db_wide=db_wide[!is.na(db_wide$tn),]



sel="drink"

rfData=db_wide[!is.na(sitesClass[,sel]),]

#only keep variables with less than 50% of missing value
rfData=rfData[,colSums(is.na(rfData)) <0.75*nrow(rfData)]
rfData$oligotrophic=sitesClass[rownames(rfData),sel]

rfData.imp=randomForest::rfImpute(oligotrophic ~ .,data=rfData)
rf=randomForest::randomForest(oligotrophic ~ .,data=rfDataImputed)
randomForest::varImpPlot(rf,type=2)



data(iris)
iris.na <- iris
set.seed(111)
## artificially drop some data values.
for (i in 1:4) iris.na[sample(150, sample(20)), i] <- NA
set.seed(222)
iris.imputed <- randomForest::rfImpute(Species ~ ., iris.na)


# by month + year ----

i="06007601602201308"
j="mesotrophic"
m="tn"

sitesClass=matrix(NA,nrow(db_wide),length(selSpaces),dimnames=list(rownames(db_wide),selSpaces))
limFreqTable=matrix(0,length(selVar),length(selSpaces),dimnames=list(selVar,selSpaces))
limTotTable=matrix(0,length(selVar),length(selSpaces),dimnames=list(selVar,selSpaces))

c=1
s=NULL
s2=NULL
for(i in rownames(sitesClass)){
  for(j in selSpaces){
    incLow=NA
    incUp=NA
    crit=NULL
    critLim=NULL
    for(m in selVar ){
      upper=LtoN(CDN[CDN$Pollutant==m&CDN$Category==j&CDN$Limit=="upper","Concentration"])
      lower=LtoN(CDN[CDN$Pollutant==m&CDN$Category==j&CDN$Limit=="lower","Concentration"])
      if(length( upper)==0&length(lower)==0)next
      if(is.na(db_wide[i,m]))next
      crit[length(crit)+1]=m
      if(length( upper)==0)upper=Inf
      if(length(lower)==0)lower=0
      if(db_wide[i,m]<upper){incUp=min(incUp,1,na.rm = T)}
      if(db_wide[i,m]<lower){
        incLow=max(incLow,0,na.rm = T)
        #limFreqTable[m,j]=limFreqTable[m,j]+1
        critLim[length(critLim)+1]=m}
      if(db_wide[i,m]>=upper){
        incUp=min(incUp,0,na.rm = T)
        #limFreqTable[m,j]=limFreqTable[m,j]+1
        critLim[length(critLim)+1]=m}
      if(db_wide[i,m]>=lower){incLow=max(incLow,1,na.rm = T)}
    # print(paste0(m,":",incUp,incLow))
      #if(incUp==0)break
    }
    sitesClass[i,j]=min(incUp,incLow)
    if(!is.na(min(incUp,incLow))&min(incUp,incLow)==0){
      limTotTable[crit[!is.na(db_wide[i,crit])],j]=  limTotTable[crit[!is.na(db_wide[i,crit])],j]+1
      limFreqTable[critLim[!is.na(db_wide[i,critLim])],j]=  limFreqTable[critLim[!is.na(db_wide[i,critLim])],j]+1
      
      #if("tn"%in%crit&j=="mesotrophic"){s2[length(s2)+1]=i
      }
    #}
   
  }
  #print(c);c=c+1
}


length(s2)
# divide by occurence to get the frequency when a factor is limiting when measured
occ=apply(db_wide,2,function (x) length(which(!is.na(x))))

temp=db_wide[rownames(sitesClass)[sitesClass[,"mesotrophic"]==0],]
temp2=temp[!is.na(temp$tn),]

setdiff(s2,s)
setdiff(s,s2)

nrow(temp[!is.na(temp$tn),])/nrow(temp)

round(sweep(limFreqTable,MARGIN=1,occ[rownames(limFreqTable)],`/`),2)

round(limFreqTable/limTotTable,2)

## 
db_wide_ym


# siteClass PCA
spaceSel=c("oligotrophic","mesotrophic","aquatic","irrigation","recreational")
sel=which(rowSums(is.na(sitesClass[,spaceSel])) == 0)
pca=prcomp(sitesClass[sel,spaceSel],center = T,scale. = T)
plot(vegan::scores(pca,display = "sites"))
plot(vegan::scores(pca,display = "species"))

library('ReporteRs')


plotPCA<- function(){
plot(vegan::scores(pca,display = "species",choices=c(1,2)))
m=0.8
text(scores(pca,display = "species",choices=c(1,2))*m,labels=rownames(scores(pca,display = "species")),choices=c(1,2),col="red")
}
ReporteRsWrap(plotPCA,"PCA")


plot(sitesClass[sel,"drink"]~sitesClass[sel,"aquatic"])

plot(pca)

pca;;j="mesotrophic"
j="oligotrophic"
j="eutrophic"
i=j


incMatrix=matrix(NA,ncol(sitesClass),ncol(sitesClass),dimnames=list(colnames(sitesClass),colnames(sitesClass)))

for(i in colnames(incMatrix)){
  for(j in colnames(incMatrix)){
    if(i==j){incMatrix[i,j]=round(sum(sitesClass[,i],na.rm = T)/nrow(sitesClass[!is.na(sitesClass[,i]),]),2 )}  else{
      subM=sitesClass[sitesClass[,i]==1&!is.na(sitesClass[,i]),]
      incMatrix[i,j]=round(sum(subM[,j],na.rm = T)/nrow( subM[!is.na(subM[,j]),]),2)}
  }}

library(randomForest)

rf=randomForest(tn~.,data=db_wide[,c("arsenic","cadmium","lead","uranium","tn")]) 

pred <- predict(rf, newdata = test)

test=db_wide[1,c("arsenic","cadmium","lead","uranium")]
test$arsenic=50
test$cadmium=0.9
test$lead=10
test$uranium=150



db_wide_na=db_wide[rowSums(is.na(db_wide[,])) == 2,]

db_wide_na[grep("AL07AA0015",x = rownames(db_wide_na)),]

sel1=grep("AL11AA0003",x = rownames(db_wide_na))
sel2=grep("QU02OB9004",x = rownames(db_wide_na))
sel3=grep("BC08KE0010",x = rownames(db_wide_na))

v=db_wide[grep("BC08KE0010",x = rownames(db_wide)),]
v2=sitesClass[grep("BC08KE0010",x = rownames(sitesClass)),]

#pca
axes=c(1,2)
sc=2
pca=prcomp(db_wide_na[sel2,selPol],center = TRUE,scale. = TRUE)

library(animation)

samp=list()
for(i in colnames(CDN_wide_imp)){
  samp[[i]]=apply(CDN_wide_imp[,i,drop=F],1,guide.samp)
}


plotSpace<-function(main=""){
  plot(vegan::scores(pca,display = "sites",choices =axes),type="n",main=main)
  
  col2rgb("darkgoldenrod2")/255
  myCols=c(rgb(0.09,0.45,0.8,0.35),rgb(0.70,0.13,0.13,0.35),rgb(0.4,0.8,0,0.35),rgb(0.93,0.678,0.54,0.35))
  selSSP=c("drink","aquatic","mesotrophic","oligotrophic")
  
  for(j in 1:length(selSSP)){
    pred=predict(pca, newdata = samp[[selSSP[j]]])
    hpts <- chull(pred)
    hpts <- c(hpts, hpts[1])
    polygon(pred[hpts, ],col=myCols[j])
  }
}
 
sel=list(sel1=sel1,sel2=sel2,sel3=sel3)
j=3


p.sel=vegan::scores(pca,display = "sites",choices = axes)
  plotSpace()
  points(p.sel,cex=1.2,bg="dodgerblue",pch=21,lwd=1.2)
  
  mo=LtoN(stringr::str_sub(rownames(scores(pca,display = "sites",choices =axes)), start= -2))
  y=LtoN(stringr::str_sub(rownames(scores(pca,display = "sites",choices =axes)), start= -6,end=-3))

 #- times=rep(1:26,each=ceiling(nrow(p.sel)/26))[1:nrow(p.sel)]
  times=y
  times.un=unique(month.abb[sort(times)])
  times.un=unique(sort(times))
  
  times=month.abb[times]
  times=y
  
  #anim.plots::anim.points(p.sel,times=times,pch=16,cex=1)
  c=1
  names=letters[seq( from = 1, to = 26 )]
 for(i in unique((times.un))){
  png(paste0("gif/",names[c],".png"),width = 4, height = 4, units = 'in', res = 300)
  plotSpace(i)
  points(p.sel[times==i,],cex=1.2,bg="dodgerblue",pch=21,lwd=1.2)
  dev.off()
  c=c+1
 }

  
  


p.sel=vegan::scores(pca,display = "sites",choices = axes)[sel2,]


p.sel=vegan::scores(pca,display = "sites",choices = axes)[sel3,]
points(p.sel,pch=16,cex=1,col="green")

p.sel=vegan::scores(pca,display = "sites",choices = axes)[sel1,]
points(p.sel,pch=16,cex=1,col="blue")


#points(scores(pca,display = "sites"),pch=16,cex=0.6)




# plot species (red cross OR text)
#points(scores(pca,c(1,2),display="species",scaling=sc),pch=3,cex=0.8,lwd=2,col="red")
m=1
text(scores(pca,display = "species")*m,labels=rownames(scores(pca,display = "species")),col="red")


plot(db_wide[,selPol])

selSSP=c("drink","aquatic","mesotrophic","oligotrophic")

for(i in 1:length(selSSP)){
pred=edges[[selSSP[i]]]
  hpts <- chull(pred)
  hpts <- c(hpts, hpts[1])
  polygon(pred[hpts, ],col=myCols[i])
}


library('ReporteRs')


plotPCA<- function(){
  sc=2
  plot(scores(pca,display = "sites"),type="n",xlim=c(-3,20),ylim=c(-6,20))
  
  points(scores(pca,display = "sites"),pch=16,cex=0.6)
  
  # plot species (red cross OR text)
  #points(scores(pca,c(1,2),display="species",scaling=sc),pch=3,cex=0.8,lwd=2,col="red")
  m=5
  #text(scores(pca,display = "species")*m,labels=rownames(scores(pca,display = "species")),col="red")
  
  col2rgb("darkgoldenrod2")/255
  
  myCols=c(rgb(0.09,0.45,0.8,0.35),rgb(0.70,0.13,0.13,0.35),rgb(0.4,0.8,0,0.35),rgb(0.93,0.678,0.54,0.35))
  
  
  selSSP=c("drink","aquatic","mesotrophic","oligotrophic")
  
  for(i in 1:length(selSSP)){
    pred=predict(pca, newdata = edges[[selSSP[i]]])
    hpts <- chull(pred)
    hpts <- c(hpts, hpts[1])
    polygon(pred[hpts, ],col=myCols[i])
  }
}
ReporteRsWrap(plotPCA,"PCA")


# by month ----

db_wide_mo_long=db_wide_mo

db_wide_mo=db_wide_mo[!is.na(db_wide_mo$fc),]

sitesClass=matrix(NA,nrow(db_wide_mo),length(selSpaces),dimnames=list(rownames(db_wide_mo),selSpaces))

for(i in rownames(sitesClass)){
  for(j in selSpaces){
    incLow=NA
    incUp=NA
    for(m in selVar ){
      upper=CDN[CDN$Pollutant==m&CDN$Category==j&CDN$Limit=="upper","Concentration"]
      lower=CDN[CDN$Pollutant==m&CDN$Category==j&CDN$Limit=="lower","Concentration"]
      if(length( upper)==0&length(lower)==0)next
      if(is.na(db_wide_mo[i,m]))next
      if(length( upper)==0)upper=Inf
      if(length(lower)==0)lower=0
      if(db_wide_mo[i,m]<upper){incUp=min(incUp,1,na.rm = T)}
      if(db_wide_mo[i,m]<=lower){incLow=max(incLow,0,na.rm = T)}
      if(db_wide_mo[i,m]>=upper){incUp=min(incUp,0,na.rm = T)}
      if(db_wide_mo[i,m]>lower){incLow=max(incLow,1,na.rm = T)}
      #if(incUp==0)break
    }
    sitesClass[i,j]=min(incUp,incLow)
  }
}


sitesClass= sitesClass[rowSums(is.na( sitesClass[,])) == 0,]

j="mesotrophic"
j="oligotrophic"
j="eutrophic"
i=j


incMatrix=matrix(NA,ncol(sitesClass),ncol(sitesClass),dimnames=list(colnames(sitesClass),colnames(sitesClass)))

location$car=NA


for(i in colnames(incMatrix)){
  for(j in colnames(incMatrix)){
    if(i==j){incMatrix[i,j]=round(sum(sitesClass[,i],na.rm = T)/nrow(sitesClass[!is.na(sitesClass[,i]),]),2 )}  else{
      subM=sitesClass[sitesClass[,i]==1,]
      incMatrix[i,j]=round(sum(subM[,j],na.rm = T)/nrow( subM[!is.na(subM[,j]),]),2)}
  }}

# add location

location=matrix(NA,nrow(sitesClass),2,dimnames=list(rownames(sitesClass),c("long","lat")))

for(i in rownames(location))
{
  site=stringr::str_sub(i,start=0,end=-3)
  if(length(stations[site,"latitude"])==0)next
  location[i,"lat"]=stations[site,"latitude"]
  location[i,"long"]=stations[site,"longitude"]
}

location=as.data.frame(location)
db_wide_na=db_wide[rowSums(is.na(db_wide[,selPol])) == 0,]


sitesClass=sitesClass[!is.na(location[,"lat"]),]

location$col=NA
location$col[sitesClass[,"oligotrophic"]==1]="cadetblue3"
location$col[sitesClass[,"mesotrophic"]==1]="dodgerblue"
location$col[sitesClass[,"eutrophic"]==1]="chartreuse3"

location$col=NA
location$col[sitesClass[,"drink"]==0]="firebrick"
location$col[sitesClass[,"drink"]==1]="firebrick"


location$col=NA
location$col[sitesClass[,"swim"]==0]="chartreuse3"
location$col[sitesClass[,"swim"]==1]="firebrick"

location$col[sitesClass[,"aquatic"]==1]="darkgoldenrod3"
location$col[sitesClass[,"oligotrophic"]==1]="cadetblue3"

location$mo=LtoN(stringr::str_sub(rownames(location), start= -2))


times.un=unique(month.abb[sort(location$mo)])
location$mo=month.abb[location$mo]

do.call(file.remove,list(paste0("gif/",(list.files("gif/",pattern="png")))))

c=1
library(maps)
library(mapdata)
p <- ggmap(map)

#map <- get_map( zoom = 5,scale=2, maptype = "sat",location = c(min(locSel$long),min(locSel$lat),max(locSel$long),max(locSel$lat)))
map <- get_map(maptype = "sat",location = c(-76.3,44.7,-75.3,45.7))


names=letters[seq( from = 1, to = 26 )]
for(i in times.un ){
  png(paste0("gif/",names[c],".png"),width = 5, height = 5, units = 'in', res = 300)
  sel=location$mo%in%i
  locSel=location[sel,]
  p <- ggmap(map)
  p <- p + geom_point(data=as.data.frame(locSel), aes(x=long, y=lat),color=locSel$col,size=3)
  p <- p+ggtitle(i)
  print(p)
  #plot(locSel$long,locSel$lat,col=locSel$col,pch=16,cex=1.5,xlim=c(-80,-70),ylim=c(45,48),main=i)
  #legend("topright",legend = c("Oligotrophic","Aquatic","Drinkable"),cex=1,col=c("cadetblue3","darkgoldenrod3","firebrick"),pch=16)
  #legend("topright",legend = c("Oligotrophic","Mesotrophic","Eutrophic"),cex=1,col=c("cadetblue3","dodgerblue","chartreuse3"),pch=16)
  
  dev.off()
  c=c+1
  print(i)
  }

shell(paste("cd gif", "&& convert -delay 80 *.png cdn_all_mo_2.gif",sep=" "))









