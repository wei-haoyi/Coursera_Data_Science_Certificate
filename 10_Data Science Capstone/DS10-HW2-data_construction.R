# Prepare the data for the quiz.


# load packages ----

library(corpus) # corpus is an R text processing package with full suppport for international text (Unicode)
library(dplyr)
library(ggplot2)
library(tm) # package used to remove numbers and strip whitespace from a text document
library(stringi) # the function checks whether all bytes in a string are in the ascii set 1,2,3,4...,127
library(caTools) #split train and test set
library(quanteda)

# Set working directory
setwd("~/Documents/GitHub/Coursera_Data_Science_Certificate/10_Data Science Capstone")

# 1. Download and Read the data from web (Date: Dec 28, 2022) ----

# url <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
# download.file(url, "final_dataset.zip")
# unzip("final_dataset.zip")

# 2. Combine and subset the data ----
twitter <- readLines("final/en_US/en_US.twitter.txt", encoding="UTF-8", skipNul=TRUE)
blogs <- readLines("final/en_US/en_US.blogs.txt", encoding="UTF-8", skipNul=TRUE)
news <- readLines("final/en_US/en_US.news.txt", encoding="UTF-8", skipNul=TRUE)
data_combine <- c(twitter, blogs, news)

# data_sample <- data_combine
set.seed(1118)
data_sample <- sample(data_combine, size=100000, replace=FALSE)

# 3. Clean the dataset ----
# remove special characters
data_sample_temp1 <- iconv(data_sample, "UTF-8","ASCII",sub="")

# Remove numbers from text document
data_sample_temp2 <- removeNumbers(data_sample_temp1)

# Remove white spaces from text document
data_sample_temp3 <- stripWhitespace(data_sample_temp2)

# Set the entire dataset to lower case
data_sample_temp4 <- tolower(data_sample_temp3)

# remove leading and tailing white space
data_sample_temp5 <- trimws(data_sample_temp4)

# Profanity filtering - task 1, remove bad words.
# download.file("http://www.cs.cmu.edu/~biglou/resources/bad-words.txt", destfile = "bad_words.txt")
badword <- readLines("bad_words.txt", encoding="UTF-8")
data_sample_clean <- removeWords(data_sample_temp5, c(badword))

# 4. Get unigram, bigram, trigram ----

unigram <- term_stats(data_sample_clean, drop=stopwords_en, drop_punct = TRUE, ngrams=1,type=T) # remove punctuation and english stop words (is, this, and....)
save(unigram, file = "unigram.Rdata")

bigram <- term_stats(data_sample_clean, drop=stopwords_en, drop_punct = TRUE, ngrams=2,type=T) 
save(bigram, file = "bigram.Rdata")

trigram <- term_stats(data_sample_clean, drop=stopwords_en, drop_punct = TRUE, ngrams=3,type=T)
save(trigram, file = "trigram.Rdata")

quogram <- term_stats(data_sample_clean, drop=stopwords_en, drop_punct = TRUE, ngrams=4,type=T)
save(quogram, file = "quogram.Rdata")


