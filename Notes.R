Books<-get_books()
books<-Books[,1]

# Tickers --------------------------------------------------
tick<-NULL
for(i in 1:length(books)){
  tick<-rbind(tick,(ticker(books[i])))
}

# Aislamos la informacion relevante del ticker

Tick<-cbind(tick$book,tick$ask,tick$bid)



# Order Tickers --------------------------------------------
# El precio de venta (ask) siempre es mayor que el precio de compra (bid).
# La diferencia se conoce como spread.

# Dado ésto, la compraventa circular genera pérdidas en relación al tamaño de dicho spread.

# tick$ask^(-1)*tick$bid
# 0.9963272 0.9787956 0.9708824 0.9872449 0.9560312 0.9139866

# ----------------------------------------------------------------------

# Queremos crear una especie de matriz de arbitraje



