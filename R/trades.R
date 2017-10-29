#' Trades
#'
#' Public Book Trading History.
#' @param book, character
#' @param aggregated, boolean
#' @keywords fees
#' @export
#' @examples
#' trades("btc_mxn")

trades<-function(book,aggregated){
    if(! missing(aggregated)){
      url<-paste0("https://api.bitso.com/v3/trades/?book=",book,"&aggregate=",aggregated)
    }
  
  url<-paste0("https://api.bitso.com/v3/trades/?book=",book)
  tmp <- tempfile()
  res<-httr::GET(url, httr::write_disk(tmp))
  cat(noquote(paste("Success:", httr::content(res)$success,"\n\n")))
  if(httr::content(res)$success== TRUE){
    R<-suppressWarnings(jsonlite::fromJSON(readLines(tmp)))$payload
    R<-transform(R,
                 created_at=time_parse(created_at),
                 amount=as.numeric(amount),
                 price=as.numeric(price)
    )
    return(R)
  }
}