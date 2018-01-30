#' NONCE
#'
#' Unique Increasing Timestamp. 
#' @keywords nonce,timestamp
#' @examples
#' NONCE()

NONCE<-function(){
  return(as.character(floor(as.numeric(as.POSIXct(Sys.time())))))
}
