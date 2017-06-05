#must rename column with the text to be analyzed "comment"
#must have an "id" column
#the api cannot hold more than 1000 documents in one call

rm(list = ls())

data <- read.csv("data/apiMovieQuotes.csv")
colnames(data)[2] <- "comment"
colnames(data)[1] <- "id"

source("run.R")
key <- "<your API key>"
df <- run(data, "returnData/answer.csv", key)
