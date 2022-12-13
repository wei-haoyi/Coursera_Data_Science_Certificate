# Question 1 ----
# Load the Alzheimer's disease data using the commands:
install.packages("AppliedPredictiveModeling")
library(AppliedPredictiveModeling)
data(AlzheimerDisease)


# Which of the following commands will create non-overlapping training and test sets with about 50% of the observations assigned to each?

adData = data.frame(diagnosis,predictors)

testIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[-testIndex,]
testing = adData[testIndex,]

# Question 2 ----
# Load the cement data using the commands:

library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[inTrain,]
testing = mixtures[-inTrain,]

# Make a plot of the outcome (CompressiveStrength) versus the index of the samples. Color by each of the variables in the data set (you may find the cut2() function in the Hmisc package useful for turning continuous covariates into factors). What do you notice in these plots?

str(mixtures)

library(dplyr)
library(Hmisc)
training2 <- training %>%
  mutate(across(names(training), function(x) cut2(x,g=4),.names= "fact_{col}"))
  # select(contains("fact_"))

index <- seq_along(1:nrow(training2))
p1 <- qplot(index, CompressiveStrength, colour=fact_Age, data=training2)
p1
p2 <- qplot(index, CompressiveStrength, colour=fact_FlyAsh, data=training2)
p2
p3 <-qplot(index, CompressiveStrength, colour=fact_Cement, data=training2)
p3

# There is a non-random pattern in the plot of the outcome versus index that does not appear to be perfectly explained by any predictor suggesting a variable may be missing.


# Question 3 ----
# Load the cement data using the commands:
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

# Make a histogram and confirm the SuperPlasticizer variable is skewed. Normally you might use the log transform to try to make the data more symmetric. Why would that be a poor choice for this variable?

p4 <- ggplot(training,aes(x=Superplasticizer)) + geom_histogram()
p4
# There are a large number of values that are the same and even if you took the log(SuperPlasticizer + 1) they would still all be identical so the distribution would not be symmetric.

# Question 4 ----
# Load the Alzheimer's disease data using the commands:

library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

# Find all the predictor variables in the training set that begin with IL. Perform principal components on these variables with the preProcess() function from the caret package. Calculate the number of principal components needed to capture 90% of the variance. How many are there?

str(training)

training2 <- training %>%
  select(starts_with("IL"))

preproc <- preProcess(training2, method="pca", thresh=0.9)
preproc$numComp

# Question 5:
# Load the Alzheimer's disease data using the commands:
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433); data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[inTrain,]
testing = adData[-inTrain,]

# Create a training data set consisting of only the predictors with variable names beginning with IL and the diagnosis. Build two predictive models, one using the predictors as they are and one using PCA with principal components explaining 80% of the variance in the predictors. Use method="glm" in the train function.

training2 <- training %>%
  select(diagnosis,starts_with("IL"))

# predictive model using the predictors as they are
modelFit1 <- train(diagnosis~., method="glm", data=training2)
confusionMatrix(testing$diagnosis, predict(modelFit1,testing))
# accuracy 0.7561

# predictive model using PCA with principal components explaining 80% of the variance in the predictors
# How can I add threshold paramether in the train? I specify additional preprocess arguments with trainControl
ctrl <- trainControl(preProcOptions=list(thresh=0.8))
modelFit <- train(diagnosis~., method="glm",preProcess=c("center","scale","pca"),trControl=ctrl, data=training2)
confusionMatrix(testing$diagnosis, predict(modelFit,testing))
# accuracy 0.7195

