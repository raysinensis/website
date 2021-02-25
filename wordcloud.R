library(tidyverse)
library(tm)
library(wordcloud2)
text <- readLines("abstracts.txt")
docs <- Corpus(VectorSource(text))

docs <- tm_map(docs, content_transformer(tolower))

docs <- tm_map(docs, removeWords, stopwords("english"))
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, c("blabla1", "blabla2")) 
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)

dtm <- TermDocumentMatrix(docs) 
matrix <- as.matrix(dtm) 
words <- sort(rowSums(matrix), decreasing = TRUE) 
df <- data.frame(word = names(words),freq = words)

set.seed(21)
wordcloud2(data = df, size = 1, color= 'random-light')
