x <- matrix(rnorm(10000), nrow=100)
dim(x)


meanF <- function(x){
 ans <- rep(NA, ncol(x))
 for (i in 1:ncol(x))
  ans[i] <- mean(x[,i])
 ans
}

meanF2 <- function(i, x){
  mean(x[,i])
}

system.time(meanF(x))

system.time(lapply(1:ncol(x), meanF2, x=x))


#
# Ejemplo glm y lm
#

library(Rfast)
library(microbenchmark)
bench <- microbenchmark(glm = glm(uptake ~ conc, data=CO2),
                        lm = lm(uptake ~ conc, data=CO2),
                        Rfast = lmfit(CO2$uptake, CO2$conc))
bench
plot(bench)