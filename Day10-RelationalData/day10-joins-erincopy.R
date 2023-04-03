library(tidyverse)
library(dplyr)

tweets <- read_csv("https://www.dropbox.com/s/rnaaglg5eaeou6s/Tweets.csv?dl=1")
mayors <- read_csv(file="https://raw.githubusercontent.com/jmontgomery/jmontgomery.github.io/master/PDS/Datasets/Mayors.csv")

# Two things to clean before we get started
tweets$TweetID <- as.character(tweets$TweetID)
mayors <- mayors %>%
  filter(!MayorID %in% c(1008, 1409))

# check them out
tweets
mayors

# Joins and linking variables -----

# Any join requires a common variable 
# We might use the Mayor's Twitter handle to join
# But the tweets dataset currently
# calls this column 'ScreenName'
tweets <- rename(tweets, TwitterHandle = ScreenName)

# let's check out this variable in both datasets
head(unique(tweets$TwitterHandle))
head(unique(mayors$TwitterHandle))

# what does this code do?
table(unique(tweets$TwitterHandle) %in% unique(mayors$TwitterHandle))
tweets <- tweets %>%
  filter(TwitterHandle %in% unique(mayors$TwitterHandle))


# Left join example -----

# In words, what is this doing?
# Is the output what you expected?
tweets2 <- dplyr::left_join(x = tweets,
                            y = mayors,
                            by = "TwitterHandle")

# it doubled in size!
object.size(tweets) + object.size(mayors)
object.size(tweets2)

# equivalently with piping
tweets %>%
  left_join(mayors, by = "TwitterHandle")


# Full join -----

# Unmatched y is included at the end
# In the context of this data, why are
# there unmatched y?
tweets %>%
  full_join(mayors, by = "TwitterHandle")


# Example: subset of columns -----

tweets %>%
  select(TwitterHandle, Text) %>%
  left_join(select(mayors, TwitterHandle, FullName, Ideology), 
            by = "TwitterHandle")

# TODO: Find the number of tweets per mayor and join this to the mayors data
# Hint: It requires adding 2 lines and editing 1 line above

tweet_count <- tweets %>%
  group_by(TwitterHandle) %>%
  mutate(n_tweets = n()) %>%
  select(TwitterHandle, Text, n_tweets) %>%
  left_join(select(mayors, TwitterHandle, FullName, Ideology), 
            by = "TwitterHandle")
tweet_count


# Example: left join to mayor data now -----

# Why `multiple = "first"` ?
mayors %>%
  select(MayorID, FullName, State, Ideology, TwitterHandle) %>%
  filter(State == "Indiana") %>%
  left_join(select(tweet_count, n_tweets, TwitterHandle),
            multiple = "first")

# TODO: repeat with inner join and explain what is happening
# Also grab different columns than what I did
# from each dataset you think are interesting

mayors %>%
  select(MayorID, FullName, State, Ideology, TwitterHandle) %>%
  filter(State == "Indiana") %>%
  inner_join(select(tweet_count, n_tweets, TwitterHandle),
            multiple = "first")



