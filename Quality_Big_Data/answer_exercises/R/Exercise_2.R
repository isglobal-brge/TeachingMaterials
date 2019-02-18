# set working directory
setwd("c:/Juan/CREAL/GitHub/R_course/Data_for_exercises/")

# task 1: read data
multi <- read.delim("multicentric.txt")
head(multi)
multi[1:6, 1:7]

# task 2
multi$edad1sex.cat <- cut(multi$edad1sex, c(-Inf, 14, 18, 25, Inf),
                          labels = c("<15", "15-18", "19-25", ">25"))
table(multi$edad1sex.cat)

# task 3
nrow(multi)
ncol(multi)

# task 4
str(multi)

# task 5
table(multi$pais, multi$status)
prop.table(table(multi$pais, multi$status))*100

library(Epi)
stat.table(list(pais, status), list(N = count(), 
                `%` = percent(status)), data = multi, margins = T)

# task 6
stat.table(list(vph, status), data=multi)

stat.table(list(vph, status), 
           list(N = count(), 
                `%` = percent(status)), data = multi, margins = T)

# task 7
library(Hmisc)
summary(durco ~ pais + status + niveledu, data=multi)

g <- function(x)c(Mean=mean(x,na.rm=TRUE),
                  Median=median(x,na.rm=TRUE),
                  Sd=sd(x,na.rm=TRUE),
                  IQR=IQR(x, na.rm=TRUE))

summary(durco ~ pais + status + niveledu, data=multi, fun=g)

# task 8

multi$nembara.q <- cut(multi$nembara, quantile(multi$nembara, na.rm=TRUE),
                       label=c("1st", "2nd", "3rd", "4th"))
table(multi$nembara.q)

table(multi$nembara.q, multi$status)

# task 9
boxplot(edademba ~ status, data=multi)

# task 10
hist(multi$edad1pap, freq = FALSE)
lines(density(multi$edad1pap, na.rm = TRUE), col="blue")

ks.test(multi$edad1pap, "pnorm")
