#
# Exercise 1
#

setwd("c:/Juan/CREAL/GitHub/R_course/Data_for_exercises/")
multi <- read.delim("multicentric.txt")
levels(multi$status)

# reorder caso/control (to properly interpret the OR)
multi$status2 <- relevel(multi$status, 2)
levels(multi$status2)

# vph

mod.vph <- glm(status2 ~ vph, data=multi, family="binomial")
summary(mod.vph)
or <- exp(coef(mod.vph))
ci <- exp(confint(mod.vph))
round(cbind(or, ci),2)[-1,]

# numembara

mod.num <- glm(status2 ~ nembara, data=multi, family="binomial")
summary(mod.num)
or <- exp(coef(mod.num))
ci <- exp(confint(mod.num))
round(cbind(or, ci),2)[-1,]

#
# Extra (how to do this using and R function)
#


names(multi)

getOR <- function(i){
 mod <- glm(status2 ~ multi[,i], data=multi, family="binomial")
 or <- exp(coef(mod))
 ci <- exp(confint(mod))
 round(cbind(or, ci),2)[-1,]
}

getOR(4)
ans <- matrix(unlist(sapply(4:21, getOR)), ncol=3, byrow=TRUE)
ans


#
# Exercise 2
#


# load library
library(compareGroups)

# select variables
descr <- compareGroups(status2 ~ edad + niveledu + fumar + edad1sex +
                         nembara + vph, multi)
descr

# create table 1 
table1 <- createTable(descr, show.p.overall = FALSE)
table1

# create table 1 with p-values
table1.p <- createTable(descr, show.p.overall = TRUE)
table1.p

# create table 2
table2 <- createTable(descr, show.ratio = TRUE)
table2

update(table2, show.p.trend=TRUE)

# export to word
export2word(table1, file="table1.doc")

# figures
plot(table2["vph"], bivar=TRUE)

plot(table2["edad1sex"])


