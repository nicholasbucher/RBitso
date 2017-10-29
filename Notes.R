Books<-get_books()
books<-Books[,1]

# Tickers --------------------------------------------------
tick<-NULL
for(i in 1:length(books)){
  tick<-rbind(tick,(ticker(books[i])))
}



# Order Tickers --------------------------------------------
# El precio de venta (ask) siempre es mayor que el precio de compra (bid).
# La diferencia se conoce como spread.

