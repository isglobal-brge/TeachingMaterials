library(MEAL)
library(GEOquery)
gds <- getGEO("GSE40732")[[1]]
gds

genes <- exprs(gds)
pheno <- pData(gds)

boxplot(genes["AB002294",])

boxplot(genes["AB002294",] ~ pheno$ characteristics_ch1)

res <- runDiffMeanAnalysis(gds, model = ~ characteristics_ch1)

plot(res, rid = "DiffMean", type="manhattan")
