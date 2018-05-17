# This function calculates the proportion of guidelines by chemical groups for each ES. Output is a table 
critByGroup<-function(chemGroups,ES){
  polCat=matrix(0,length(unique(ES)),length(unique(chemGroups)),dimnames=list(unique(ES),unique(chemGroups)))
  for(i in unique(ES)){
    for(j in unique(chemGroups)){
      polCat[i,j]=length(ES[ES%in%i&chemGroups%in%j])/length(chemGroups[ES%in%i])
    } }
  return(polCat)
}