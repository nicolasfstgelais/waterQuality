columbia=read.csv("Water-Qual-Eau-Columbia-2000-present.csv",stringsAsFactors=FALSE)

norm.units<-function(mat,conc="Concentration",units="Units")
{
  mgL=mat[,units]=="mg/L"
  mat[mgL,conc]=as.numeric(mat[mgL,conc])*1000
  return(mat)
}

DBnorm(name="yamaska")

columbia=norm.units(columbia,"VALUE_VALEUR","UNIT_UNITE")

library(plyr)

columbiaSel=columbia[columbia$VARIABLE%in%c("Arsenic","Cadmium","Lead","Uranium"),c("VALUE_VALEUR","VARIABLE","SITE_NO","DATE_TIME_HEURE")]

columbiaAll=columbia[columbia$VARIABLE%in%c("Arsenic","Cadmium","Lead","Uranium","ALKALINITY TOTAL CAC3","CARBON DISSOLVED ORGANIC","HARDNESS TOTAL (CALCD.) CACO3","PH","PHOSPHORUS TOTAL","NITROGEN TOTAL"),c("VALUE_VALEUR","VARIABLE","SITE_NO","DATE_TIME_HEURE")]



columbiaSel_mean<- ddply(columbiaSel, c("SITE_NO","DATE_TIME_HEURE","VARIABLE"), summarise,
               ResultMeasureValue    = mean(VALUE_VALEUR))

columbiaSAll_mean<- ddply(columbiaAll, c("SITE_NO","DATE_TIME_HEURE","VARIABLE"), summarise,
                          VALUE_VALEUR    = mean(VALUE_VALEUR))

columbia_wide<- spread(data = columbiaSel, 
                  key = VARIABLE,
                  value = VALUE_VALEUR)

columbiaAll_wide<- spread(data = columbiaSAll_mean, 
                       key = VARIABLE,
                       value = VALUE_VALEUR)

rownames(columbiaAll_wide)=paste0(columbiaAll_wide$SITE_NO,columbiaAll_wide$DATE_TIME_HEURE)
columbiaAll_wide=columbiaAll_wide[,-c(1,2)]
columbiaAll_wide=columbiaAll_wide[rowSums(is.na(columbiaAll_wide)) == 0,]

columbiaSel=columbiaAll_wide[,c("Arsenic","Cadmium","Lead","Uranium")]
columbiaAll_diff=columbiaAll_wide
columbiaAll_diff[,c("Arsenic","Cadmium","Lead","Uranium")]=NULL


#-library(missForest)
#-merged_imp=missForest(merged)$ximp


merged_diff=merged_imp
merged_diff[,c("Arsenic","Cadmium","Lead","Uranium")]=NULL

mergedSel=merged_imp[,c("Arsenic","Cadmium","Lead","Uranium")]


pca=prcomp(columbiaSel,center = TRUE,scale. = TRUE)

#-edgesDrink_mod=matrix(NA,nrow(edgesDrink),ncol(columbiaAll_wide),dimnames=list(paste0("drink",1:nrow(edgesDrink_mod)),colnames(columbiaAll_wide)))
#-edgesDrink_mod[1:nrow(edgesDrink),c("Arsenic","Cadmium","Lead","Uranium")]=as.matrix(edgesDrink)
#-merged=rbind(columbiaAll_wide,edgesDrink_mod)


# plot the RDA
sc=2
plot(scores(pca,display = "sites"),type="n",ylim=c(-300,300),xlim=c(0,700))
# plot sites

colnames(edgesIrrigation)=colnames(columbiaSel)
predIrrigation=predict(pca, newdata = edgesIrrigation)
hpts <- chull(predIrrigation)
hpts <- c(hpts, hpts[1])
polygon(predIrrigation[hpts, ],col=rgb(0.09,0.45,0.8,0.5))

colnames(edgesLivestock)=colnames(columbiaSel)
predLivestock=predict(pca, newdata = edgesLivestock)
hpts <- chull(predLivestock)
hpts <- c(hpts, hpts[1])
polygon(predLivestock[hpts, ],col=rgb(0.09,0.45,0.8,0.5))

colnames(edgesDrink)=colnames(columbiaSel)
predDrink=predict(pca, newdata = edgesDrink)
hpts <- chull(predDrink)
hpts <- c(hpts, hpts[1])
polygon(predDrink[hpts, ],col=rgb(0.09,0.45,0.8,0.5))

#wq polygon
colnames(edgesAquatic)=colnames(columbiaSel)

predAquatic=predict(pca, newdata = edgesAquatic)
hpts <- chull(predAquatic)
hpts <- c(hpts, hpts[1])
polygon(predAquatic[hpts, ],col=rgb(0.70,0.13,0.13,0.5))



points(scores(pca,display = "sites"),pch=16,cex=0.8)

# plot species (red cross OR text)
#points(scores(pca,c(1,2),display="species",scaling=sc),pch=3,cex=0.8,lwd=2,col="red")
m=12
text(scores(pca,display = "species")*m,labels=rownames(scores(pca,display = "species")),col="red")

envfit=vegan::envfit(pca, data.matrix(columbiaAll_diff), perm = 999)
#plot(envfit)
envFit_ar=envfit$vectors$arrows

# plot selected variables
m=10
arrows(0,0,envFit_ar[,1]*m,envFit_ar[,2]*m,length=0.1,lwd=2)
text(envFit_ar[,1:2]*m,labels=rownames(envFit_ar),cex=0.8)






plotPCA<- function(){
  sc=2
  plot(scores(pca,display = "sites"),type="n",ylim=c(-10,10))
  # plot sites
  
  #colnames(edgesIrrigation)=colnames(columbiaSel)
  #predIrrigation=predict(pca, newdata = edgesIrrigation)
  #hpts <- chull(predIrrigation)
  #hpts <- c(hpts, hpts[1])
  #polygon(predIrrigation[hpts, ],col=rgb(0.09,0.45,0.8,0.5))
  
  colnames(edgesDrink)=colnames(columbiaSel)
  predDrink=predict(pca, newdata = edgesDrink)
  hpts <- chull(predDrink)
  hpts <- c(hpts, hpts[1])
  polygon(predDrink[hpts, ],col=rgb(0.09,0.45,0.8,0.5))
  
  #wq polygon
  colnames(edgesAquatic)=colnames(columbiaSel)
  
  predAquatic=predict(pca, newdata = edgesAquatic)
  hpts <- chull(predAquatic)
  hpts <- c(hpts, hpts[1])
  polygon(predAquatic[hpts, ],col=rgb(0.70,0.13,0.13,0.5))
  
  
  
  points(scores(pca,display = "sites"),pch=16,cex=0.8)
  
  # plot species (red cross OR text)
  #points(scores(pca,c(1,2),display="species",scaling=sc),pch=3,cex=0.8,lwd=2,col="red")
  m=12
  text(scores(pca,display = "species")*m,labels=rownames(scores(pca,display = "species")),col="red")
  
  envfit=vegan::envfit(pca, data.matrix(columbiaAll_diff), perm = 999)
  #plot(envfit)
  envFit_ar=envfit$vectors$arrows
  
  # plot selected variables
  m=10
  arrows(0,0,envFit_ar[,1]*m,envFit_ar[,2]*m,length=0.1,lwd=2)
  text(envFit_ar[,1:2]*m,labels=rownames(envFit_ar),cex=0.8)
}
ReporteRsWrap(plotPCA,"PCA")


sc=scores(pca,display="sites")
which.max(sc[,1])

columbiaAll_wide[278,]

library(reshape2)
m = WP[,c("ResultMeasureValue","CharacteristicName","ActivityIdentifier")]
jj_melt <- melt(m, id=c("ActivityIdentifier"))
jj_spread <- dcast(jj_melt, ActivityIdentifier ~ student + variable, value.var="value", fun=sum)

