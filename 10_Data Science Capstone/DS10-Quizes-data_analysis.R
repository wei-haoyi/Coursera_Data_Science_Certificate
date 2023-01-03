# Prepare the data for the quiz.


# load packages ----

library(corpus) # corpus is an R text processing package with full suppport for international text (Unicode)
library(dplyr)
library(ggplot2)
library(tm) # package used to remove numbers and strip whitespace from a text document
library(stringi) # the function checks whether all bytes in a string are in the ascii set 1,2,3,4...,127
library(stringr) # extract the specific word in a sentence word()

# Set working directory
setwd("~/Documents/GitHub/Coursera_Data_Science_Certificate/10_Data Science Capstone")

# 1. Read the data

load("unigram.Rdata")
load("bigram.Rdata")
load("trigram.Rdata")
load("quogram.Rdata")

# calculate weighed frequency for all the datasets
w_unigram <- unigram %>%
          mutate(new_freq=count*1) %>%
          select(term,new_freq)
w_bigram <- bigram %>%
          mutate(new_freq=count*2000) %>%
          select(term,new_freq)
w_trigram <- trigram %>%
          mutate(new_freq=count*10000) %>%
          select(term,new_freq)
w_quogram <- quogram %>%
          mutate(new_freq=count*80000) %>%
          select(term,new_freq)
w_allgram <- rbind(w_unigram,w_bigram,w_trigram,w_quogram) %>%
          add_row(term="woxinyongheng",new_freq=0)

# create a function that can process the input sentence.

clean_line <- function(sentence){
# Remove some symbols
          
          # remove insignifanct words
          sentence1<-removeWords(sentence,stopwords('en'))
          # remove special characters
          sentence1 <- iconv(sentence1, "UTF-8","ASCII",sub="")
          
          # Remove numbers from text document
          sentence1 <- removeNumbers(sentence1)
          
          # Remove white spaces from text document
          sentence1 <- stripWhitespace(sentence1)
          
          # Remove punctuation
          sentence1 <- removePunctuation(sentence1,preserve_intra_word_dashes = TRUE)
          
          # Set the entire dataset to lower case
          sentence1 <- tolower(sentence1)
          
          # Profanity filtering - task 1, remove bad words.
          badword <- readLines("bad_words.txt", encoding="UTF-8")
          sentence1 <- removeWords(sentence1, c(badword))
          
          # remove leading and tailing white space
          sentence1 <- trimws(sentence1)

# make the sentence into a dataset
          first <- word(sentence1, -1) # the last word
          second <-paste(word(sentence1, -(2:1)),collapse=' ') # the last and second last word
          third <- paste(word(sentence1, -(3:1)),collapse=' ') # the last tp third last word
          forth <- paste(word(sentence1, -(4:1)),collapse=' ') # the last tp forth last word
          full <- data.frame(term=c(first, second, third, forth)) %>%
                    add_row(term="woxinyongheng")
          
# Compare sentence and corpus
          final <- inner_join(full,w_allgram,by="term")
          tot_frequency <- sum(final$new_freq)
          return(tot_frequency)
} 


# Q1

sentence<-"The guy in front of me just bought a pound of bacon, a bouquet, and a case of"
options<- c('pretzels','cheese', 'beer', 'soda')
for(i in 1:length(options)) {
          sentence_n<-paste(sentence, options[i])
          print(sentence_n)
          a<-clean_line(sentence_n)
          print(a)
}

# beer

## Q2

sentence<-"You re the reason why I smile everyday. Can you follow me please? It would mean the"
options<- c('world','best', 'most', ' universe')
for(i in 1:length(options)) {
          sentence_n<-paste(sentence, options[i])
          print(sentence_n)
          a<-clean_line(sentence_n)
          print(a)
}
# world 

## Q3
sentence<-"Hey sunshine, can you follow me and make me the"
options<- c('bluest','happiest', 'smelliest', 'saddest')
for(i in 1:length(options)) {
          sentence_n<-paste(sentence, options[i])
          print(sentence_n)
          a<-clean_line(sentence_n)
          print(a)
}

# happiest

## Q4
sentence<-"Very early observations on the Bills game: Offense still struggling but the"
options<- c('players','defense', 'referees', 'crowd')
for(i in 1:length(options)) {
          sentence_n<-paste(sentence, options[i])
          print(sentence_n)
          a<-clean_line(sentence_n)
          print(a)
}

# defense right/player

# Q5
sentence<-"Go on a romantic date at the"
options<- c('movies','mall', 'grocery', 'beach')
for(i in 1:length(options)) {
          sentence_n<-paste(sentence, options[i])
          print(sentence_n)
          a<-clean_line(sentence_n)
          print(a)
}

# beach

## Question 6

sentence<-"Well I'm pretty sure my granny has some old bagpipes in her garage I'll dust them off and be on my"
options<-c('motorcycle','way', 'horse', 'phone')
for(i in 1:length(options)) {
          sentence_n<-paste(sentence, options[i])
          print(sentence_n)
          a<-clean_line(sentence_n)
          print(a)
}

# Answer: way

## Question 7


sentence<-"Ohhhhh #PointBreak is on tomorrow. Love that film and haven't seen it in quite some"
options<-c('time','thing', 'years', 'weeks')
for(i in 1:length(options)) {
          sentence_n<-paste(sentence, options[i])
          print(sentence_n)
          a<-clean_line(sentence_n)
          print(a)
}


Answer: time

## Question 8

sentence<-"After the ice bucket challenge Louis will push his long wet hair out of his eyes with his little"
options<-c('ears','eyes', 'toes', 'fingers')
for(i in 1:length(options)) {
          sentence_n<-paste(sentence, options[i])
          print(sentence_n)
          a<-clean_line(sentence_n)
          print(a)
}

# Answer: fingers

## Question 9

sentence<-"Be grateful for the good times and keep the faith during the"
options<-c('worse','bad', 'hard', 'sad')
for(i in 1:length(options)) {
          sentence_n<-paste(sentence, options[i])
          print(sentence_n)
          a<-clean_line(sentence_n)
          print(a)
}

Answer:bad

## Question 10

sentence<-"If this isn't the cutest thing you've ever seen, then you must be"
options<-c('asleep','callous', 'insane', 'insensitive')
for(i in 1:length(options)) {
          sentence_n<-paste(sentence, options[i])
          print(sentence_n)
          a<-clean_line(sentence_n)
          print(a)
}


# Answer: answer insane/asleep


# Quiz3

sentence<-"Talking to your mom has the same effect as a hug and helps reduce your "
options<- c('walk','look','minute','picture')
for(i in 1:length(options)) {
          sentence_n<-paste(sentence, options[i])
          print(sentence_n)
          a<-clean_line(sentence_n)
          print(a)
}
