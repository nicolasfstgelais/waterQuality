# This function uses the ES space DB to calculate the emperical overlap between ecosystem services in canadian rivers.

overlapES<-function(sitesClass,rd=2)
{
  incMatrix=matrix(NA,ncol(sitesClass),ncol(sitesClass),dimnames=list(colnames(sitesClass),colnames(sitesClass)))
  for(i in colnames(incMatrix)){
    for(j in colnames(incMatrix)){
      if(i==j){incMatrix[i,j]=round(sum(sitesClass[,i],na.rm = T)/nrow(sitesClass[!is.na(sitesClass[,i]),]),rd)}  else{
        subM=sitesClass[sitesClass[,i]==1&!is.na(sitesClass[,i]),]
        incMatrix[i,j]=round(sum(subM[,j],na.rm = T)/nrow( subM[!is.na(subM[,j]),]),rd)}
    }}
  return(incMatrix)
}