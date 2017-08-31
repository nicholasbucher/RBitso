#' User Trades
#'
#' User's Book Trading History.
#' @keywords fees
#' @export
#' @examples
#' user_trades("btc_mxn")

user_trades<-function(book){
  
  url<-paste0("https://api.bitso.com/v3/user_trades/?book=",book)
  NC<-NONCE()
  mthd<-"GET"
  Pyld<-""
  Pth<-substr(url,22,nchar(url))
  
  hdr<-paste0("Bitso ",ky,":",NC,":",openssl::sha256(paste0(NC,mthd,Pth,Pyld),scrt))
  tmp <- tempfile()
  res<-httr::GET(url, httr::add_headers(Authorization=hdr), httr::write_disk(tmp))
  cat(noquote(paste("Success:", httr::content(res)$success,"\n\n")))
  if(httr:content(res)$success== TRUE){
    return(suppressWarnings(jsonlite::fromJSON(readLines(tmp)))$payload)
  }
}