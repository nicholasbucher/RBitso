#' Asks
#'
#' This Function Returns Active Ask Orders.
#' @param book As String
#' @seealso \code{\link{get_books}}  
#' @keywords asks
#' @export
#' @examples
#' asks("btc_mxn",TRUE)

asks<-function(book,aggregated){
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
    R<-suppressWarnings(jsonlite::fromJSON(readLines(tmp)))$payload$asks
    R<-transform(R,
                 price=as.numeric(price),
                 amount=as.numeric(amount))
                   
    return(R)
  }
  
} 