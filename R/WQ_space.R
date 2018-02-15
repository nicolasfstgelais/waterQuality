library(tidyr)
library(hypervolume)
library('ReporteRs') # Load

options(scipen=999)

CDN=read.csv("CDN_guidelines.csv",stringsAsFactors=FALSE)

#CDN$Pollutant=gsub(pattern = "\n",replacement = "",x = CDN$Pollutant)
#write.csv(CDN,"CDN_guidelines.csv")

#CDN$Concentration=as.numeric(CDN$Concentration)

CDN=norm.units(CDN)

CDN_wide<- spread(data = CDN[,c("Category","Pollutant","Concentration")], 
            key = Category,
            value = Concentration)

# 2D space

rownames(CDN_wide)=CDN_wide$Pollutant;CDN_wide=CDN_wide[,-1]

pol=c("Microcystin","Escherichia coli")

CDN_wide_sel=CDN_wide[pol,]

CDN_wide_sel=CDN_wide_sel[,colSums(is.na(CDN_wide_sel)) == 0]

plot(1,1,ylim=c(0.6,max(CDN_wide_sel["Escherichia coli",])),xlim=c(0.7,max(CDN_wide_sel["Microcystin",])),type="n",log="xy")
#rect(1, 1, 20, 200,col=rgb(1,0,0,0.3),border=0)

#rect(1, 0.5, 5, 5,col=rgb(1,0,0,0.3),border=0)
rect(0.8,0.8, CDN_wide_sel$recreational[1], CDN_wide_sel$recreational[2],col=rgb(0.09,0.45,0.8,0.5),border=0)
rect(0.8,0.8, CDN_wide_sel$swim[1], CDN_wide_sel$swim[2],col=rgb(0.70,0.13,0.13,0.5),border=0)
rect(0.8,0.8, CDN_wide_sel$drink[1], CDN_wide_sel$drink[2],col=rgb(0.27,0.54,0,0.5),border=0)



col2rgb("chartreuse4")/255

plot2D<- function(){
  plot(1,1,ylim=c(0.6,max(CDN_wide_sel["Escherichia coli",])),xlim=c(0.7,max(CDN_wide_sel["Microcystin",])),type="n",log="xy")
  rect(0.8,0.8, CDN_wide_sel$recreational[1], CDN_wide_sel$recreational[2],col=rgb(0.09,0.45,0.8,0.5),border=0)
  rect(0.8,0.8, CDN_wide_sel$swim[1], CDN_wide_sel$swim[2],col=rgb(0.70,0.13,0.13,0.5),border=0)
  rect(0.8,0.8, CDN_wide_sel$drink[1], CDN_wide_sel$drink[2],col=rgb(0.27,0.54,0,0.5),border=0)
}
ReporteRsWrap(plot2D,"2D")

# multidimentinal space

CDN_wide_sel=CDN_wide[rowSums(is.na(CDN_wide_sel)) == 0,]
CDN_wide_sel=CDN_wide[selPol,c("aquatic","drink","irrigation","livestock" ,"swim")]

CDN_wide_sel=completeGuidelines(CDN_wide_sel,dbSel_wide)



edgesDrink=create.edges(CDN_wide_sel,"drink")
hyperDrink=hypervolume_gaussian(edgesDrink)
#hyperDrink=hypervolume_box(edgesDrink)

edgesSwim=create.edges(CDN_wide_sel,"swim")
hyperSwim=hypervolume_gaussian(edgesSwim)

edgesIrrigation=create.edges(CDN_wide_sel,"irrigation")
hyperIrrigation=hypervolume_gaussian(edgesIrrigation)
#hyperIrrigation=hypervolume_box(edgesIrrigation)


edgesLivestock=create.edges(CDN_wide_sel,"livestock")
hyperLivestock=hypervolume_gaussian(edgesLivestock)
#hyperLivestock=hypervolume_box(edgesLivestock)


edgesAquatic=create.edges(CDN_wide_sel,"aquatic")
hyperAquatic=hypervolume_gaussian(edgesAquatic)
#hyperAquatic=hypervolume_box(edgesAquatic)


hyperSet_DI=hypervolume_set(hyperDrink,hyperIrrigation,check.memory=FALSE)
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




incDrink=hypervolume_inclusion_test(hyperDrink, points=data.matrix(columbiaSel))
length(incDrink[incDrink==TRUE])/length(incDrink)

incAquatic=hypervolume_inclusion_test(hyperAquatic, points=data.matrix(columbiaSel))
length(incAquatic[incAquatic==TRUE])/length(incAquatic)

incIrrigation=hypervolume_inclusion_test(hyperIrrigation, points=data.matrix(columbiaSel))
length(incIrrigation[incIrrigation==TRUE])/length(incIrrigation)

plot.HypervolumeList(hyperSet_DA,show.3d=T,cex.data=2,point.alpha.min=1)
plot.HypervolumeList(hyperSet_IL,show.3d=T,cex.data=2,point.alpha.min=1)

