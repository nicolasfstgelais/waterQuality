
load("data/dataCDN.RData")
source("R/functions.R")

sel3=grep("BC08KE0010",x = rownames(db_wide_ym))

db_sel=db_wide_ym[sel3,]
db_sel=db_sel[,colSums(is.na(db_sel)) != nrow(db_sel)]

imp=missForest::missForest(db_sel)
db_sel.imp=imp$ximp

# inpute guidelines
guideSel=guide[guide$Limit=="upper",]

guide_wide<- tidyr::spread(data = guideSel[,c("Category","Pollutant","Concentration","Limit")], 
                           key = Category,
                           value = Concentration)

rownames(guide_wide)=tolower(guide_wide$Pollutant);guide_wide=guide_wide[,-c(1,2)]


guide_wide_sel=guide_wide[colnames(db_sel),]

guide_wide_sel=guide_wide_sel[,colSums(is.na(guide_wide_sel)) != nrow(guide_wide_sel)]


sel=grep(("QU02OB9004"),x = rownames(db_wide))
db_wide_sel=db_wide[,]

CDN_wide_sel=CDN_wide[selVar,c(realSpace,modSpace)]

sel=grep(("QU02OB9004"),x = rownames(db_wide))
db_wide_sel=db_wide[,]



impDB=rbind(db_sel,matrix(NA,length(modSpace),ncol(db_wide_sel),dimnames=list(modSpace,colnames(db_wide_sel))))
impDB[modSpace,]=t(CDN_wide_sel[colnames(impDB),modSpace])
impDB=(missForest::missForest(impDB))$ximp

impDB=rbind(db_sel.imp[,rownames(guide_wide_sel)],t(guide_wide_sel))
impDB=(missForest::missForest(data.matrix(impDB)))$ximp


guide_imp=t(impDB[colnames(guide_wide_sel),rownames(guide_wide_sel)])
guide_imp=t(impDB[colnames(guide_wide_sel),rownames(guide_wide_sel)])


axes=c(1,2)
sc=2
pca=prcomp(db_sel.imp,center = TRUE,scale. = TRUE)
plot(vegan::scores(pca,display = "sites",choices =axes),type="n",main=main)

col2rgb("darkgoldenrod2")/255
selSSP=c("aquatic","mesotrophic","oligotrophic")
myCols=c(rgb(0.09,0.45,0.8,0.35),rgb(0.70,0.13,0.13,0.35),rgb(0.4,0.8,0,0.35),rgb(0.93,0.678,0.54,0.35))
names(myCols)=selSSP

#plot(-1000:1000,-1000:1000,type="n")

samp=list()
for(i in colnames(guide_imp)){
  samp[[i]]=apply(guide_imp[,i,drop=F],1,guide.samp)
}

for(j in 1:length(selSSP)){
  pred=predict(pca, newdata = samp[[selSSP[j]]])
  hpts <- chull(pred)
  hpts <- c(hpts, hpts[1])
  polygon(pred[hpts, ],col=myCols[j])
}
}