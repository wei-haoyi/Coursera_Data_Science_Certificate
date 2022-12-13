# Q1----

Load the vowel.train and vowel.test data sets:

library(ElemStatLearn)

data(vowel.train)

data(vowel.test)

# Set the variable y to be a factor variable in both the training and test set. Then set the seed to 33833. Fit (1) a random forest predictor relating the factor variable y to the remaining variables and (2) a boosted predictor using the "gbm" method. Fit these both with the train() command in the caret package.
#
# What are the accuracies for the two approaches on the test data set? What is the accuracy among the test set samples where the two methods agree?

vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)

set.seed(33833)

modelFitrm <- train(y~.,method="rf",data=vowel.train)
modelFitgbm <- train(y~.,method="gbm",data=vowel.train)

pred_rf <- predict(modelFitrm, vowel.test)
pred_gbm <- predict(modelFitgbm, vowel.test)

confusionMatrix(pred_rf,vowel.test$y)
# 0.6126
confusionMatrix(pred_gbm,vowel.test$y)
# 0.513

predDF <- data.frame(pred_rf, pred_gbm, y= vowel.test$y)
# accuracy among the test set samples where the two methods agree
sum(pred_rf[predDF$pred_rf == predDF$pred_gbm]==
      predDF$y[predDF$pred_rf==predDF$pred_gbm])/sum(predDF$pred_rf == predDF$pred_gbm)

# 0.66444068


# Q2 ----

library(caret)

library(gbm)

set.seed(3433)

library(AppliedPredictiveModeling)

data(AlzheimerDisease)

adData = data.frame(diagnosis,predictors)

inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]

training = adData[ inTrain,]

testing = adData[-inTrain,]


# Set the seed to 62433 and predict diagnosis with all the other variables using a random forest ("rf"), boosted trees ("gbm") and linear discriminant analysis ("lda") model. Stack the predictions together using random forests ("rf"). What is the resulting accuracy on the test set? Is it better or worse than each of the individual predictions?

set.seed(62433)
mod_rf <- train(diagnosis ~ ., data = training, method = "rf")
mod_gbm <- train(diagnosis ~ ., data = training, method = "gbm")
mod_lda <- train(diagnosis ~ ., data = training, method = "lda")
pred_rf <- predict(mod_rf, testing)
pred_gbm <- predict(mod_gbm, testing)
pred_lda <- predict(mod_lda, testing)
predDF <- data.frame(pred_rf, pred_gbm, pred_lda, diagnosis = testing$diagnosis)
combModFit <- train(diagnosis ~ ., method = "rf", data = predDF)
combPred <- predict(combModFit, predDF)
#All four different accuracies are shown below.

# Accuracy using random forests
confusionMatrix(pred_rf, testing$diagnosis)$overall[1]
##  Accuracy
## 0.7804878
# Accuracy using boosting
confusionMatrix(pred_gbm, testing$diagnosis)$overall[1]
## Accuracy
## 0.804878
# Accuracy using linear discriminant analysis
confusionMatrix(pred_lda, testing$diagnosis)$overall[1]
##  Accuracy
## 0.7682927
# Stacked Accuracy
confusionMatrix(combPred, testing$diagnosis)$overall[1]
##  Accuracy
## 0.8170732
#Hence, stacked accuracy is 0.82 , and it is better than all three other methods.


# Q3 ----
# Load the concrete data with the commands:

set.seed(3523)

library(AppliedPredictiveModeling)

data(concrete)

inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]

training = concrete[ inTrain,]

testing = concrete[-inTrain,]


set.seed(233)
mod_lasso <- train(CompressiveStrength ~ ., data = training, method = "lasso")
library(elasticnet)
plot.enet(mod_lasso$finalModel, xvar = "penalty", use.color = TRUE)

# The coefficient path shows that the variable Cement is the last coefficient to be set to zero as the penalty increases.

# Load the data on the number of visitors to the instructors blog from here:
#
#  https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv
#
# Using the commands:

library(lubridate) # For year() function below
class(SAheart$chd)

gaData = read.csv("~/gaData.csv")

training = gaData[year(gaData$date) < 2012,]

testing = gaData[(year(gaData$date)) > 2011,]

tstrain = ts(training$visitsTumblr)
# Fit a model using the bats() function in the forecast package to the training time series. Then forecast this model for the remaining time points. For how many of the testing points is the true value within the 95% prediction interval bounds?
library(forecast)
mod_ts <- bats(tstrain)
fcast <- forecast(mod_ts, level = 95, h = dim(testing)[1])
sum(fcast$lower < testing$visitsTumblr & testing$visitsTumblr < fcast$upper) /
  dim(testing)[1]

