# Full Acumulated Version of Arbitrage



Books<-get_books()

full_big_ticker<-function(){
  tick<-NULL
  for(i in 1:length(Books$book)){
    tick[[i]]<-big_ticker(Books$book[i])
  }
  names(tick)<-Books$book
  return(tick)
  
}

big_tickers<-full_big_ticker()

Volume_rate<-function(mayor,minor,volume,real=TRUE){
  
  book_number<-match(TRUE,grepl(minor, names(big_tickers)) & grepl(mayor, names(big_tickers)))
  book_ticker<-big_tickers[[book_number]]
  
  standard_book<-names(big_tickers[book_number])

  
  # All Cool Till this line ----------------
  
    
  if(substr(standard_book,1,3)==mayor){
    rate<-book_ticker$bid
  }
  else if(substr(standard_book,5,8)==mayor){
    rate<-1/(book_ticker$ask)
  }
  
  
  
  else{return(0)}
  if(real==TRUE){
    rate<-rate*(1-fees$fee_decimal[book_number])
  }
  
  
  return(rate)
}