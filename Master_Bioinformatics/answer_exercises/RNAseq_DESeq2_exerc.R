library(DESeq2)
library(parathyroidSE)
data(parathyroidGenesSE)



# Get counts and phenotypes (e.g. covariate)

assayNames(parathyroidGenesSE)
counts <- assay(parathyroidGenesSE, "counts")
pheno <- colData(parathyroidGenesSE)

dim(counts)
dim(pheno)

head(pheno)

# Prepare data to be analyzed with DESeq2 
# Note 1: treatment*time is the same as treatment + time + treatment:time
# Note 2: DESeq2 has its own normalization procedure. Therefore, no normalization
#         has to be performed

dd <- DESeqDataSetFromMatrix(counts, pheno, 
                             design = ~ treatment * time)
res <- DESeq(dd)

# Check normalization ...  MA plot
plotMA(res)

# Genes DE between DPN and Control group
res.dpn <- results(res, contrast = c("treatment", "DPN", "Control"))
subset(res.dpn, padj<0.05 & !is.na(padj))


# Genes DE between OHT and Control group
res.oht <- results(res, contrast = c("treatment", "OHT", "Control"))
subset(res.oht, padj<0.05 & !is.na(padj))


# Genes DE between 48h and 24h
res.48 <- results(res, contrast = c("time", "48h", "24h"))
subset(res.48, padj<0.05 & !is.na(padj))


# Genes DE between DPN and Control group accross time
resultsNames(res)
res.DPN.48 <- results(res, name="treatmentDPN.time48h")
res.OHT.48 <- results(res, name="treatmentOHT.time48h")
subset(res.DPN.48, padj<0.05 & !is.na(padj))
subset(res.OHT.48, padj<0.05 & !is.na(padj))


# Boxplot

# select top gene
sel <- order(res.48$pvalue)[1]
sel
plotCounts(dd, sel, intgroup="time")

# advanced visualization
sel <- which(res.48$padj<0.05)
sel
par(mfrow=c(4,3))
for (i in 1:length(sel))
 plotCounts(dd, sel[i], intgroup="time")


# better with ggplot2
library(tidyr)
library(ggplot2)
xx <- data.frame(t(counts[sel, ]), time=pheno$time)
ee <- gather(xx, key=gene, value=counts, -time)

bp <- ggplot(ee, aes(x=time, y=counts)) + 
  geom_boxplot()
bp + facet_wrap(. ~ gene,  scales='free')

