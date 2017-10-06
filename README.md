# RBitso
R Bitso API Package

## This is Markdown right?? On R-Studio!!! 

This should do right?
Now lets do two things

And then anothe one

# RBitso Notes

# Notes
  - Establish num-format
  - Fix empty payloads response error to NULL
  - Open orders & order_trades check
  - Withdrawals
  - Bank Codes & Withdrawal


# Great, you have to start with the next step or do something else kid
Books<-get_books()
Books<-Books[1:5,1]
full_ticker<-NULL
for(i in 1:5){
  full_ticker<-rbind(full_ticker,c(ticker(Books[i])))
}
