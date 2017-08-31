#' Get Books
#'
#' This Function Returns Available Books.
#' @keywords books
#' @export
#' @examples
#' get_books()

get_books<-function(){
  url<-paste0("https://api.bitso.com/v3/available_books/")
  tmp <- tempfile()
  res<-httr::GET(url, httr::write_disk(tmp))
  cat(noquote(paste("Success:", httr::content(res)$success,"\n\n")))
  if(httr::content(res)$success== TRUE){
    return(suppressWarnings(jsonlite::fromJSON(readLines(tmp)))$payload)
  }
}