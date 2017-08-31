#' Funding Destination
#'
#' This Function Returns currency Funding Destination. 
#' @param currency, Character
#' @keywords funding,destination
#' @export
#' @examples
#' funding_destination("mxn")

funding_destination<-function(currency){
  
  url<-paste0("https://api.bitso.com/v3/funding_destination/?fund_currency=",currency)
  NC<-NONCE()
  mthd<-"GET"
  Pyld<-""
  Pth<-substr(url,22,nchar(url))
  
  hdr<-paste0("Bitso ",ky,":",NC,":",openssl::sha256(paste0(NC,mthd,Pth,Pyld),scrt))
  tmp <- tempfile()
  res<-httr::GET(url, httr::add_headers(Authorization=hdr), httr::write_disk(tmp))
  cat(noquote(paste("Success:", httr::content(res)$success,"\n\n")))
  if(httr::content(res)$success== TRUE){
    return(data.frame(suppressWarnings(jsonlite::fromJSON(readLines(tmp)))$payload))
  }
}