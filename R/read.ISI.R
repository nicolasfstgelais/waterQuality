library(dplyr)
library(tidytext)

read.ISI<-function(folder){
  files=list.files(folder)
  refs=NULL
  for(j in 1:length(files)){
    file=readLines(paste0(folder,"/",files[j]))
    coln=strsplit(file[1],"\t")[[1]]
    for(i in 2:length(file)){
      if(exists("refs"))refs=rbind(refs,unlist(strsplit(file[i],"\t")))
      if(!exists("refs"))refs=unlist(strsplit(file[i],"\t"))
      
    }
  }
  refs=as.data.frame(refs,stringsAsFactors = F)
  colnames(refs)=coln
  return(refs)
}

AbsKwCounter<-function(folder){
# script to import reference from ISI in windows UTF8 format
refs=read.ISI(folder)

abstracts=data_frame(abs=refs$AB)

# terms not to search for
data(stop_words)# import stop words
# set word that should not be searched for
rem_words=dplyr::data_frame(word=unlist(read.csv("data/sciStopWords.csv",header=F,stringsAsFactors = F)),lexicon="personal")
#add  normal  stop words 
stop_words=bind_rows(rem_words,stop_words, .id = NULL)
#for this project remove water and quality, because not relevant
stop_words=bind_rows(data_frame(word=c("water","quality")),stop_words, .id = NULL)

# tidy text and remove stop words
tidy_text <- abstracts %>%
  unnest_tokens(word, abs) %>%
  anti_join(stop_words)

counts_text<-tidy_text %>%
  count(word, sort = TRUE)

return(counts_text)
}









