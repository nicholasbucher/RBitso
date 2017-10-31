Books<-get_books()
books<-Books[,1]

# Tickers --------------------------------------------------

full_ticker<-fucntion(){
tick<-NULL
for(i in 1:length(books)){
  tick<-rbind(tick,(ticker(books[i])))
}

tick$high<-NULL
tick$last<-NULL
tick$created_at<-NULL
tick$volume<-NULL
tick$vwap<-NULL
tick$low<-NULL

return(tick)

}

fees<-trade_fees()
fees$fee_percent<-NULL


# Order Tickers --------------------------------------------
# El precio de venta (ask) siempre es mayor que el precio de compra (bid).
# La diferencia se conoce como spread.

# Dado ésto, la compraventa circular genera pérdidas en relación al tamaño de dicho spread.

# tick$ask^(-1)*tick$bid
# 0.9963272 0.9787956 0.9708824 0.9872449 0.9560312 0.9139866

# ----------------------------------------------------------------------

# Queremos crear una especie de matriz de arbitraje

arbit_mat<-function(Tick,fees){
  
  # Bitso abre cuatro caminos diferentes para hacer arbitraje
  
  #  btc -> mxn  -> xrp -> btc
  #  btc -> mxn  -> eth -> btc
  #  btc -> xrp  -> mxn -> btc
  #  btc -> eth  -> mxn -> btc
  
  
}

get_convertion<-function(tick,may,min){
  grepl("mxn", books) & grepl("btc", books)
  
}


