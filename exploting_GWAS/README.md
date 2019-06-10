# Exploting SNP array data from GWAS: CNVs, mosaicisms and inversions

SNP array data are mainly used to perform GWAS with the aim of discovering new genetic variants associated with complex traits. There are two main values that can be obtained from SNP array data: LRR and BAF. LRR is the log-R-ratio of the two allele intensities, while BAF encodes for the frequency of the B-allele. 

The LLR is used to get genotypes calls which are obtained by using clustering methods

![](figures/allele_intensities_2.png | width=4, height=2)

The joint representation of LRR and BAF may help to call CNVs and genetic mosaicisms

![](figures/CNV_mosaicism.png)


Lastly, running PCA or MDS of SNPs located in a candidate inversion region may help to call inversion genotypes

![](figures/invCallCEU.png)

In this workshop, we illustrate how to perform of these analysis using R/Bioconductor packages. The required packages are:

```
library(devtools)
library(BiocManager)

install_github("isglobal-brge/brgedata")
install_github("isglobal-brge/R-GADA")
install_github("isglobal-brge/MAD")
install_github("isglobal-brge/MADloy")

install(c("scoreInvHap", "snpStats"))
```

The datasets used in the presentation and in the exercises are available at BioC package `brgedata`. However, it is recommended you donwload them from `https://github.com/isglobal-brge/brgedata/tree/master/inst/extdata` to mimic real situation where the user has their own data available in a given folder from his/her computer. 


# CNVs

- The vignette describing how to perform CNV calling can be found [here](https://htmlpreview.github.io/?https://github.com/isglobal-brge/R-GADA/blob/master/vignettes/R-GADA.html).

- **Exercise:** Perform CNV calling of the individuals SAMPLE_10, SAMPLE_11, ..., SAMPLE_20 from `brgedata`. Once the package is installed into your computer, you can copy them in the proper folder by:


```
ss1 <- system.file("extdata/rawData", package="brgedata")
dir.create("rawData")
ss2 <- "rawData"
files <- paste0(paste("SAMPLE", 10:20, sep="_"), ".txt")
file.copy(file.path(ss1, files), ss2)
```

NOTE: data can also be downloaded from [here](https://drive.google.com/open?id=1owbzcTHJZU_Tn0892B598_-L3HJitNQB)


# Genetic Mosaicisms

- The vignette describing how to perform mosaic calling can be found [here](https://htmlpreview.github.io/?https://github.com/isglobal-brge/MAD/blob/master/vignettes/MAD.html).

- **Exercise:** Perform mosaic calling on the individuals downloaded from previous exercise. 


# Mosaic loss of chromosome Y (mLOY)

- The vignette describing how to perform mLOY calling can be found [here](https://htmlpreview.github.io/?https://github.com/isglobal-brge/MADloy/blob/master/vignettes/MADloy.html).


# Polymorphic inversions

- The vignette describing how to perform polymorphic inversion calling can be found [here](https://htmlpreview.github.io/?https://github.com/isglobal-brge/scoreInvHap/blob/master/vignettes/scoreInvHap.html).


- **Exercise:** Call inversion genotypes of inversion 8p23.1 from PLINK data `obesity.bed`, `obesity.fam`, `obesity.ped` which are available in the `brgedata` package. Assess the association between inversion genotypes and obesity status which is available at `obesity.txt` file (NOTE: samples are in the proper order - you do not need to sort the samples). 

SNP data can be loaded into your computer by:

```
library(snpStats)
path <- system.file("extdata", package="brgedata")
snps <- read.plink(file.path(path, "obesity.bed"))
```