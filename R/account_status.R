#' Account Status
#'
#' This Function Returns Account Status. 
#' @keywords status
#' @export
#' @examples
#' account_status()

account_status<-function(){
  NC<-NONCE()
  mthd<-"GET"
  Pyld<-""
  url<-"https://api.bitso.com/v3/account_status/"
  Pth<-"/v3/account_status/"
  hdr<-paste0("Bitso ",ky,":",NC,":",openssl::sha256(paste0(NC,mthd,Pth,Pyld),scrt))
  tmp <- tempfile()
  res<-httr::GET(url, httr::add_headers(Authorization=hdr), httr::write_disk(tmp))
  cat(noquote(paste("Success:", httr::content(res)$success,"\n\n")))
  if(httr::content(res)$success== TRUE){
    res<-data.frame(suppressWarnings(jsonlite::fromJSON(readLines(tmp))$payload), stringsAsFactors=FALSE)
    return(res)
  }
}