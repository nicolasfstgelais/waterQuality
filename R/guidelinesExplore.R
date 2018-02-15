CDN=read.csv("CDN_guidelines.csv",stringsAsFactors=FALSE)
CDN$Pollutant=tolower(CDN$Pollutant)

polCat=matrix(0,length(unique(CDN$SuperCategory)),length(unique(CDN$Chemical.groups)),dimnames=list(unique(CDN$SuperCategory),unique(CDN$Chemical.groups)))

for(i in unique(CDN$SuperCategory)){
  for(j in unique(CDN$Chemical.groups)){
    polCat[i,j]=nrow(CDN[CDN$SuperCategory%in%i&CDN$Chemical.groups%in%j,])/nrow(CDN[CDN$SuperCategory%in%i,])
} }


library(plotrix)

ppi=300
png("figures/polCat.png",width=8*ppi, height=8*ppi,bg="transparent",res=ppi)
par(mar = c(0.5, 6, 12, 0.5))
color2D.matplot(polCat,
                show.values = TRUE,
                axes = F,
                xlab = "",
                ylab = "",
                vcex = 1,
                vcol = "black",
                extremes = c("white", "red"))

axis(3, at = seq_len(ncol(polCat)) - 0.5,
     labels = colnames(polCat), tick = FALSE, cex.axis = 1,las=2)

axis(2, at = seq_len(nrow(polCat)) -0.5,
     labels = rev(rownames(polCat)), tick = FALSE, las = 1, cex.axis = 1)

dev.off()


sort(table(CDN$Pollutant[CDN$Chemical.groups=="Pesticide"]))
sort(table(CDN$Pollutant[CDN$Chemical.groups=="Metal"]))
sort(table(CDN$Pollutant[CDN$Chemical.groups=="Biological"]))
sort(table(CDN$Pollutant[CDN$Chemical.groups=="Inorganic chemical"]))
sort(table(CDN$Pollutant[CDN$Chemical.groups=="Organic chemical"]))

sort(table(CDN$Pollutant[CDN$Chemical.groups=="Physical"]))




