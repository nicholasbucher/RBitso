#' Place Order
#'
#' Place Trading Order. 
#' @param book, character: "mayor_minor"
#' @param side, character:  trading position, "buy" / "sell"
#' @param major, character: amount to trade on major units
#' @param price, character: proposed major price on minor units
#' @param type, character: type of order, "limit"
#' @keywords order,sell,buy
#' @export
#' @examples
#' place_order("btc_mxn","sell","limit","75000","0.001")


place_order<-function(book,side,type,price,major,minor){
  
  # Book Issue
  if(missing(book)){
    cat("Specify Book")
    return(NULL)
  }
  # Side Issue
  if(missing(side)){
    cat("Specify Side")
    return(NULL)
  }
  # Type Issue
  if(missing(type)){
    cat("Specify Type")
    return(NULL)
  }
  # Major or Minor
  if(!missing(major) & !missing(minor)){
    cat("Only Specify Major or Minor")
    return(NULL)
  }
  # Market Case ----------------------------------------------------
  if(type=="market"){
    if(!missing(price)){
      cat("Market Orders Do not need Price")
      return(NULL)
    }
    if(!missing(major)){
      Pyld<- gsub("\\[|\\]", "", jsonlite::toJSON(data.frame(book=book,side=side,major=major,type=type)))
      body<-list(book=book,side=side,major=major,type=type)
    }
    if(!missing(minor)){
      Pyld<- gsub("\\[|\\]", "", jsonlite::toJSON(data.frame(book=book,side=side,minor=minor,type=type)))
      body<-list(book=book,side=side,minor=minor,type=type)
    }
  }
  if(type == "limit"){
    if(missing(price)){
      cat("Limit Orders need Price")
      return(NULL)
    }
    if(!missing(major)){
      Pyld<- gsub("\\[|\\]", "", jsonlite::toJSON(data.frame(book=book,side=side,major=major,price=price,type=type)))
      body<-list(book=book,side=side,major=major,price=price,type=type)
    }
    
    if(!missing(minor)){
      Pyld<- gsub("\\[|\\]", "", jsonlite::toJSON(data.frame(book=book,side=side,minor=minor,price=price,type=type)))
      body<-list(book=book,side=side,minor=minor,price=price,type=type)
    }
    
  }

  
  NC<-NONCE()
  mthd<-"POST"
  
  url<-"https://api.bitso.com/v3/orders/"
  Pth<-"/v3/orders/"
  hdr<-paste0("Bitso ",ky,":",NC,":",openssl::sha256(paste0(NC,mthd,Pth,Pyld),scrt))
  tmp <- tempfile()
  res<-httr::POST(url, body = body, httr::add_headers(Authorization=hdr), encode="json", httr::write_disk(tmp))
  cat(noquote(paste("Success:", httr::content(res)$success,"\n\n")))
  if(httr::content(res)$success== TRUE){
    return(suppressWarnings(jsonlite::fromJSON(readLines(tmp)))$payload$oid)
  }
}
