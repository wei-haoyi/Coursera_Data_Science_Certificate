
# Q1----
# Load the cell segmentation data from the AppliedPredictiveModeling package using the commands:
library(dplyr)
library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)

# Subset the data to a training set and testing set based on the Case variable in the data set.

train <- segmentationOriginal %>%
  filter(Case=="Train") %>%
  select(-Case)
test <- segmentationOriginal %>%
  filter(Case=="Test") %>%
  select(-Case)

set.seed(125)

modelTrain <- train(Class~.,data=train,method="rpart")
modelTrain$finalModel
fancyRpartPlot(modelTrain$finalModel)

# A. PS
# B. WS
# C. PS
# D. No possible to predict

# Q2----
# If K is small in a K-fold cross validation is the bias in the estimate of out-of-sample (test set) accuracy smaller or bigger? If K is small is the variance in the estimate of out-of-sample (test set) accuracy smaller or bigger. Is K large or small in leave one out cross validation?

# A: The bias is larger and the variance is smaller. Under leave one out cross validation K is equal to the sample size.

# Q3 ----

# Load the olive oil data using the commands:

library(pgmm)
data(olive)
olive = olive[,-1]

# (NOTE: If you have trouble installing the pgmm package, you can download the -code-olive-/code- dataset here: olive_data.zip. After unzipping the archive, you can load the file using the -code-load()-/code- function in R.)

# These data contain information on 572 different Italian olive oils from multiple regions in Italy. Fit a classification tree where Area is the outcome variable. Then predict the value of area for the following data frame using the tree command with all defaults

newdata = as.data.frame(t(colMeans(olive)))

# What is the resulting prediction? Is the resulting prediction strange? Why or why not?

modelFit <- train(Area ~., method="rpart",data=olive)
predictions <- predict(modelFit,newdata=newdata)
predictions
# 2.783. It is strange because Area should be a qualitative variable - but tree is reporting the average value of Area as a numeric variable in the leaf predicted for newdata

olive$Area <- as.factor(olive$Area)
modelFit <- train(Area ~., method="rpart",data=olive)
predictions <- predict(modelFit,newdata=newdata)
predictions


# Q4 ----

# Load the South Africa Heart Disease Data and create training and test sets with the following code:
library(bestglm)
data(SAheart)
#SAheart$chd <- as.factor(SAheart$chd)
#SAheart$famhist <- as.factor(SAheart$famhist)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

# Then set the seed to 13234 and fit a logistic regression model  (method="glm", be sure to specify family="binomial") with Coronary Heart Disease (chd) as the outcome and age at onset, current alcohol consumption, obesity levels, cumulative tabacco, type-A behavior, and low density lipoprotein cholesterol as predictors. Calculate the misclassification rate for your model using this function and a prediction on the "response" scale:

# missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}

# What is the misclassification rate on the training set? What is the misclassification rate on the test set?

set.seed(13234)

modelFit<- train(chd~age+alcohol+obesity+tobacco+typea+ldl, method="glm", family="binomial", data=trainSA)



missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}

mistrain <- missClass(trainSA$chd,predict(modelFit, trainSA))
mistrain

mistest <- missClass(testSA$chd,predict(modelFit, testSA))
mistest


# Q5 ----
# Load the vowel.train and vowel.test data sets:
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)


# Question 5
# Load the vowel.train and vowel.test data sets:
library(randomForest)
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)


# Set the variable y to be a factor variable in both the training and test set. Then set the seed to 33833. Fit a random forest predictor relating the factor variable y to the remaining variables. Read about variable importance in random forests here:  http://www.stat.berkeley.edu/~breiman/RandomForests/cc_home.htm#ooberr The caret package uses by default the Gini importance.

vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)
set.seed(33833)
library(randomForest)
xx <- randomForest(y ~., data=vowel.train)
x<-varImp(xx)

order(varImp(xx), decreasing=T)

#
# Calculate the variable importance using the varImp function in the caret package. What is the order of variable importance?
#
#   [NOTE: Use randomForest() specifically, not caret, as there's been some issues reported with that approach. 11/6/2016]
