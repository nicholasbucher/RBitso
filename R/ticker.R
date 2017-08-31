#' Ticker
#'
#' Returns Detailed Book Ticker.
#' @param book, character
#' @keywords ticker,price,last,max,min,value,high,low
#' @export
#' @examples
#' ticker("btc_mxn")


ticker<-function(book){
  url<-paste0("https://api.bitso.com/v3/ticker/?book=",book)
  tmp <- tempfile()
  res<-httr::GET(url, httr::write_disk(tmp))
  cat(noquote(paste("Success:", httr::content(res)$success,"\n\n")))
  if(httr::content(res)$success== TRUE){
    R<-data.frame(suppressWarnings(jsonlite::fromJSON(readLines(tmp)))$payload,stringsAsFactors=FALSE)
    R<-transform(R,
                 high=as.numeric(high),
                 last=as.numeric(last),
                 volume=as.numeric(volume),
                 vwap=as.numeric(vwap),
                 low=as.numeric(low),
                 ask=as.numeric(ask),
                 bid=as.numeric(bid)
    )
    return(R)
  }
}
