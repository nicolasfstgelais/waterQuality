source("R/functions.R")

extract.dim<-function(sel){
  dat=read.csv(sprintf("data/dimensions_%s.csv",sel),stringsAsFactors = F,skip = 3)
  dat=as.numeric(dat[seq(1,nrow(dat),by = 3),])
  names(dat)=seq(2017,1980,-1)
  return(dat)}

dat_wq=extract.dim("wq")
dat_wq_abs=extract.dim("wq_abs")

dat_gen=extract.dim("gen")
#dat_cc=extract.dim("cc")
#dat_cc_eco=extract.dim("cc_eco")
dat_wq_eco=extract.dim("wq_eco")
dat_wq_eco_abs=extract.dim("wq_eco_abs")
dat_eco=extract.dim("eco")
dat_wq_hlth=extract.dim("wq_hlth")
dat_wq_hlth_abs=extract.dim("wq_hlth_abs")
dat_hlth=extract.dim("hlth")
dat_wq_env=extract.dim("wq_env")
dat_env=extract.dim("env")
dat_wq_eng=extract.dim("wq_eng")
dat_eng=extract.dim("eng")
dat_wq_irr=extract.dim("wq_irr")

plot.trends<-function(){
#wq in general
x=scale(dat_wq_abs/dat_gen)
y=as.numeric(names(dat_wq))
plot(x~y,pch=16,ylim=c(-2,2),col=scales::alpha("#73BAE6", 0.4),ylab="Z-score",xlab="Years")
lin.mod <- lm(x~y)
#abline(lin.mod,lwd=2)
segmented.mod <- segmented::segmented(lin.mod, seg.Z = ~y)
plot(segmented.mod, add=T,lwd=2,ylim=c(-2,2),col="#73BAE6",xlab="Years",ylab="Z-score")
AIC(segmented.mod)
AIC(lin.mod)
#segmented::pscore.test(segmented.mod,~y)


# wq in env
x=scale(dat_wq_env/dat_env)
y=as.numeric(names(dat_wq_env))
points(x~y,pch=16,col=scales::alpha("#FFD700",0.4))
lin.mod <- lm(x~y)
segmented.mod <- segmented::segmented(lin.mod, seg.Z = ~y)
plot(segmented.mod, add=T,lwd=2,col="#FFD700")
AIC(segmented.mod)
AIC(lin.mod)
#segmented::pscore.test(segmented.mod,~y)

# wq in eng
#x=scale(dat_wq_eng/dat_eng)
#y=as.numeric(names(dat_wq_eco))
#points(x~y,pch=16,col=scales::alpha("#FFD700")
#lin.mod <- lm(x~y)
#abline(lin.mod,lwd=2,col="#FFD700")
#segmented.mod <- segmented::segmented(lin.mod, seg.Z = ~y)
#plot(segmented.mod, add=T,lwd=2)
#AIC(segmented.mod)
#AIC(lin.mod)
#segmented::pscore.test(segmented.mod,~y)

# wq in ecology
x=scale(dat_wq_eco_abs/dat_eco)
y=as.numeric(names(dat_wq_eco))
points(x~y,pch=16,col=scales::alpha("#33a02c",0.4))
lin.mod <- lm(x~y)
abline(lin.mod,lwd=2,col="#33a02c")
segmented.mod <- segmented::segmented(lin.mod, seg.Z = ~y,col="#33a02c")
#plot(segmented.mod, add=T,lwd=2)
AIC(segmented.mod)
AIC(lin.mod)
#segmented::pscore.test(segmented.mod,~y)



# wq in hlth
x=scale(dat_wq_hlth/dat_hlth)
y=as.numeric(names(dat_wq_eco))
points(x~y,pch=16,col=scales::alpha("#C742B5",0.4))
lin.mod <- lm(x~y)
#abline(lin.mod,lwd=2,col="#C742B5")
segmented.mod <- segmented::segmented(lin.mod, seg.Z = ~y)
plot(segmented.mod, add=T,lwd=2,col="#C742B5")
AIC(segmented.mod)
AIC(lin.mod)
#segmented::pscore.test(segmented.mod,~y)

legend("topleft", legend = c("General","Environment and Management","Ecology","Public Health"), bty = "n",lty=1,lwd=4 , col=c("#73BAE6","#FFD700","#33a02c","#C742B5") , text.col = "grey32", cex=1, pt.cex=1)

}

#ReporteRsWrap(plot.trends,"trends")


