#' Balance
#'
#' This Function Returns Account Balance. 
#' @keywords balance
#' @export
#' @examples
#' balance()

balance<-function(){
  NC<-NONCE()
  mthd<-"GET"
  Pyld<-""
  url<-"https://api.bitso.com/v3/balance/"
  Pth<-"/v3/balance/"
  hdr<-paste0("Bitso ",ky,":",NC,":",openssl::sha256(paste0(NC,mthd,Pth,Pyld),scrt))
  tmp <- tempfile()
  res<-httr::GET(url, httr::add_headers(Authorization=hdr), httr::write_disk(tmp))
  cat(noquote(paste("Success:", httr::content(res)$success,"\n\n")))
  if(httr::content(res)$success== TRUE){
    R<-suppressWarnings(jsonlite::fromJSON(readLines(tmp)))$payload$balances
    R<-transform(R,available=as.numeric(available),
                 locked=as.numeric(locked),
                 total=as.numeric(total),
                 pending_deposit=as.numeric(pending_deposit),
                 pending_withdrawal=as.numeric(pending_withdrawal))
    return(R)
  }
} 
