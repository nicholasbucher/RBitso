#' Time Parse
#' 
#' Bitso API Time-Stamp Convertion.
#'
#' @param tick_time Character: Date-Time object
#'
#' @return
#'
#' @examples
#' time_parse("2017-09-02T17:23:06+00:00")
#' 
time_parse<-function(tick_time){
  
  y<-as.numeric(substr(tick_time,1,4))
  m<-as.numeric(substr(tick_time,6,7))
  d<-as.numeric(substr(tick_time,9,10))
  hr<-as.numeric(substr(tick_time,12,13))
  mn<-as.numeric(substr(tick_time,15,16))
  s<-as.numeric(substr(tick_time,18,19))
  
  return(lubridate::make_datetime(y,m,d,hr,mn,s))

}