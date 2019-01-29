#
# EXERCISE 1
#

library(GOstats)
library(org.Hs.eg.db)
library(tweeDEseq)
library(KEGG.db)


# 1

load("resPT.Rdata")
dim(resPT)

# 2

geneDE <- subset(resPT, abs(log2fc) > log2(1.5) & pval.adjust < 0.05)
dim(resPT)
dim(geneDE)
geneDE <- rownames(geneDE)
head(geneDE)


# 3

geneUniverse <- unlist(mget(geneUniverse, org.Hs.egENSEMBL2EG, 
                            ifnotfound=NA))

geneDE <- unlist(mget(geneDE, org.Hs.egENSEMBL2EG, 
                      ifnotfound=NA))

params <- new("GOHyperGParams", geneIds=geneDE,
              universeGeneIds=geneUniverse,
              annotation="org.Hs.eg.db", ontology="BP",
              pvalueCutoff=0.05, conditional=FALSE,
              testDirection="over")
hgOver <- hyperGTest(params)
hgOver

summary(hgOver)

conditional(params) <- TRUE
hgOver.cond <- hyperGTest(params)
hgOver.cond

htmlReport(hgOver, file="exercise.html")

params.kegg <- new("KEGGHyperGParams", geneIds=geneDE,
                   universeGeneIds=geneUniverse,
                   annotation="org.Hs.eg.db",
                   pvalueCutoff=0.05,
                   testDirection="over")

hgOver.kegg <- hyperGTest(params.kegg)
summary(hgOver.kegg)


# 4

geneDE <- subset(resPT, abs(log2fc) > log2(1.5) & pval.adjust < 0.05)
geneDE <- rownames(geneDE)

geneUniverse <- rownames(resPT)
length(geneUniverse)

data(genderGenes)
geneSex <- unique(intersect(geneUniverse,
                  c(msYgenes, XiEgenes)))
length(geneSex)


GeneSet <- geneUniverse%in%geneSex
GeneDE <- geneUniverse%in%geneDE

tt <- table(GeneDE, GeneSet)
tt
fisher.test(tt, alternative="greater")


#
# EXERCISE 2
#

library(EnrichmentBrowser)
ff <- "c:/juan/UVIC/Final_Material/NGS/data"
gmt.file <- file.path(ff, "c3.all.v6.2.entrez.gmt")
gmt.file

c3.gs <- getGenesets(gmt.file)
c3.gs[1:4]

library(parathyroidSE)
data(parathyroidGenesSE)

# translate to ExpressionSet (required by the package)
eSet <- as(parathyroidGenesSE, "ExpressionSet")
dim(eSet)

# create GROUP variable 
pData(eSet)$GROUP <- ifelse(eSet$time=="48h", 1, 0)

# optional: remove non ENSEMBL genes
sel <- grep("^ENSG", rownames(eSet))
eSet <- eSet[sel,]
dim(eSet)

# get FC and ADJ.PVAL columns 
eSet <- deAna(eSet, de.method="DESeq2")

# sbea requires gene names in Entrez
eSet <- idMap(eSet, org = "hsa", from = "ENSEMBL", to="ENTREZID")

res <- sbea(method="ora", se=eSet, 
            gs=c3.gs, perm=0, alpha=0.05)
gsRanking(res)




