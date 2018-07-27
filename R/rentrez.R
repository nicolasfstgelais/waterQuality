library(rentrez)
library(XML)
library(dplyr)
library(tidytext)

entrez_dbs() # list avaialble databases
entrez_db_searchable("pubmed")


r_search <- entrez_search(db="pubmed", term="(water[TIAB]) AND (quality[TIAB]) AND (2017[PDAT])",retmax=5000,use_history=F)

# divide the total number of publication in smaller groups 
splits=split(1:length(r_search$ids), cut(1:length(r_search$ids), 15))

# run for each group and paste together
for(i in 1:length(splits)){
  
  ids=r_search$ids[splits[[i]]]
  
  #voir(https://stackoverflow.com/questions/33519399/how-do-i-download-all-the-abstract-datas-from-the-pubmed-data-ncbi)
  # rentrez function to get the data from pubmed db
  fetch.pubmed <- entrez_fetch(db = "pubmed", id = ids,
                               rettype = "xml", parsed = T)
  
  
  
  if(!exists("journals")){journals = xpathApply(fetch.pubmed, '//PubmedArticle//Article//Journal', function(x)
    xmlValue(xmlChildren(x)$Title))}
  
  if(exists("journals")){
    temp = xpathApply(fetch.pubmed, '//PubmedArticle//Article//Journal', function(x) xmlValue(xmlChildren(x)$Title))
    journals=c(journals,temp)
  }
  
  if(!exists("abstracts")){abstracts = xpathApply(fetch.pubmed, '//PubmedArticle//Article', function(x)
    xmlValue(xmlChildren(x)$Abstract))}
  
  if(exists("abstracts")){
    temp = xpathApply(fetch.pubmed, '//PubmedArticle//Article', function(x) xmlValue(xmlChildren(x)$Abstract))
    abstracts=c(abstracts,temp)
  }
  print(i)
}

#abstracts=data_frame(abs=bib$ABSTRACT)
#journals=data_frame(title=bib$JOURNAL)