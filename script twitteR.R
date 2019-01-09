install.packages("twitteR")
install.packages("wordcloud")
install.packages("tm")

library("twitteR")
library("wordcloud")
library("tm")

# Windows
download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")

#obter através do twitter
consumer_key <- ""
consumer_secret <- ""
access_token <- ""
access_secret <- ""
setup_twitter_oauth(consumer_key,
                    consumer_secret,
                    access_token,
                    access_secret)
tweets <- searchTwitter("Lula", n=1000,lang="pt")

text <- sapply(tweets, function(x) x$getText())
corpus <- Corpus(VectorSource(text))
corpus = tm_map(corpus,content_transformer(function(x) iconv(x, to="latin1", from="utf-8")))
corpus = tm_map(corpus,content_transformer(function(x) iconv(x, to="latin1", from="utf-8")))
corpus = tm_map(corpus,content_transformer(function(x) iconv(x, to="utf-8", from="latin1")))

corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
mystopwords<-c(stopwords("pt"),"pra","lula","qualquer")
corpus <- tm_map(corpus, removeWords, mystopwords)

library(wordcloud)
windows()
wordcloud(corpus, min.freq = 2, max.words = 500, random.order = F,colors=brewer.pal(8,"Dark2"))
