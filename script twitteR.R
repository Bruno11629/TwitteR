install.packages("twitteR")
install.packages("wordcloud")
install.packages("tm")

library("twitteR")
library("wordcloud")
library("tm")

#necessary file for Windows
download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")

consumer_key <- "t8v5RgdbEvUfC8M4EogncFskK"
consumer_secret <- "CJr2FJIQ9wMqyqBluT0bGNvlVkuupk9ka1RBDBmQK8BO3zaOfp"
access_token <- "2845838632-SUyWz2743RjrghLt1POSf50yGm6INNEc2FYkSHi"
access_secret <- "ZDnAtL4bUGn1X9UdBIbU6lutdVWvoyO0S5lkJlDO8TaHJ"
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
