#' Bids
#'
#' This Function Returns Active Bids. 
#' @param book, Character
#' @param aggregated, Boolean
#' @keywords bids
#' @export
#' @examples
#' bids()

bids<-function(book,aggregated){
  if(! missing(aggregated)){
    url<-paste0("https://api.bitso.com/v3/order_book/?book=",book,"&aggregate=",aggregated)
  }
  else{
    url<-paste0("https://api.bitso.com/v3/order_book/?book=",book)
  }
  tmp <- tempfile()
  res<-httr::GET(url, httr::write_disk(tmp))
  cat(noquote(paste("Success:", httr::content(res)$success,"\n\n")))
  if(httr::content(res)$success== TRUE){
    R<-suppressWarnings(jsonlite::fromJSON(readLines(tmp)))$payload$bids
    R<-transform(R,
                 price=as.numeric(price),
                 amount=as.numeric(amount))
    
    return(R)
  }
  
} 