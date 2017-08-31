order<-function(book,side,major,price,type){
  NC<-NONCE()
  mthd<-"POST"
  Pyld <- gsub("\\[|\\]", "", toJSON(data.frame(book=book,side=side,major=major,price=price,type=type)))
  url<-"https://api.bitso.com/v3/orders/"
  Pth<-"/v3/orders/"
  hdr<-paste0("Bitso ",ky,":",NC,":",sha256(paste0(NC,mthd,Pth,Pyld),scrt))
  tmp <- tempfile()
  r<-POST(url, body = list(book=book,side=side,major=major,price=price,type=type), add_headers(Authorization=hdr),encode="json", write_disk(tmp))
  cat(noquote(paste("Success:", content(res)$success,"\n\n")))
  if(content(res)$success== TRUE){
    return(suppressWarnings(fromJSON(readLines(tmp)))$payload)
  }
}