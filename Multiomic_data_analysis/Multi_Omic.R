## ----include=FALSE-------------------------------------------------------
library(knitr)
opts_chunk$set(
tidy=FALSE, size='footnotesize', warning=FALSE, message=FALSE, fig.align='center', out.width='2in')

## ----setup, echo=FALSE---------------------------------------------------
options(width = 80)

## ----haploR--------------------------------------------------------------
library(haploR)
x <- queryHaploreg(query=c(c("rs11810571", "rs7623687", "rs142695226", 
                             "rs433903", "rs10857147", "rs11723436",
                             "rs35879803", "rs35541991", "rs1351525",
                             "rs11170820", "rs2244608", "rs3832966",
                             "rs33928862", "rs7500448", "rs138120077")))

## ----haploR_2------------------------------------------------------------
sel <- as.numeric(x$r2) > 0.9
x2 <- x[sel, c("pos_hg38", "rsID", "Motifs", "gwas",
               "GENCODE_name", "Enhancer_histone_marks")]
x2

## ----haploR_3------------------------------------------------------------
x3 <- x[, c("rsID", "eQTL")]
x3

## ----plot_pca_1, echo=FALSE----------------------------------------------
set.seed(12345)
y <- rnorm(45, 4, 1)
x <- 2 * y + rnorm(45)
cc <- rep("black", 45)
cc[x>10] <- "red"
cc[c(4,9)] <- "red"
plot(x,y, cex.lab=1.4, cex.axis = 1.3, xlab="GATA3", ylab="XPBD1")
points(x,y, pch=16, col=cc, cex=1.3)

## ----plot_pca_2, echo=FALSE----------------------------------------------
plot(x,y, cex.lab=1.4, cex.axis = 1.3, xlab="GATA3", ylab="XPBD1")
points(x,y, pch=16, col=cc, cex=1.3)
abline(lm(y~x), col="darkgreen", lwd=2)
arrows(6.5, 2.5, 6.5, 3.2, length=0.15, col="darkgreen")
text(6.5, 2.3, "First PCA", col="darkgreen")

## ----plot_pca_3, echo=FALSE----------------------------------------------
plot(x,y, cex.lab=1.4, cex.axis = 1.3, xlab="GATA3", ylab="XPBD1")
points(x,y, pch=16, col=cc, cex=1.3)
abline(lm(y~x), col="darkgreen", lwd=2)
arrows(6.5, 2.5, 6.5, 3.2, length=0.15, col="darkgreen")
text(6.5, 2.3, "First PCA", col="darkgreen")
segments(10, 3.4, 7.6, 5.0, col="darkgreen")
arrows(11.7, 3.6, 10, 3.6, length=0.15, col="darkgreen")
text(12.0, 3.6, "Second PCA", adj=0, col="darkgreen")

## ----plot_pca_4, echo=FALSE----------------------------------------------
ans <- princomp(cbind(y,x))
plot(ans$score, xlab="PCA1", ylab="PCA2", col=cc, pch=16, cex.lab=1.4, cex.axis = 1.3)
abline(h=0, lty=2)
abline(v=0, lty=2)

## ----plot_pca_5, echo=FALSE----------------------------------------------
plot(ans$score, xlab="PCA1", ylab="PCA2", col=cc, pch=16, cex.lab=1.4, cex.axis = 1.3)
abline(h=0, lty=2)
abline(v=0, lty=2)
arrows(0,0, 3.5,0.2, col="darkblue", length=0.05)
arrows(0,0, 1, -0.1, col="darkblue", length=0.05)
text(3.6, 0.2, "GATA3", col="darkblue", adj=0)
text(1.1, -0.1, "XPBD1", col="darkblue", adj=0)

## ----load_data-----------------------------------------------------------
load("data/breast_TCGA_subset_multi_omic.RData")
summary(breast_multi)

## ----load_ade4-----------------------------------------------------------
require(ade4)
dim(breast_multi$RNAseq)

## ----pca, cache=TRUE-----------------------------------------------------
breastPCA<-dudi.pca(breast_multi$RNAseq, 
            scannf=FALSE, nf=5)

## ----load_made4----------------------------------------------------------
require(made4)

## ----pca_plot, fig.show='hide'-------------------------------------------
group<-droplevels(breast_multi$clin$ER.Status)
out <- ord(breast_multi$RNAseq, classvec=group)
plot(out, nlab=3, arraylabels=rep("T", 79))

## ----projections_plot, fig.show='hide'-----------------------------------
par(mfrow=c(2,1))
plotarrays(out$ord$co, classvec=group)
plotgenes(out, col="blue")

## ----list_genes----------------------------------------------------------
ax1 <- topgenes(out, axis=1, n=5)
ax2 <- topgenes(out, axis=2, n=5)
cbind(ax1, ax2)

## ----sPCA, cache=TRUE----------------------------------------------------
require(PMA)
dd <- t(breast_multi$RNAseq)
sout <- SPC(dd, sumabsv=3, 
            K=2, orth=TRUE)

## ----sPCA_out, size='scriptsize'-----------------------------------------
rownames(sout$u) <- rownames(dd)
rownames(sout$v) <- colnames(dd)
head(sout$u)
head(sout$v)

## ----sPCA_plot-----------------------------------------------------------
plot(sout$u, type="n", xlab="First sPCA", ylab="Second sPCA")
points(sout$u, col=as.numeric(group))

## ----sPCA_genes, size='scriptsize'---------------------------------------
ss <- sout$v[,1]
ss[ss!=0]
ax1

## ----data_cc-------------------------------------------------------------
require(CCA)
df1 <- t(breast_multi$RNAseq)[,1:1000]
df2 <- t(breast_multi$RPPA)

## ----cc, eval=FALSE------------------------------------------------------
## resCC <- cc(df1, df2)

## ----rcc, cache=TRUE-----------------------------------------------------
resRCC <- rcc(df1, df2, 0.2, 0.1) 

## ----regul_estim, eval=FALSE---------------------------------------------
## regul <- estim.regul(df1, df2)
## resRCC2 <- rcc(df1, df2, regul$lambda1, regul$lambda2)

## ----plot_rcc, fig.show='hide'-------------------------------------------
plt.cc(resRCC)

## ----plot_rcc_out, fig.width=12, echo=FALSE------------------------------
plt.cc(resRCC)

## ----multiCCA------------------------------------------------------------
require(PMA)
ddlist <- list(df1, df2)
perm.out <- MultiCCA.permute(ddlist, 
                             type=c("standard", "standard"),
                             trace=FALSE) 
resMultiCCA <- MultiCCA(ddlist,  
                        penalty=perm.out$bestpenalties, 
                        ws=perm.out$ws.init, 
                        type=c("standard", "standard"), 
                        ncomponents=1, trace=FALSE, standardize=TRUE)

## ----multiCCA_out, size='scriptsize'-------------------------------------
rownames(resMultiCCA$ws[[1]]) <- colnames(df1)
rownames(resMultiCCA$ws[[2]]) <- colnames(df2)
head(resMultiCCA$ws[[1]])
head(resMultiCCA$ws[[2]])

## ----getcia--------------------------------------------------------------
library(made4)
library(omicade4)

## ----cia, cache=TRUE-----------------------------------------------------
resCIA <- cia(breast_multi$RNAseq, breast_multi$RPPA)

## ----plot_cia, fig.show='hide'-------------------------------------------
plot(resCIA, classvec=group, nlab=3, clab=0, cpoint=3 )

## ----top_features--------------------------------------------------------
topVar(resCIA, axis=1, topN=5, end="positive")

## ----top_features_neg----------------------------------------------------
topVar(resCIA, axis=1, topN=5, end="negative")

## ----mcia, cache=TRUE----------------------------------------------------
resMCIA <- mcia( breast_multi[ c(1,3,4,5,6,7) ] )

## ----plot_mcia, fig.show='hide'------------------------------------------
plot(resMCIA, axes=1:2, sample.lab=FALSE, sample.legend=FALSE, 
     phenovec=group, gene.nlab=2, 
     df.color=c("cyan", "magenta", "red4", "brown","yellow", "orange"),
     df.pch=2:7)

## ----top_features_m------------------------------------------------------
topVar(resMCIA, end="positive", axis=1, topN=5)

## ----plot_eigen, fig.show='hide'-----------------------------------------
plot(resMCIA$mcoa$cov2,  xlab = "pseudoeig 1", 
     ylab = "pseudoeig 2", pch=19, col="red")
text(resMCIA$mcoa$cov2, labels=rownames(resMCIA$mcoa$cov2), 
     cex=1.4, adj=0)

