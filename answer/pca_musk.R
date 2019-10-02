dd <- read.delim("c:/Juan/CREAL/GitHub/TeachingMaterials/Master_Modelling/data/musk.txt")
library(factoextra)
o <- which(colnames(dd)=="musk")
group <- dd[o]
mycol <- ifelse(group==1, "darkgreen", "blue")
pp <- prcomp(dd[ , -o])
fviz_pca_ind(pp, col.ind = mycol)
