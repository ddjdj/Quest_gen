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
dat <- data.frame(label = 1, dat = dat)



dat <- readLines('MichaelJordan.txt')

for (r in seq_along(dat2)) {
  print(paste( dat2[r]))
  
}
dat2 <- data.frame(label = 2, dat = dat)


dat <-rbind(dat, dat2)

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
sci_tokens.dfm <- dfm(sci_tokens)
sci_tokens.dfm <- as.matrix(sci_tokens.dfm)
sci_tokens.dfm[1:20, 1:100]
dim(sci_tokens.dfm)




