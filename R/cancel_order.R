#' Cancel Order
#'
#' This Function Deletes Specified Order. 
#' @param oid, Character with order Id.
#' @keywords cancel
#' @export
#' @examples
#' cancel_order("001Hg2risFrBul2J4G")

cancel_order<-function(oid){
  
  url<-"https://api.bitso.com/v3/orders/"
  NC<-NONCE()
  mthd<-"DELETE"
  Pyld<-""
  oid<-paste0(paste(oid,collapse="-"),"/")
  url<-paste0(url,oid)
  Pth<-substr(url,22,nchar(url))
  hdr<-paste0("Bitso ",ky,":",NC,":",sha256(paste0(NC,mthd,Pth,Pyld),scrt))
  tmp <- tempfile()
  res<-httr::DELETE(url, httr::add_headers(Authorization=hdr), httr::write_disk(tmp))
  cat(noquote(paste("Success:", httr::content(res)$success,"\n\n")))
  if(httr::content(res)$success== TRUE){
    return(suppressWarnings(jsonlite::fromJSON(readLines(tmp)))$payload)
  }
}