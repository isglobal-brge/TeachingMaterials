#
#  TASK 1
#

setwd("c:/Juan/CREAL/GitHub/TeachingMaterials/Multiomic_data_analysis/")
load("data/nci60.Rdata")

ls()
names(nci60)

# PCA on separated omic data
library(made4)

pca.mrna <- ord(nci60$mrna, classvec=cancer)
plot(pca.mrna, nlab=3, arraylabels=cancer)
topgenes(pca.mrna, axis=1, n=5)

pca.prot <- ord(nci60$prot, classvec=cancer)
plot(pca.prot, nlab=3, arraylabels=cancer)
topgenes(pca.prot, axis=1, n=5)

pca.miRNA <- ord(nci60$miRNA, classvec=cancer)
plot(pca.miRNA, nlab=3, arraylabels=cancer)
topgenes(pca.miRNA, axis=1, n=5)
topgenes(pca.miRNA, axis=2, n=5)


# MCIA

library(omicade4)
ans <- mcia(nci60, cia.nf = 2)

plot.mcia(ans, sample.lab = TRUE,  
          phenovec = cancer, 
          gene.nlab = 2, sample.legend = FALSE)

plotVar(ans, nlab=5)



# Leukemia is in the positive side of the 1st axis:
topVar(ans, axis=1, end="positive")

# Leukemia is correlated to MI0000458 (plays and essential role in T-lymphocyte development) 
# and mi0000300 (is regulated by the Notch and NF-kb signaling pathways in T-cell ALL)


# Melanoma is in the positive side of the 2nd axis and negative side of 1st axis:
topVar(ans, axis=2, end="positive")
topVar(ans, axis=1, end="negative")

# Melanoma is correlated to MI0003196, MI0003192 and MI0000284 which are reported to initiate
# melanocyte transformation and protomote melanoma growth.


# CNS is in the negative side of the 2nd axis and negative side of 1st axis:
topVar(ans, axis=2, end="negative")

# CNS is correlated to MI0001735 which has been reported to promote the epithelial-to-mesenchymal
# transition in prostate cancer. In the NCI-60 cell line data, CNS cell lines are characterized more
# by a pronounced mesenchymal phenotype.


# MultiCCA

library(PMA)
ddlist <- list(t(nci60$mrna), t(nci60$prot), t(nci60$miRNA))  # requires features in rows
perm.out <- MultiCCA.permute(ddlist,
                             type=c("standard", "standard", "standard"),
                             trace=TRUE)

resMultiCCA <- MultiCCA(ddlist,  
                        penalty=perm.out$bestpenalties, 
                        ws=perm.out$ws.init, 
                        type=c("standard", "standard", "standard"), 
                        ncomponents=2, trace=TRUE, standardize=TRUE)

rownames(resMultiCCA$ws[[1]]) <- rownames(nci60$mrna)
rownames(resMultiCCA$ws[[2]]) <- rownames(nci60$prot)
rownames(resMultiCCA$ws[[3]]) <- rownames(nci60$miRNA)

# Leukemia is in the positive side of the 1st axis:
feat.miRNA <- resMultiCCA$ws[[3]][,1]
feat.miRNA.pos <- feat.miRNA[feat.miRNA>0]
head(feat.miRNA.pos[order(feat.miRNA.pos, decreasing = TRUE)])


# How many hits are statistically significant in the first axis?
feat.mrna <- resMultiCCA$ws[[1]][,1]
feat.prot <- resMultiCCA$ws[[2]][,1]
feat.miRNA <- resMultiCCA$ws[[3]][,1]

length(feat.mrna[feat.mrna!=0])
length(feat.prot[feat.prot!=0])
length(feat.miRNA[feat.miRNA!=0])

