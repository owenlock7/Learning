library(tidyverse)
library(magrittr)
library(quantmod)

## Download Data
getSymbols("BTC-USD", src = "yahoo")

## View the Price Evolution of Bitcoin
plot(`BTC-USD`[,4])

