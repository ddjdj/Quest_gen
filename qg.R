library(tidyverse)
library(caret)
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
dat <- data.frame( label = 1, data = dat)
View(dat)


dat2 <- readLines('MichaelJordan.txt')

for (r in seq_along(dat2)) {
  print(paste( dat2[r]))
  
}
dat2 <- data.frame( label = 2, data = dat2)
View(dat2)

dat <-rbind(dat, dat2)

head(dat)
tail(dat)
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

zx <-prop.table(table(dat$label))
zx


ggplot(dat, aes(x = length, fill = label)) +
  theme_bw() +
  geom_histogram(binwidth = 400) +
  labs(x = "Length of Text", y = "number of texts",
       title = "Number of Texts by Length and Labels") 
  
set.seed(1)
# create 70%/30% split
indx <- createDataPartition(dat$label, times = 1, p = 0.7, list = FALSE)
train <- dat[indx,]
test <-  dat[-indx,]


