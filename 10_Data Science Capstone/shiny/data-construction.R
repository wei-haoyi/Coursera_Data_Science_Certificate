# Prepare the data for the quiz.


# load packages ----

library(corpus) # corpus is an R text processing package with full suppport for international text (Unicode)
library(dplyr)
library(ggplot2)
library(tm) # package used to remove numbers and strip whitespace from a text document
library(stringi) # the function checks whether all bytes in a string are in the ascii set 1,2,3,4...,127

# Set working directory
setwd("~/Documents/GitHub/Coursera_Data_Science_Certificate/10_Data Science Capstone/shiny")

# 1. Download and Read the data from web (Date: Dec 28, 2022) ----

url <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
download.file(url, "final_dataset.zip")
unzip("final_dataset.zip")

# 2. Combine and subset the data ----
twitter <- readLines("final/en_US/en_US.twitter.txt", encoding="UTF-8", skipNul=TRUE)
blogs <- readLines("final/en_US/en_US.blogs.txt", encoding="UTF-8", skipNul=TRUE)
news <- readLines("final/en_US/en_US.news.txt", encoding="UTF-8", skipNul=TRUE)
data_combine <- c(twitter, blogs, news)

# check the encoding of of data_combine
# library(readr)
# guess_encoding(data_combine, n_max = 1000)

# data_sample <- data_combine

data_sample <- sample(data_combine, size=100000, replace=FALSE)

# 3. Clean the dataset ----
# remove special characters
data_sample_temp1 <- iconv(data_sample, "UTF-8","ASCII",sub="")

# Profanity filtering - task 1, remove bad words.
download.file("http://www.cs.cmu.edu/~biglou/resources/bad-words.txt", destfile = "bad_words.txt")
badword <- readLines("bad_words.txt", encoding="UTF-8")
data_sample_clean <- removeWords(data_sample_temp1, c(badword))

# 4. Get unigram, bigram, trigram ----

unigram <- term_stats(data_sample_clean, text_filter(drop=stopwords_en, drop_symbol = TRUE, drop_punct = TRUE, drop_number = TRUE), ngrams=1,type=T) %>% # remove punctuation and english stop words (is, this, and....),remove number, remove space, lowercase
          mutate(term="") %>%
          rename(NextWord=type1) %>%
          select(-support)

bigram <- term_stats(data_sample_clean, text_filter(drop=stopwords_en, drop_symbol = TRUE, drop_punct = TRUE, drop_number = TRUE), ngrams=2,type=T) %>%
          select(-term,-support) %>%
          rename(term=type1) %>%
          rename(NextWord=type2) %>%
          mutate(count=count*10000)


trigram <- term_stats(data_sample_clean, text_filter(drop=stopwords_en, drop_symbol = TRUE, drop_punct = TRUE, drop_number = TRUE), ngrams=3,type=T) %>%
          select(-term,-support) %>%
          mutate(term = paste(type1,type2)) %>%
          select(-type1,-type2) %>%
          relocate(term) %>%
          rename(NextWord=type3) %>%
          mutate(count=count*100000)

final <- rbind(unigram,bigram,trigram)

final <- final %>%
         filter(count!=1) %>%
          filter(count!=10000)

save(final, file = "final.Rdata")

