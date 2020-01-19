


# load library
library(factoextra)


# read data (change path)
pp <- "c:/Juan/CREAL/GitHub/TeachingMaterials/Master_Modelling/data/"
dd <- read.delim(file.path(pp, "musk.txt"))
head(dd)
ncol(dd)

# create factor variable (with labels)
dd$group <- factor(dd$musk, label=c("non-musk", "musk"))

o <- which(colnames(dd)=="musk")
pca <- prcomp(dd[ , -o])

# individuals
fviz_pca_ind(pca, col.ind = dd$group, legend.title="Musk")

# variables
fviz_pca_var(pca)
