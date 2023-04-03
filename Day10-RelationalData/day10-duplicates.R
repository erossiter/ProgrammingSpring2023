# Restarting environment
rm(list = ls())
library(tidyverse)
library(dplyr)

tweets <- read_csv("https://www.dropbox.com/s/rnaaglg5eaeou6s/Tweets.csv?dl=1")
mayors <- read_csv(file="https://raw.githubusercontent.com/jmontgomery/jmontgomery.github.io/master/PDS/Datasets/Mayors.csv")

# One thing to clean before we get started
tweets$TweetID <- as.character(tweets$TweetID)
tweets <- rename(tweets, TwitterHandle = ScreenName)

# The joins we did, mayor-level info was added
# to all of the tweets for that mayor.

# We didn't have duplicate mayors (I checked first!)

# Joins when there are duplicates lead to creation
# of new rows for **all possible combinations**

# Not a good unique ID for our joins!!
mayors %>% 
  count(TwitterHandle) %>%
  filter(n > 1)

# Manually check what happened
dup_mayors <- mayors %>%
  filter(TwitterHandle == "robertgarcialb" | TwitterHandle == "rodhiggins2017")


# Joins with duplicates -----

# subset to just the Tweets for these mayors
dup_mayors_tweets <- tweets %>%
  filter(TwitterHandle == "robertgarcialb" | TwitterHandle == "rodhiggins2017")

# Repeat the left join
# What's happening????
dup_mayors_tweets %>%
  select(TwitterHandle, Text) %>%
  left_join(select(dup_mayors, TwitterHandle, State), 
            by = "TwitterHandle")

# Two options:
# 1. `multiple = "all"` if that is appropriate for your data
#    Ex: If we had information at 2 time periods for the Mayors
# 2. Manually clean your data!!!

mayors <- mayors %>%
  filter(!MayorID %in% c(1008, 1409))

# ah... better.
dup_mayors_tweets %>%
  select(TwitterHandle, Text) %>%
  left_join(select(mayors, TwitterHandle, State), 
            by = "TwitterHandle")


# anti-join -------

# drops all observations in x that have a match in y.
# can be useful for debugging and cleaning!

tweets %>%
  select(TwitterHandle, Text) %>%
  anti_join(select(mayors, TwitterHandle, State), 
            by = "TwitterHandle")


# semi-join ------

# keeps all observations in x that have a match in y
# (but doesn't actually do the join)
# again, can be helpful for debugging and cleaning

tweets %>%
  select(TwitterHandle, Text) %>%
  semi_join(select(mayors, TwitterHandle, State), 
            by = "TwitterHandle")
