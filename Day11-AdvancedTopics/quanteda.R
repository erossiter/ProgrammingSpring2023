# Text as data in R using Quanteda
# Amazing text-as-data package in R
# http://quanteda.io/


#install.packages("quanteda")
library(quanteda)

# Creating a DTM -----------

# raw text
?data_corpus_inaugural
data_corpus_inaugural

# tokens
?tokens
toks <- tokens(data_corpus_inaugural,
               remove_punct = T,
               remove_symbols = T,
               remove_numbers = T,
               remove_separators = T)
toks


toks_nostop <- tokens_select(toks,
                             pattern = stopwords("en"),
                             selection = "remove")


# DFM (document "feature" matrix)
?dfm
inaug_dfm <- dfm(toks, tolower = T)
dim(inaug_dfm)

inaug_dfm_nostop <- dfm(toks_nostop, tolower = T)
dim(inaug_dfm_nostop)

# Trim further
# Note that dfm dimensions are updated accordingly

inaug_dfm_nostop <- dfm_trim(inaug_dfm_nostop, min_termfreq = 10, min_docfreq = 2)
dim(inaug_dfm_nostop)

# Exploring
topfeatures(inaug_dfm_nostop, 20) 
topfeatures(inaug_dfm_nostop, 20, decreasing = F) 

# quanteda cleaning/organization still can be used by
# other packages with other methods


# Topic model ---------------------

#install.packages("stm")
library(stm)
my_topic_model <- stm(inaug_dfm_nostop, K = 10, verbose = FALSE)
plot(my_topic_model)   
labelTopics(my_topic_model)

