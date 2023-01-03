# prediction.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Script for predicting a NextWord given an input of any length using stupid backoff algorithm
# 2016-01-23

# Libraries and options ####
library(dplyr)
library(quanteda)
library(wordcloud)
library(RColorBrewer)
library(corpus)
library(tm)
library(stringr)

setwd("/Users/wei/Documents/GitHub/Coursera_Data_Science_Certificate/10_Data Science Capstone/shiny")

# Parse tokens from input text

load("final.Rdata")

fun.input <- function(sentence){
          # Remove some symbols
          # remove special characters
          sentence1 <- iconv(sentence, "UTF-8","ASCII",sub="")
          
          # Profanity filtering - task 1, remove bad words.
          badword <- readLines("bad_words.txt", encoding="UTF-8")
          sentence1 <- removeWords(sentence1, c(badword))
          
          # Remove white spaces from text document
          sentence1 <- stripWhitespace(sentence1)
          
          # Set the entire dataset to lower case
          sentence1 <- tolower(sentence1)
          
          # remove leading and tailing white space
          sentence1 <- trimws(sentence1)
          
          # make the sentence into a dataset
          first <- word(sentence1, -1) # the last word
          second <-word(sentence1, -2) # the last second last word
          final <- data.frame(term=c(NA,first,paste(second,first)))
          final$term <- trimws(final$term)
          
          final[is.na(final)] <- ""
          
          final[final$term=="NA",] <- ""
          
          return(final)
} 


# Predict using stupid backoff algorithm ####

fun.predict = function(x, n =100) {
          sentence <- fun.input(x)
          combo <- inner_join(sentence,final,by="term") %>%
                    arrange(-count) %>%
                    select(NextWord,count)
          return(combo[1:n,])
}
