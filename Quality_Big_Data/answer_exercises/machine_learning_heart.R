library(tydiverse)
library(caret)

heart <- read_csv("https://raw.githubusercontent.com/isglobal-brge/TeachingMaterials/master/Quality_Big_Data/data/heart.csv")

heart <- mutate(heart, target=as.factor(target))
heart

# PARALELIZACIÓN DE PROCESO
#==============================================================
library(doParallel)
cl <- makePSOCKcluster(3)
registerDoParallel(cl)



# DEFINICIÓN DEL ENTRENAMIENTO
#==============================================================
particiones  <- 10
repeticiones <- 5

control_train <- trainControl(method = "repeatedcv", 
                              number = particiones,
                              repeats = repeticiones, 
                              returnResamp = "final",
                              verboseIter = FALSE,
                              allowParallel = TRUE)


#
# LDA
#

mod.lda <- train(target ~ ., 
                     data = heart,
                     method = "lda",
                     metric = "Accuracy",
                     trControl = control_train)
mod.lda


# CART

mod.C50Tree <- train(target ~ ., 
                     data = heart,
                     method = "C5.0Tree",
                     metric = "Accuracy",
                     trControl = control_train)
mod.C50Tree


#
# Random Forest
#

# Hiperparámetros
hiperparametros <- expand.grid(mtry = c(2, 3, 4, 5, 6, 7))

set.seed(12345)
seeds <- vector(mode = "list", length = (particiones *
                                           repeticiones) + 1)
for (i in 1:(particiones * repeticiones)) {
  seeds[[i]] <- sample.int(1000, nrow(hiperparametros))
}
seeds[[(particiones * repeticiones) + 1]] <- sample.int(1000, 1)

control_train <- trainControl(method = "repeatedcv", 
                              number = particiones,
                              repeats = repeticiones, 
                              returnResamp = "final",
                              seeds=seeds,
                              verboseIter = FALSE,
                              allowParallel = TRUE)


mod.rf <- train(target ~ ., 
                data = heart,
                method = "rf",
                tuneGrid = hiperparametros,
                metric = "Accuracy",
                trControl = control_train)
mod.rf


# Comparison
mod.C50Tree$results
mod.lda$results
mod.rf$results
