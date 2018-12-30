library(tidyverse)
library(magrittr)
library(stringr)
library(quanteda)
library(readtext)
library(ggplot2)
library(e1071)
library(irlba)
library(randomForest)
library(tm)
library(dplyr)
library(class)
library(NLP)
library(stringr)
library(wordcloud)
#library(tau)
dat <- paste(readLines('einstein.txt'), collapse=" ")
str(dat)
corpus <- corpus(dat)
corpus <- tokens(corpus)
#corpus <- tm_map(corpus, removeWords, stopwords("en"))
corpus
#corpus <- dfm(corpus, remove = stopwords("english"), stem = TRUE, removePunctuation=TRUE)
corpus <- tokens_remove(tokens(corpus, removePunctuation = TRUE), stopwords("english"))
corpus
corpus <- Corpus(VectorSource(as.vector(corpus)))

clean_corpus <- function(corpus) {
  
  corpus <- tm_map(corpus, content_transformer(tolower))
  corpus <- tm_map(corpus, removeWords, stopwords("en"))
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, stripWhitespace)
    return(corpus)
  
}
#corpus <- removeWords(corpus, stopwords("english"))


dat2 <- DocumentTermMatrix(corpus)
dat2 <- as.matrix(dat2)
#dat2


frequency <- colSums(dat2)
frequency <- sort(frequency, decreasing = TRUE)
words <- names(frequency)
wordcloud(words[1:100], frequency[1:100], min.freq = 1, max.words = 200)





