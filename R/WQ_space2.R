#library(tidyr)
#library(hypervolume)
#library('ReporteRs') # Load

options(scipen=999)

CDN=read.csv("CDN_guidelines.csv",stringsAsFactors=FALSE)

#CDN$Concentration=as.numeric(CDN$Concentration)

CDN=norm.units(CDN)

CDNsel=CDN[CDN$Pollutant%in%selVar&CDN$Limit=="upper",]

library(data.table) ## v >= 1.9.6

CDN_wide<- tidyr::spread(data = CDNsel[,c("Category","Pollutant","Concentration","Limit")], 
            key = Category,
            value = Concentration)

rownames(CDN_wide)=tolower(CDN_wide$Pollutant);CDN_wide=CDN_wide[,-1]
#CDN_wide=CDN_wide[rowSums(is.na(CDN_wide)) == 0,]

CDN_wide_sel=CDN_wide[selVar,c(realSpace,modSpace)]

sel=grep(("QU02OB9004"),x = rownames(db_wide))
db_wide_sel=db_wide[,]

#remove outiler 

#outLow<-function(x)as.numeric(quantile(x,probs = c(0.5,0.99))["1%"]-(1.5*IQR(x)))
#outUp<-function(x)as.numeric(quantile(x,probs = c(0.5,0.99))["99%"]+(1.5*IQR(x)))

#out=apply(db_wide,2,outUp)

#for(i in names(out)){
 # db_wide=db_wide[db_wide[,i]<out[i],]
#}

impDB=rbind(db_wide_sel,matrix(NA,length(modSpace),ncol(db_wide_sel),dimnames=list(modSpace,colnames(db_wide_sel))))
impDB[modSpace,]=t(CDN_wide_sel[colnames(impDB),modSpace])
impDB=(missForest::missForest(impDB))$ximp

CDN_wide_imp=CDN_wide_sel
CDN_wide_imp[,modSpace]=t(impDB[modSpace,rownames(CDN_wide_imp)])
CDN_wide_imp=CDN_wide_imp[rowSums(is.na(CDN_wide_imp)) == 0,]


edges=list()
hypervol=list()

for(i in colnames(CDN_wide_imp)){
  edges[[i]]=create.edges(mat=CDN_wide_imp,col=i)
  hypervol[[i]]=hypervolume::hypervolume_gaussian( edges[[i]])
}

names( hypervol)

CDN_wide_sel=CDN_wide_sel[rowSums(is.na(CDN_wide_sel)) == 0,]

incMatrix=matrix(NA,length(hypervol),length(hypervol),dimnames=list(names(hypervol),names(hypervol)))


for(i in names(hypervol)){
  for(j in names(hypervol)){
    if(i==j)incMatrix[i,j]=hyperInclusion(db_wide[,selPol],hypervol[[i]])else{
  hyperset=hypervolume_set(hypervol[[i]],hypervol[[j]],check.memory=FALSE,verbose = F)
  intersect=hyperInclusion(db_wide[,selPol],hyperset@HVList$Intersection)
  HV1=hyperInclusion(db_wide[,selPol],hyperset@HVList$HV1)
  incMatrix[i,j]= intersect/HV1}
}}



hypervolume_overlap_statistics(hypervolume_set(hypervol[["oligotrophic"]],hypervol[["mesotrophic"]],check.memory=FALSE))


hyperSet_AM=hypervolume::hypervolume_set(hypervol[["aquatic"]],hypervol[["mesotrophic"]],check.memory=FALSE)
hyperSet_AO=hypervolume::hypervolume_set(hypervol[["aquatic"]],hypervol[["oligotrophic"]],check.memory=FALSE)
hyperSet_AM=hypervolume::hypervolume_set(hypervol[["aquatic"]],hypervol[["mesotrophic"]],check.memory=FALSE)


hyperInclusion(db_wide[,selPol],hyperSet_AM@HVList$Union)

hyperInclusion<-function(points,set){
  inc=hypervolume::hypervolume_inclusion_test(set, points=data.matrix(points),verbose = F)
  return(length(inc[inc==TRUE])/length(inc))
}






hypervolume_overlap_statistics(hyperSet_AM)

hyperSet_DI=hypervolume_set(hyper,hyperIrrigation,check.memory=FALSE)
hypervolume_overlap_statistics(hyperSet_DI)

hyperSet_DS=hypervolume_set(hyperDrink,hyperSwim,check.memory=FALSE)
hypervolume_overlap_statistics(hyperSet_DI)

hyperSet_DA=hypervolume_set(hyperDrink,hyperAquatic,check.memory=FALSE)
hypervolume_overlap_statistics(hyperSet_DA)

hyperSet_DL=hypervolume_set(hyperDrink,hyperLivestock,check.memory=FALSE)
hypervolume_overlap_statistics(hyperSet_DL)

hyperSet_IL=hypervolume_set(hyperIrrigation,hyperLivestock,check.memory=FALSE)
hypervolume_overlap_statistics(hyperSet_IL)

hyperSet_AL=hypervolume_set(hyperLivestock,hyperAquatic,check.memory=FALSE,num.points.max=5000000)
hypervolume_overlap_statistics(hyperSet_AL)

hyperSet_IL=hypervolume_set(hyperIrrigation,hyperAquatic,check.memory=FALSE)
hypervolume_overlap_statistics(hyperSet_AL)

hyperSet_IS=hypervolume_set(hyperIrrigation,hyperSwim,check.memory=FALSE)
hypervolume_overlap_statistics(hyperSet_IS)

hyperSet_LS=hypervolume_set(hyperLivestock,hyperSwim,check.memory=FALSE)
hypervolume_overlap_statistics(hyperSet_LS)

hyperSet_SA=hypervolume_set(hyperSwim,hyperAquatic,check.memory=FALSE)
hypervolume_overlap_statistics(hyperSet_AL)


hypervolume_overlap_statistics(hyperSet_DI)




inc=hypervolume::hypervolume_inclusion_test(hyperSet_AM@HVList$Intersection, points=data.matrix(db_wide[,selPol]))
length(incDrink[inc==TRUE])/length(inc)


incDrink=hypervolume::hypervolume_inclusion_test(hypervol[["mesotrophic"]], points=data.matrix(db_wide[,selPol]))
length(incDrink[incDrink==TRUE])/length(incDrink)

incDrink=hypervolume::hypervolume_inclusion_test(hypervol[["aquatic"]], points=data.matrix(db_wide[,selPol]))
length(incDrink[incDrink==TRUE])/length(incDrink)

incAquatic=hypervolume_inclusion_test(hyperAquatic, points=data.matrix(columbiaSel))
length(incAquatic[incAquatic==TRUE])/length(incAquatic)

incIrrigation=hypervolume_inclusion_test(hyperIrrigation, points=data.matrix(columbiaSel))
length(incIrrigation[incIrrigation==TRUE])/length(incIrrigation)

plot.HypervolumeList(hyperSet_DA,show.3d=T,cex.data=2,point.alpha.min=1)
plot.HypervolumeList(hyperSet_IL,show.3d=T,cex.data=2,point.alpha.min=1)

