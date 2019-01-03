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
library(doSNOW)

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

prop.table(table(train$label))
prop.table(table(test$label))


train_tokens <- tokens(train$text, what = "word",
                     remove_numbers = TRUE, remove_symbols = TRUE,
                     remove_punct = TRUE, remove_hyphens = TRUE  )
                     

train_tokens <- tokens_select(train_tokens, stopwords(), selection = "remove")
train_tokens <- tokens_wordstem(train_tokens, language = "english")
train_tokens
View(train_tokens)

zx <-prop.table(table(train_tokens$label))
zx


train_tokens.dfm <- dfm(train_tokens)
train_tokens.dfm <- as.matrix(train_tokens.dfm)
train_tokens.dfm[1:20, 1:100]
dim(train_tokens.dfm)

train_tokens.df <- cbind(TLabel = train$label, as.data.frame(train_tokens.dfm))
names(train_tokens.df)[c(10, 50, 70)]
names(train_tokens.df) <- make.names(names(train_tokens.df))
names(train_tokens.df)[c(10, 50, 70)]

set.seed(2)
cv.folds <- createMultiFolds(train$label, k = 10, times = 3)
cv.Cntrl <- trainControl(method = "repeatedcv",number = 10, repeats  = 3, index=cv.folds)
cl <- makeCluster(3, type="SOCK")
registerDoSNOW(cl)


rpart.cv.1 <- train(TLabel~., data= train_tokens.df, method='rpart',
                    trControl = cv.Cntrl, tuneLength = 7 )
  
stopCluster(cl)


#results
rpart.cv.1

  
  
  