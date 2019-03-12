library(tidyverse)
library(caret)
library(glmnet)

heart <- read_csv("https://raw.githubusercontent.com/isglobal-brge/TeachingMaterials/master/Quality_Big_Data/data/heart.csv")
heart <- mutate(heart, target=as.factor(target))
heart

# TEST AND TRAIN
#=============================================================
set.seed(123)
training.samples <- heart$target %>%
  createDataPartition(p = 0.8, list = FALSE)
train.data  <- heart[training.samples, ]
test.data <- heart[-training.samples, ]


# ELASTIC NET
#==============================================================

set.seed(123)
model.enet <- train(
  target ~., data = heart, method = "glmnet",
  trControl = trainControl("cv", number = 5,),
  tuneLength = 10
)

model.enet$bestTune
model.enet

coef(model.enet$finalModel, model.enet$bestTune$lambda)


x.test <- model.matrix(target ~., test.data)[,-1]
x.test.s <- scale(x.test)
predictions <- model.enet %>% predict(x.test.s) %>% as.vector()

table(predictions, test.data$target)

