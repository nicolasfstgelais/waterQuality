
vennCat=list()

sitesClass_sub=sitesClass[rowSums(is.na(sitesClass[,c("aquatic","recreational","oligotrophic","mesotrophic")])) == 0,]



vennCat[["aquatic"]]=(1:nrow(sitesClass_sub))[sitesClass_sub[,"aquatic"]==1&!is.na(sitesClass_sub[,"aquatic"])]
vennCat[["recreational"]]=(1:nrow(sitesClass_sub))[sitesClass_sub[,"recreational"]==1&!is.na(sitesClass_sub[,"recreational"])]
vennCat[["oligotrophic"]]=(1:nrow(sitesClass_sub))[sitesClass_sub[,"oligotrophic"]==1&!is.na(sitesClass_sub[,"oligotrophic"])]
vennCat[["mesotrophic"]]=(1:nrow(sitesClass_sub))[sitesClass_sub[,"mesotrophic"]==1&!is.na(sitesClass_sub[,"mesotrophic"])]
vennCat[["eutrophic"]]=(1:nrow(sitesClass_sub))[sitesClass_sub[,"eutrophic"]==1&!is.na(sitesClass_sub[,"eutrophic"])]


grid::grid.draw(VennDiagram::venn.diagram(vennCat, NULL,print.mode = "percent"))

vennInter=list()

vennInter[["aquatic"]]=(1:nrow(sitesClass))[!is.na(sitesClass[,"aquatic"])]
vennInter[["swim"]]=(1:nrow(sitesClass))[!is.na(sitesClass[,"swim"])]
vennInter[["oligotrophic"]]=(1:nrow(sitesClass))[!is.na(sitesClass[,"oligotrophic"])]

grid.draw(VennDiagram::venn.diagram(vennInter, NULL,print.mode = "percent"))
venn.diagram

plotVenn<- function(){
  
}
ReporteRsWrap(plotVenn,"Venn")
