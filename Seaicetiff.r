#Function for downloading geotiff images with daily sea ice concentration relative to a month from 
#Sea Ice Concentrations from Nimbus-7 SMMR and DMSP SSM/I-SSMIS Passive Microwave Data, Version 1
#user name and password for Earthdata are nedeed to use the function
#Arguments: year, month (month must be indicated as in the example : Jenuary--> "01_Jan",February --> "02_Feb")

Seaice_tiff<-function(x,y){
  library(RCurl)
  library(rvest)
  library(xml2)
  library(httr)
  library(stringr)
  library(dplyr)
  library(curl)
  
  #builtUrls
  my.year<-as.character(x)
  my.month<-y
  
  
  url <- "ftp://sidads.colorado.edu/DATASETS/NOAA/G02135/north/daily/geotiff/"
  userpwd <- "USER:PASSWORD"
  filenames <- getURL(url, userpwd = userpwd,
                      ftp.use.epsv = FALSE,dirlistonly = TRUE) 
  
  
  url2 <- paste0('ftp://sidads.colorado.edu/DATASETS/NOAA/G02135/north/daily/geotiff/',my.year,'/')
  
  url3 <- paste0(url2,my.month,'/')
  
  #download files
  
  user<-"USER"
  passwd<-"PASSWORD"
  auth <- httr::authenticate(user, passwd)
  req <- httr::GET(url3, auth)
  h = new_handle(dirlistonly=TRUE)
  con = curl(url3, "r", h)
  tbl = read.table(con, stringsAsFactors=TRUE, fill=TRUE)
  close(con)
  #head(tbl)
  newtbl<- tbl %>%
    filter(str_detect(V1, "conc"))
  
  my.filenames<-as.character(newtbl$V1)
  
  for (filename in my.filenames) {
    download.file(paste(url3, filename, sep = ""), paste(getwd(), "/", filename,
                                                        sep = ""),mode="wb")
  }
  
}
