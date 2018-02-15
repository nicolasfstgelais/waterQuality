
dbWP=read.csv("C:/Users/nicol/Dropbox/ReseauLab/data/water quality/waterportal/rivers/result.csv",stringsAsFactors = F)

unique(dbWP$ResultDetectionConditionText)

# when under detection limit = detection limit/2
dbWP[dbWP$ResultDetectionConditionText=="Not Detected","ResultMeasureValue"]=LtoN(dbWP[dbWP$ResultDetectionConditionText=="Not Detected","DetectionQuantitationLimitMeasure.MeasureValue"])/2
dbWP[dbWP$ResultDetectionConditionText==  "Below Reporting Limit","ResultMeasureValue"]=LtoN(dbWP[dbWP$ResultDetectionConditionText=="Not Detected","DetectionQuantitationLimitMeasure.MeasureValue"])/2


# remove results with NA

dbWP=dbWP[!is.na(dbWP$ResultMeasureValue) ,]

dbWP$CharacteristicName_ResultSampleFractionText=paste(dbWP$CharacteristicName,dbWP$ResultSampleFractionText,sep="_")

write.csv(dbWP,"C:/Users/nicol/Dropbox/ReseauLab/data/water quality/waterportal/rivers/result_mod.csv")
)