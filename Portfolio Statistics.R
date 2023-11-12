rm(list = ls())

## Load Packages
## Load Packages
library(quantmod)
library(xts)
library(zoo)
library(Quandl)
library(tidyverse)
library(magrittr)
library(tseries)
library(PerformanceAnalytics)
library(PortfolioAnalytics)
library(ROI)
library(ROI.plugin.quadprog)
library(ROI.plugin.glpk)
library(tidyr)
Quandl.api_key("r_V5MSbUqUFHpxzjJwrK") ## Add Quandl API key

## Load Bitcoin and Ethereum Prices
getSymbols("BTC-USD", src = "yahoo")
getSymbols("ETH-USD", src = "yahoo")

## Calculate Daily Returns
bitcoin_r <- round(Return.calculate(`BTC-USD`),6)[-1]
ethereum_r <- round(Return.calculate(`ETH-USD`),6)[-1]

## combine into a dataset
crypto <- merge(bitcoin_r[,4], ethereum_r[,4], all = T)

## Key Statistics
a <- apply(crypto,2, FUN = mean, na.rm = T)
b <- apply(crypto,2, FUN = sd, na.rm = T)
c <- apply(crypto,2, FUN = VaR, na.rm = T, p = 0.05, method = "modified")
d <- apply(crypto,2, FUN = ES, na.rm = T, p = 0.05, method = "modified")
e <- apply(crypto,2, FUN = SharpeRatio, na.rm = T)[1,]
crypto.stats = data_frame(asset = c("bitcoin", "ethereum"),
                     daily.return = a,
                     daily.sd = b,
                     daily.VaR = c,
                     daily.ES = d,
                     daily.Sharpe = e)
crypto.stats[,c(2:6)] <- round(crypto.stats[,c(2:6)],5)
cor(crypto, use = "pairwise.complete.obs") # correlation

## remove daily data
rm(list = ls())

## Now do portfolio analysis on a monthly basis
getSymbols("BTC-USD", src = "yahoo") # bitcoin
getSymbols("ETH-USD", src = "yahoo") # ethereum
getSymbols("VDTA.L", src = "yahoo") # Vanguard UST ETF
getSymbols("VDPA.L", src = "yahoo") # Vanguard US CB ETF
getSymbols("TRFE.F", src = "yahoo") # Invesco UST ETF
getSymbols("QQQ", src = "yahoo") # Invesco NASDAQ ETF
getSymbols("SPY", src = "yahoo") # SPDR S&P 500 ETF
getSymbols("XTEN", src = "yahoo")














