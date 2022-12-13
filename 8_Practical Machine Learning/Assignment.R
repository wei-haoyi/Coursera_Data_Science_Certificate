
train <- read.csv("~/Documents/GitHub/Coursera_Data_Science_Certificate/8_Practical Machine Learning/pml-training.csv", na.strings=c("NA","","#DIV/0!"))
test <- read.csv("~/Documents/GitHub/Coursera_Data_Science_Certificate/8_Practical Machine Learning/pml-testing.csv", na.strings=c("NA","","#DIV/0!"))

train$group <-1
test$group <-0

library(arsenal)
View(summary(comparedf(test,train)))

library(dplyr)
test <- test %>%
          mutate(problem_id=NA) %>%
          rename(classe=problem_id)

training_data <- rbind(test,train)

# drop the variable with no or minimum variation

library(caret)
x <- nearZeroVar(training_data)
y <- training_data[,x]
xx <-x[-37]
y <- training_data[,xx]
training_data <- training_data[,-xx]

# Remove the variables that are mde up of mostly NAs
naprops <- colSums(is.na(training_data))/nrow(training_data)
mostlyNAs <- names(naprops[naprops > 0.50])
mostlyNACols <- which(naprops > 0.50)
training_data <- training_data[,-mostlyNACols]

# remove the cvta_timestamp variable as a candidate predictor
# the factor variable makes prediciton of the test set difficult and is redunandant when raw time data is available in the data set.

traindata <- training_data[,c(-1,-5)]

# Check whehter there is missing value
z <-names(which(sapply(traindata,anyNA)))





# split train and test

trainclean <- traindata[traindata$group==1,]
testclean <- traindata[traindata$group==0,]


# Use createDataPartition to separate training set and test set.
trainclean <- trainclean[,c(-1,-58)]
inTrain <- createDataPartition(y=trainclean$classe,p=0.6, list=FALSE) # split the data set in to 75% training

trainclean$classe <- as.factor(trainclean$classe )

training <- trainclean[inTrain,]
testing <- trainclean[-inTrain,]

# training the model using decision tree

set.seed=123

ctrl<- trainControl(method="cv", number=10)
tree_model <- train(classe~.,
                      data=training,
                      method="rpart",
                      trControl=ctrl,
                      metric="Accuracy")
print(tree_model)
predtree <- predict(tree_model,testing)
confusionMatrix(predtree,testing$classe)

# accuracy 0.5243

# training the model using random forest

set.seed= 123

tgrid <- expand.grid(mtry=6:20, splitrule="gini", min.node.size=c(1, 10))
ctrl <- trainControl(method="cv", number=10)

rf_model <- caret:: train (classe~.,
                           data=training,
                           method="ranger",
                           trControl=ctrl,
                           metric="Accuracy",
                           num.trees=500,
                           tuneGrid= tgrid)

print(rf_model)

predrf <- predict(rf_model,testing)
confusionMatrix(predrf,testing$classe)
# Accuracy: 0.999

# Predicting Results on the Test Data
rfPredcitions <- predict(rf_model, newdata = testclean)
rfPredcitions


