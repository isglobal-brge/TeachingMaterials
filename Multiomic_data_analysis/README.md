# Multiomic data analysis

- Description: 2-hour lecture introducing multiomic data analysis
- Author: [Juan R Gonzalez](https://github.com/isglobal-brge/)
- Content: Genomic variation analysis, domain knowledge-guided approach, dimensionality reduction (PCA, MCIA, multiCCA)
- Material: 
  > * Slides of the main talk
  > * R code of the chunks presented in the talk
  > * Html illustrating mediation analysis (optional)
  > * folder `data`: data for illustrating purposes and exercises
  > * folder `exercises`: pdf describing the tasks to be performed
  > * folder `answer_exercises`: R code with the solution of the tasks

# Required packages

Install required packages (copy & paste this code into R console): 

```
# Necessary to install packages from Bioconductor
source("https://bioconductor.org/biocLite.R")

biocLite(c("haploR", "mediation", "made4", "omicade4"))
```