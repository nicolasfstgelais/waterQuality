
limnoVar=c("alkalinity","chla","dic","do","doc","nitrate","nitrite","tn","tp")

Y=sitesClass[!is.na(sitesClass[,"recreational"]),"recreational",drop=F]
Y[,1]=as.factor(Y[,1])

db_wide_ym_rec=db_wide_ym[rownames(Y),limnoVar]
db_wide_ym_rec=db_wide_ym_rec[rowSums(is.na(db_wide_ym_rec))<ncol(db_wide_ym_rec),]

db_wide_ym_rec.miss=missForest::missForest(db_wide_ym_rec,ntree = 20,maxiter = 2)

db_wide_ym_rec.error=db_wide_ym_rec.miss$OOBerror
db_wide_ym_rec.miss=db_wide_ym_rec.miss$ximp


rfDat=data.frame(Y=Y[rownames(db_wide_ym_rec.miss),],log10(db_wide_ym_rec.miss))
rfDat$Y=as.factor(rfDat$Y)


rf=randomForest::randomForest(Y~.,data=rfDat)

randomForest::varImpPlot(rf)
