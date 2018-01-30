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
    R<-suppressWarnings(jsonlite::fromJSON(readLines(tmp)))$payload
    R<-transform(R,
                 minimum_price=as.numeric(minimum_price),
                 maximum_price=as.numeric(maximum_price),
                 minimum_amount=as.numeric(minimum_amount),
                 maximum_amount=as.numeric(maximum_amount),
                 minimum_value=as.numeric(minimum_value),
                 maximum_value=as.numeric(maximum_value)
    )
    return(R)
  }
}
