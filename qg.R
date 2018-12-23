library(tidyverse)
library(rvest)
library(magrittr)
library(stringr)

webpage <- read_html("https://en.wikipedia.org/wiki/Albert_Einstein")
table <- webpage %>% 
  html_nodes("table.vcard") %>%
  html_table(header = F)
table <- table[[1]]
dict <- as.data.frame(table)
