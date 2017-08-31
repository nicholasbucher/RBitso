#' Trades
#'
#' Public Book Trading History.
#' @param book, character
#' @keywords fees
#' @export
#' @examples
#' trades("btc_mxn")

trades<-function(book){
  url<-paste0("https://api.bitso.com/v3/trades/?book=",book)
  tmp <- tempfile()
  res<-httr::GET(url, httr::write_disk(tmp))
  cat(noquote(paste("Success:", httr::content(res)$success,"\n\n")))
  if(httr::content(res)$success== TRUE){
    return(suppressWarnings(jsonlite::fromJSON(readLines(tmp)))$payload)
  }
}