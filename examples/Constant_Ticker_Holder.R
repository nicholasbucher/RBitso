# Constant Ticker Holder

library(RBitso)

# Preliminar --------------------------------------------------------------

setwd("Test")
Sys.setenv(TZ = "America/Mexico_City")
Today<-gsub("-","_",Sys.Date())
if(is.na(match(Today,system("ls",intern=TRUE)))){
  dir.create(Today)
}
setwd(Today)
STime<-Sys.time()

# Program -----------------------------------------------------------------
HY<-ticker("btc_mxn")

while(1){
  CTime<-Sys.time()
  try(Ticker<-ticker("btc_mxn"))
  if(substr(STime,12,13)!=substr(CTime,12,13)){
    STime<-CTime
    write.csv(HY,file=paste0(substr(CTime,12,19),".csv"))
    HY<-Ticker
    if(gsub("-","_",Sys.Date())!=Today){
      Today<-gsub("-","_",Sys.Date())
      setwd("..")
      dir.create(Today)
      setwd(Today)
    }
  }
  if(sum(Ticker==tail(HY,n=1))<8){
    HY<-rbind(HY,Ticker)
  }
  Sys.sleep(1)
}

