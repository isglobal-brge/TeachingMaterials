# Master in Bioinformatics - UAB

Repository with the material corresponding to the  __Master in Bioinformatics__ given at 
[UAB](http://mscbioinformatics.uab.cat/base/base3.asp?sitio=msbioinformatics). This repository contains slides illustrating theoretical aspects, R/Bioconductor slides, supplementary material, exercises and R code providing the answer to proposed tasks.

This material can be reproduced with some required packages that can be intalled by executing this in `R` or `RStudio`:

- Installing Bioconductor:

    ```
    install.packages("BiocManager")
    BiocManager::install()
    ```

- Packages required for Bioconductor lectures

    ```
    BiocManager::install(c("BiocManager", "Biobase", "Biostrings",
                           "snpStats", "GenomicRanges", "annotate",
                           "GO.db", "biomaRt", "Homo.sapiens","hgu95av2.db",
                           "SummarizedExperiment", "airway", "ALL",
                           "TxDb.Hsapiens.UCSC.hg19.knownGene"))
    ```

- Packages required for GWAS and RNAseq lectures

    ``` 
    BiocManager::install(c("snpStats", "tweeDEseq", "tweeDEseqCountData",
                           "limma", "DESeq", "DESeq2", "edgeR", 
                           "GOstats", "EnrichmentBrowser", "regionR"))
    
    install.packages("devtools")                       
    devtools::install_github("isglobal-brge/SNPassoc")
    ```

# License
 
Unless otherwise stated, all material is licensed under a
[Creative Commons Attribution-ShareAlike 3.0 License](http://creativecommons.org/licenses/by-sa/3.0/).
This means you are free to copy, distribute and transmit the work,
adapt it to your needs as long as you cite its origin and, if you do
redistribute it, do so under the same license.

