#' Withdrawals
#'
#' User's Withdrawaling History.
#' @param wid, character, withdrawal identification number
#' @param limit, numeric, number of entries to display
#' @keywords withdrawals
#' @export
#' @examples
#' withdrawals()

withdrawals<-function(wid,limit){
  
  url<-"https://api.bitso.com/v3/withdrawals/"
  NC<-NONCE()
  mthd<-"GET"
  Pyld<-""
  
  if(!missing(limit) & !missing(wid)){
    cat("Limit or Withdrawal Id's, not both.")
    return(NULL)
  }
  else if(missing(limit) & !missing(wid)){
    wid<-paste0(paste(wid,collapse="-"),"/")
    url<-paste0(url,wid)
  }
  else if(missing(wid) & !missing(limit)){
    url<-paste0(url,"?limit=",limit)
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