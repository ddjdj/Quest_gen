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


dat <- readLines('einstein.txt')
for (r in seq_along(dat)) {
  print(paste( dat[r]))
 
}


str(dat)
dat <- data.frame(label = 1, dat = dat)
names(dat) <- c("label", "text")
dat$label <- as.factor(dat$label)
str(dat)
dat$text <- as.character(dat$text)
dat$length <- nchar(dat$text)
dat <- dat[which(dat$length > 0), ]
View(dat)
nrow(dat)
ncol(dat)


sci_tokens <- tokens(dat$text, what = "word",
                     remove_numbers = TRUE, remove_symbols = TRUE,
                     remove_punct = TRUE, remove_hyphens = TRUE  )
                     

sci_tokens <- tokens_select(sci_tokens, stopwords(), selection = "remove")
sci_tokens <- tokens_wordstem(sci_tokens, language = "english")
sci_tokens
View(sci_tokens)
#prop.table(table(dat$label))
#corpus <- corpus(dat)
#corpus <- tokens(corpus)
#corpus <- tokens_remove(tokens(corpus, removePunctuation = TRUE), stopwords("english"))
#corpus <- Corpus(VectorSource(as.vector(corpus)))
#clean_corpus <- function(corpus) {
  

  #return(corpus)
  
#}
#Corpus

#str(corpus)
#corpus

#dat1 <- tm_map(corpus, PlainTextDocument)
#dat1 <- Corpus(vectorSource(dat1)) 
#dat1 <- tm_map(dat1, content_transformer(tolower))
#dat1 <- tm_map(dat1, removeWords, stopwords("en"))
#dat1 <- tm_map(dat1, removePunctuation)
#dat1 <- tm_map(dat1, stripWhitespace)

#inspect(dat)


#dat2 <- DocumentTermMatrix(corpus)
#dat2 <- as.matrix(dat2)
#dat2 <- corpus

#frequency <- colSums(dat2)
#frequency <- sort(frequency, decreasing = TRUE)
#words <- names(frequency)
#wordcloud(words[1:100], frequency[1:100], min.freq = 1, max.words = 200)






