
#
#  EXERCISE 1: single SNP analysis
#

# load library
library(SNPassoc)

# set working directory
setwd("c:/juan/UVIC/Final_material/GWAS/Exercises/")

# load data
data <- read.delim("DM.txt")
head(data)

# prepare SNP data
data.s <- setupSNP(data, 6:14, sep="")

# this does the same ...
ii <- grep("^rs", colnames(data))
ii <- c(ii, grep("lpr", colnames(data)))
data.s <- setupSNP(data, ii, sep="")

summary(data.s)
plotMissing(data.s)

# Association
ans <- WGassociation(RESP, data.s)
plot(ans)
ans

# get SNP name that is significant 
sel <- apply(ans, 1, function(x)  any(x < 0.05 & !is.na(x)))
sel[sel]
names(sel[sel])

# ORs for genetic models
association(RESP ~ rs908867, data.s)

# Adjusted model
association(RESP ~ rs908867 + HDRS, data.s)
association(RESP ~ rs908867 + HDRS + PSICOT + MELANCOL + EPD_PREV, data.s)

# Plot for dominant, recessive and additive models
ans2 <- WGassociation(RESP, data.s, model=c("dominant", 
                                            "recessive", 
                                            "log-additive"))
plot(ans2)

# Max-statistic
maxstat(data.s, RESP)


