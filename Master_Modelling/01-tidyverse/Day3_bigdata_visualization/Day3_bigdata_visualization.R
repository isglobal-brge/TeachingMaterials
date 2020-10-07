## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, comment="", message=FALSE, warning=FALSE, cache=TRUE, fig.width = 4, fig.height = 4)
options(width=80)

## ----install, eval=FALSE-------------------------------------------------
## devtools::install_github("hadley/bigvis")

## ----bin_plot------------------------------------------------------------
library(bigvis);library(tidyverse);library(nycflights13)
dist_s <- condense(bin(flights$distance, 10))
autoplot(dist_s)

## ----bin_plot2-----------------------------------------------------------
dist_s <- condense(bin(flights$distance, 100))
autoplot(dist_s)

## ----two_variables-------------------------------------------------------
speed <- with(flights, distance / air_time * 60)
sd2 <- condense(bin(flights$distance, 20), bin(speed, 20))
autoplot(sd2)

## ----plot_diamonds, eval=FALSE-------------------------------------------
## # subset the diamonds data
## mydiamonds <- subset(diamonds, carat < 2.75)
## 
## # condense avg price based on bins of carat sizes
## # of .1 carat intervals
## myd <- condense(bin(mydiamonds$carat, .1),
##                 z=mydiamonds$price, summary="mean")
## 
## # smooth out the trend
## myds <- smooth(myd, 50, var=".mean", type="robust")
## 
## # plot the orginal binned prices vs the smoothed trend line
## ggplot() + geom_line(data=myd, aes(x=mydiamonds.carat,
##                                    y=.mean, colour="Avg Price")) +
##            geom_line(data=myds, aes(x=mydiamonds.carat,
##                                     y=.mean, colour="Smoothed")) +
##            ggtitle("Avg Diamond prices by binned Carat") +
##            ylab("Avg Price") +
##            xlab("Carats") +
## scale_colour_manual("", breaks=c("Avg Price","Smoothed"),
##                     values=c("blue", "black"))

## ----plot_diamonds_vis, echo=FALSE---------------------------------------
# subset the diamonds data
mydiamonds <- subset(diamonds, carat < 2.75)

# condense avg price based on bins of carat sizes 
# of .1 carat intervals
myd <- condense(bin(mydiamonds$carat, .1), 
                z=mydiamonds$price, summary="mean")

# smooth out the trend
myds <- smooth(myd, 50, var=".mean", type="robust")

# plot the orginal binned prices vs the smoothed trend line
ggplot() + geom_line(data=myd, aes(x=mydiamonds.carat, 
                                   y=.mean, colour="Avg Price")) + 
           geom_line(data=myds, aes(x=mydiamonds.carat, 
                                    y=.mean, colour="Smoothed")) + 
           ggtitle("Avg Diamond prices by binned Carat") + 
           ylab("Avg Price") + 
           xlab("Carats") + 
scale_colour_manual("", breaks=c("Avg Price","Smoothed"),
                    values=c("blue", "black"))

## ----load_movies, eval=FALSE---------------------------------------------
## Nbin <- 1e4 # number of bins
## binData <- with(movies,
##                 condense(bin(length, find_width(length, Nbin)),
##                          bin(rating, find_width(rating, Nbin))))
## ggplot(binData, aes(length, rating, fill = .count)) +
##   geom_tile()

## ----load_movies_plot, echo=FALSE----------------------------------------
Nbin <- 1e4 # number of bins
binData <- with(movies, 
                condense(bin(length, find_width(length, Nbin)),
                         bin(rating, find_width(rating, Nbin))))
ggplot(binData, aes(length, rating, fill = .count)) + 
  geom_tile()

## ----plot_no_outliers----------------------------------------------------
last_plot() %+% peel(binData) # same plot, different data

## ----plot_smooth---------------------------------------------------------
smoothBinData <- smooth(peel(binData), h=c(20, 1))
autoplot(smoothBinData)

## ------------------------------------------------------------------------
sessionInfo()

