#' Trade Fees
#'
#' User's Trading Fees.
#' @keywords fees
#' @export
#' @examples
#' trade_fees()


trade_fees<-function(){
  NC<-NONCE()
  mthd<-"GET"
  Pyld<-""
  url<-"https://api.bitso.com/v3/fees/"
  Pth<-"/v3/fees/"
  hdr<-paste0("Bitso ",ky,":",NC,":",openssl::sha256(paste0(NC,mthd,Pth,Pyld),scrt))
  tmp <- tempfile()
  res<-httr::GET(url, httr::add_headers(Authorization=hdr), httr::write_disk(tmp))
  cat(noquote(paste("Success:", httr::content(res)$success,"\n\n")))
  if(httr::content(res)$success== TRUE){
    res<-data.frame(suppressWarnings(jsonlite::fromJSON(readLines(tmp))$payload$fees), stringsAsFactors=FALSE)
    return(res)
  }
}