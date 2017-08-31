#' Orders
#'
#' Returns Open Order(s) Details.
#' @param oid, character: order identification number (optional)
#' @keywords orders,open
#' @export
#' @examples
#' orders()

orders<-function(oid){
  
  url<-"https://api.bitso.com/v3/orders/"
  NC<-NONCE()
  mthd<-"GET"
  Pyld<-""
  
  if(!missing(oid)){
    oid<-paste0(paste(oid,collapse="-"),"/")
    url<-paste0(url,oid)
  }
  Pth<-substr(url,22,nchar(url))
  hdr<-paste0("Bitso ",ky,":",NC,":",openssl::sha256(paste0(NC,mthd,Pth,Pyld),scrt))
  tmp <- tempfile()
  res<-httr::GET(url, httr::add_headers(Authorization=hdr), httr::write_disk(tmp))
  cat(noquote(paste("Success:", httr::content(res)$success,"\n\n")))
  if(httr::content(res)$success== TRUE){
    return(suppressWarnings(jsonlite::fromJSON(readLines(tmp)))$payload)
  }
}