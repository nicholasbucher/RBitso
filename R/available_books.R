
available_books<-function(){
  url<-paste0("https://api.bitso.com/v3/available_books/")
  tmp <- tempfile()
  res<-GET(url, write_disk(tmp))
  cat(noquote(paste("Success:", content(res)$success,"\n\n")))
  if(content(res)$success== TRUE){
    return(suppressWarnings(fromJSON(readLines(tmp)))$payload)
  }
}