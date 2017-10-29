# RBitso
R Bitso API Package

    install_github("nicholasbucher/RBitso")

## Usage 
Load library and set your personal Bitso Key and Bitso Secret to Enviroment

    library(RBitso)
    
    ky<-"aAthYgJued"
    scrt<-"09edab3590260f4526b352cd5135e870fcg"
    
Get your balance

    balance()
    
     Success: TRUE 
      currency    available locked        total pending_deposit pending_withdrawal
    1      bch   0.00000000      0   0.00000000               0                  0
    2      btc   0.00134465      0   0.00134465               0                  0
    3      etc   0.00000000      0   0.00000000               0                  0
    4      eth   0.00000000      0   0.00000000               0                  0
    5      xrp   0.00000000      0   0.00000000               0                  0
    6      mxn 101.48192000      0 101.48192000               0                  0
    
    
Observe ticker

    ticker()
    Success: TRUE 
        high  last          created_at    book   volume     vwap      low      ask    bid
    1 80949.99 80500 2017-10-06 18:07:43 btc_mxn 341.5266 79554.58 78774.24 80496.93 80000.1

# Notes
  - Establish num-format
  - Fix empty payloads response error to NULL
  - Open orders & order_trades check
  - Withdrawals
  - Bank Codes & Withdrawal


# Code Notes
    Books<-get_books()
    Books<-Books[1:5,1]
    full_ticker<-NULL
    for(i in 1:5){
      full_ticker<-rbind(full_ticker,c(ticker(Books[i])))
    }
