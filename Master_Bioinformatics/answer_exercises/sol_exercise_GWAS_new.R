#
# LOAD LIBRARY 
#

library(snpStats)

#
# LOAD DATA
#

# genotypes
setwd("c:/juan/UVIC/Final_material/GWAS/Exercises/")
plink <- read.plink("coronary")
geno <- plink$genotypes
geno

# annotation
annotation <- plink$map

#phenotype
feno <- read.delim("coronary.txt", sep="")
head(feno)
rownames(feno) <- feno$id
head(feno)


#
# CHECK ORDER OF INDIVIDUALS
#


identical (rownames(feno), rownames(geno))

sel <- intersect(rownames(feno), rownames(geno))

geno <- geno[sel,]
feno <- feno[sel, ]


identical (rownames(feno), rownames(geno))

#
# QC SNPs
#

info.snps <- col.summary(geno)
head(info.snps)

use <- info.snps$Call.rate > 0.95 &
       info.snps$MAF > 0.05 &
       abs(info.snps$z.HWE < 3.3)    
mask.snps <- use & !is.na(use)

geno.qc.snps <- geno[ , mask.snps]
geno.qc.snps

annotation <- annotation[mask.snps, ]


#
#  QC Indivduals
#

info.indv <- row.summary(geno.qc.snps)
head(info.indv)

# Sex discrepancies
geno.X <- geno.qc.snps[,annotation$chromosome=="23" & 
                         !is.na(annotation$chromosome)]
info.X <- row.summary(geno.X)
sex.discrep <- (feno$gender=="Males" & info.X$Heterozygosity > 0.05) |  
  (feno$gender=="Females" & info.X$Heterozygosity < 0.25)   

# visually check
cc <- ifelse(feno$gender=="Males", "red", "blue")
plot(info.X$Heterozygosity, col=cc)


# Heterozigosity
MAF <- col.summary(geno.qc.snps)$MAF
callmatrix <- !is.na(geno.qc.snps)
hetExp <- callmatrix %*% (2*MAF*(1-MAF))
hetObs <- with(info.indv, Heterozygosity*(ncol(geno.qc.snps))*Call.rate)
info.indv$hetF <- 1-(hetObs/hetExp)

head(info.indv)

## ----ibd-----------------------------------------------------------------
library(SNPRelate)

# Transform PLINK data into GDS format
snpgdsBED2GDS("coronary.bed", "coronary.fam", "coronary.bim", 
              out="obGDS")
genofile <- snpgdsOpen("obGDS")

#Prune SNPs for IBD analysis
set.seed(12345678)
snps.qc <- colnames(geno.qc.snps)
snp.prune <- snpgdsLDpruning(genofile, ld.threshold = 0.2,
                             snp.id = snps.qc)
snps.ibd <- unlist(snp.prune, use.names=FALSE)

## ----ibd2----------------------------------------------------------------
ibd <- snpgdsIBDMoM(genofile, kinship=TRUE,
                    snp.id = snps.ibd,
                    num.thread = 1)
ibd.kin <- snpgdsIBDSelection(ibd) 
head(ibd.kin)

## ----related-------------------------------------------------------------
ibd.kin.thres <- subset(ibd.kin, kinship > 0.1)
head(ibd.kin.thres)

## ----qc_related----------------------------------------------------------
ids.rel <-  SNPassoc:::related(ibd.kin.thres) 
ids.rel

## ----qc_indiv------------------------------------------------------------
use <- info.indv$Call.rate > 0.95 &
  abs(info.indv$hetF) < 0.1 &     # or info.inv$Heterozygosity < 0.32
  !sex.discrep &
  !rownames(info.indv)%in%ids.rel
mask.indiv <- use & !is.na(use)
geno.qc <- geno.qc.snps[mask.indiv, ]

feno.qc <- feno[mask.indiv, ]
identical(rownames(feno.qc), rownames(geno.qc))

dim(feno)
dim(feno.qc)

dim(geno)
dim(geno.qc)


#
# ASSOCIATION ANALYSIS
#

res <- snp.rhs.tests(bmi ~ 1, data=feno.qc, snp.data=geno.qc,
                     family="Gaussian")

res[1:5,]

bonf.sig <- 1e-8
ps <- p.value(res)
res[ps < bonf.sig & !is.na(ps), ]

#
#  QQ-plot
#

chi2 <- chi.squared(res) 
qq.chisq(chi2)



#
# ASSOCIATION ANALYSIS - ADJUSTED ANALYSIS (population stratification)
#

res.adj <- snp.rhs.tests(bmi ~ ev3 + ev4, family="Gaussian",
                         data=feno.qc, snp.data=geno.qc)


chi2.adj <- chi.squared(res.adj)
qq.chisq(chi2.adj)


