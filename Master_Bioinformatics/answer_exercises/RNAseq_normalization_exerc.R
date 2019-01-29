library(Biobase)
library(tweeDEseq)
library(tweeDEseqCountData)
library(cqn)
library(edgeR)

data(pickrell)
data(annotEnsembl63)
counts <- exprs(pickrell.eset)

#
# Select genes with annotation
#
annotEnsembl63.nona <- subset(annotEnsembl63, !is.na(GCcontent) & !is.na(Length))

genes.ok <- intersect(rownames(counts), rownames(annotEnsembl63.nona))
counts.ok <- counts[genes.ok,]
annot.ok <- annotEnsembl63[genes.ok,]

dim(counts.ok)
dim(annot.ok)

#
# RPKM normalization
#
width <- annot.ok$Length
counts.rpkm <- t(t(counts.ok / width *1000)
                    /colSums(counts.ok)*1e6)
counts.rpkm[1:5,1:4]

#
# TMM normalization
#
counts.tmm <- normalizeCounts(counts.ok, method="TMM")
counts.tmm[1:5,1:4]

#
# CQN normalization
#
annotation <- annot.ok[,c("Length", "GCcontent")]
counts.cqn <- normalizeCounts(counts.ok, method="cqn",
                 annot=annotation)

#
# Visualization
#

par(mfrow = c(2,2))

maPlot(counts[,1], counts[,2], 
         pch=19, cex=.5, ylim=c(-8,8),  
         allCol="darkgray", lowess=TRUE, 
         xlab=expression( A == log[2] (sqrt(Sample1 %.% Sample2)) ),
         ylab=expression(M == log[2](Sample1)-log[2](Sample2))) 
grid(col="black") 
title("Raw Data")

maPlot(counts.tmm[,1], counts.tmm[,2], 
         pch=19, cex=.5, ylim=c(-8,8),  
         allCol="darkgray", lowess=TRUE, 
         xlab=expression( A == log[2] (sqrt(Sample1 %.% Sample2)) ),
         ylab=expression(M == log[2](Sample1)-log[2](Sample2))) 
grid(col="black") 
title("TMM")

maPlot(counts.cqn[,1], counts.cqn[,2], 
         pch=19, cex=.5, ylim=c(-8,8),  
         allCol="darkgray", lowess=TRUE, 
         xlab=expression( A == log[2] (sqrt(Sample1 %.% Sample2)) ),
         ylab=expression(M == log[2](Sample1)-log[2](Sample2))) 
grid(col="black") 
title("cqn")


# RPKM 
maPlot(counts.rpkm[,1], counts.rpkm[,2], 
         pch=19, cex=.5, ylim=c(-8,8),  
         allCol="darkgray", lowess=TRUE, 
         xlab=expression( A == log[2] (sqrt(Sample1 %.% Sample2)) ),
         ylab=expression(M == log[2](Sample1)-log[2](Sample2))) 
grid(col="black") 
title("RPKM")



