#' Open Orders
#'
#' Returns List of User's Open Orders for Specific Book. 
#' @param book, Character.
#' @keywords orders,open
#' @export
#' @examples
#' open_orders("btc_mxn")

open_orders<-function(book){
  
  url<-paste0("https://api.bitso.com/v3/open_orders?book=",book)
  NC<-NONCE()
  mthd<-"GET"
  Pyld<-""
  Pth<-substr(url,22,nchar(url))
  
  hdr<-paste0("Bitso ",ky,":",NC,":",openssl::sha256(paste0(NC,mthd,Pth,Pyld),scrt))
  tmp <- tempfile()
  res<-httr::GET(url, httr::add_headers(Authorization=hdr), httr::write_disk(tmp))
  cat(noquote(paste("Success:", httr::content(res)$success,"\n\n")))
  if(httr::content(res)$success== TRUE){
    R<-suppressWarnings(jsonlite::fromJSON(readLines(tmp)))$payload
    R<-transform(R,
                 original_value=as.numeric(original_value),
                 unfilled_amount=as.numeric(unfilled_amount),
                 original_amount=as.numeric(original_amount),
                 price=as.numeric(price)
                 )
      
    return(R)
  }
} 