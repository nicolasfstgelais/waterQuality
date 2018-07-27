

compAbs<-function(file1,file2)
{
  abs=plyr::join(AbsKwCounter(file1),AbsKwCounter(file2),by = c("word"))
  colnames(abs)=c("word","n2000","n2017")
  abs$prop2000=abs$n2000/length(which(!is.na(abs$n2000)))
  abs$prop2017=abs$n2017/length(which(!is.na(abs$n2017)))
  abs$propInc=(abs$prop2017-abs$prop2000)/abs$prop2000
  return(abs)
}


Abs=compAbs("data/ISI/WQ_2000_Eco","data/ISI/WQ_2017_Eco")
  