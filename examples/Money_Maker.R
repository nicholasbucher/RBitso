# Money Maker

library(RBitso)

# Preliminar --------------------------------------------------------------

# La meta es producir un bot que trabaje en el servidor 104.131.137.16 para checar constantemente el precio del 
# bitcoin en Bitso y realize compra-venta a mi convenecia.

# Antes de poder implementar un sistema así, es indispensable realizar algunas pruebas para conocer si es 
# posible producir dicho programa, reconocer indicadores de compra-venta, observar margenes de tendencia etc.

# 1. Correr código desde la consola R < Money_Maker.R --no-save
# 2. Guardar precios por hora en csv

setwd("Test")
Today<-Today<-gsub("-","_",Sys.Date())
if(is.na(match(Today,system("ls",intern=TRUE)))){
  dir.create(Today)
}

Ticker<-NULL
while(1){
  Time<-substr(Sys.time(),12,20)
  Ticker<-rbind(Ticker,ticker("btc_mxn"))  
  dim<-dim(Ticker)[1]
  if(dim>3600){
    Ticker<-Ticker[(dim-3600):dim,]
  }
  if(substr(Time,4,8)=="00:00"){
    write.csv(Ticker, paste0(Today,"/",Time,".csv")) 
  }
  Sys.sleep(1)
}









