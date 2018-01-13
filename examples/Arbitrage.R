

# Minimal Version of Abrtitrage

HARV<-NULL
ARV<-function(){
  
  # Bitso abre seis caminos diferentes para hacer arbitraje
  
  A1<-rate("btc","mxn")*rate("mxn","xrp")* rate("xrp","btc")
  A2<-rate("btc","mxn")*rate("mxn","eth")* rate("eth","btc")
  A3<-rate("btc","xrp")*rate("xrp","mxn")* rate("mxn","btc")
  A4<-rate("btc","eth")*rate("eth","mxn")* rate("mxn","btc")
  
  A5<-rate("btc","eth")*rate("eth","mxn")* rate("mxn","xrp")*rate("xrp","btc")
  A6<-rate("btc","xrp")*rate("xrp","mxn")* rate("mxn","eth")*rate("eth","btc")
  
  return(c(A1,A2,A3,A4,A5,A6))
}
full_ticker<-function(){
tick<-NULL
for(i in 1:length(Books$book)){
  tick<-rbind(tick,(ticker(Books$book[i])))
}


return(tick)

}
rate<-function(mayor,minor,real=TRUE){
  
  book_number<-match(TRUE,grepl(minor, tickers$book) & grepl(mayor, tickers$book))
  
  book_ticker<-tickers[book_number,]
  
  if(substr(book_ticker$book,1,3)==mayor){
    rate<-book_ticker$bid
  }
  else if(substr(book_ticker$book,5,8)==mayor){
    rate<-1/(book_ticker$ask)
  }
  else{return(0)}
  if(real==TRUE){
    rate<-rate*(1-fees$fee_decimal[book_number])
  }
  return(rate)
}


Books<-get_books()
tickers<-full_ticker()
fees<-trade_fees()

for(i in 1:100){
  
  tickers<-full_ticker()
  HARV<-rbind(HARV,ARV())
  Sys.sleep(1)
  
}

beep("coin")
matplot(HARV,type='l')

max(HARV)

# 0.9936738

# Order Tickers --------------------------------------------

# El precio de venta (ask) siempre es mayor que el precio de compra (bid).
# La diferencia se conoce como spread.

# Dado ésto, la compraventa circular genera pérdidas en relación al tamaño de dicho spread.
# Adicionandole a ésta pérdida, las comisiones de la plataforma por hacer el intercambio.


# ----------------------------------------------------------------------






