#' Fundings
#'
#' This Function Returns Funding History. 
#' @param fid, Character, funding Id (optional).
#' @param limit, Numeric, history limit (optional).
#' @keywords funding
#' @export
#' @examples
#' fundings(limit=5)

fundings<-function(fid,limit){
  
  url<-"https://api.bitso.com/v3/fundings/"
  NC<-NONCE()
  mthd<-"GET"
  Pyld<-""
  
  if(!missing(limit) & !missing(fid)){
    cat("Limit or Funding Id's, not both.")
    return(NULL)
  }
  else if(missing(limit) & !missing(fid)){
    fid<-paste0(paste(fid,collapse="-"),"/")
    url<-paste0(url,fid)
  }
  else if(missing(fid) & !missing(limit)){
    url<-paste0(url,"?limit=",limit)
  }
  
  Pth<-substr(url,22,nchar(url))
  
  hdr<-paste0("Bitso ",ky,":",NC,":",openssl::sha256(paste0(NC,mthd,Pth,Pyld),scrt))
  tmp <- tempfile()
  res<-httr::GET(url, httr::add_headers(Authorization=hdr), httr::write_disk(tmp))
  cat(noquote(paste("Success:", httr:content(res)$success,"\n\n")))
  if(httr::content(res)$success== TRUE){
    return(suppressWarnings(jsonlite::fromJSON(readLines(tmp)))$payload)
  }
} 