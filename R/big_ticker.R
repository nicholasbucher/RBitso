#' Big Ticker
#'
#' @param book 
#' @param aggregated 
#'
#' @return
#' @export
#'
#' @examples
big_ticker<-function (book, aggregated) 
{
  if (!missing(aggregated)) {
    url <- paste0("https://api.bitso.com/v3/order_book/?book=", 
                  book, "&aggregate=", aggregated)
  }
  else {
    url <- paste0("https://api.bitso.com/v3/order_book/?book=", 
                  book)
  }
  tmp <- tempfile()
  res <- httr::GET(url, httr::write_disk(tmp))
  cat(noquote(paste("Success:", httr::content(res)$success, 
                    "\n\n")))
  if (httr::content(res)$success == TRUE) {
    R1 <- suppressWarnings(jsonlite::fromJSON(readLines(tmp)))$payload$asks
    R2 <- suppressWarnings(jsonlite::fromJSON(readLines(tmp)))$payload$bids
    
    R1 <- transform(R1, price = as.numeric(price), amount = as.numeric(amount))
    R2 <- transform(R2, price = as.numeric(price), amount = as.numeric(amount))
    return(list(asks=R1,bids=R2))
  }
}