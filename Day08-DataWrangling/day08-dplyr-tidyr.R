## dplyr

library(dplyr)
library(tidyr)
library(readr)
primaryPolls <- read_csv('president_primary_polls_feb2020.csv')
primaryPolls$start_date <- as.Date(primaryPolls$start_date, "%m/%d/%y")

## filter -----
# allows you to easily subset data using conditions
# as we have done before using accessors

dim(primaryPolls)

# Just Klobuchar rows
ak <- filter(primaryPolls, candidate_name == c("Amy Klobuchar"))
dim(ak)


# Or you can include multiple conditions
# Everything you have already learned about boolean operators applies here.


ak_nh <- filter(primaryPolls$, 
                candidate_name == c("Amy Klobuchar"), 
                state == "New Hampshire")

dim(ak_nh)


## arrange -----
# *organizes* the data by rows
# intsead of subsetting by rows

arrange(primaryPolls, state)

# Or in descending order
arrange(primaryPolls, desc(state))


## select -----
# a much easier way to subset by column by name

select(primaryPolls, state, candidate_name, start_date)


## more tricks -----
# It comes with a nice syntax for doing this without listing all!
# - `var1:var20` will select all columns between these two
# - `-var1:var20` will select everything *except* that range
# - `starts_with("cand")` will select columns that start with "cand"
# - Similar functionality for `ends_with()`, `contains()`, and `matches()`

# some examples
select(primaryPolls, starts_with("polls"))
select(primaryPolls, poll_id:state)

# A fun trick to move your favorite variable(s) to the front,
# but keep everything!
select(primaryPolls, state, candidate_name, start_date, everything())

# renaming columns
basicPolls <- select(primaryPolls, state, candidate_name, start_date, pct)
# newname = oldname
rename(basicPolls, candidate = candidate_name)


# `mutate`-----
# allows us to create a new variable that is a function of others
# (note to save new var needs to save to object)
mutate(basicPolls, proportion = pct/100)

# transmute -----
# same as mutate, but if we don't want to keep the original variables
transmute(basicPolls, proportion = pct/100)
transmute(primaryPolls, numberRespondents = round((pct/100)*sample_size))

# multiple vars
transmute(primaryPolls, 
          proportion = pct/100,
          numberRespondents = round(proportion*sample_size))


# - Note that you can use a ton of the basic functions 
#   we have already covered like `sum`, `mean`, `sqrt`, etc.
# - This includes logical comparisons


# summarise -----
# easily extract summary statistics

summarise(basicPolls, average_candidate = mean(pct), count = n())

# group_by ----
# makes summaries even more powerful!

# Now operations will be performed by groups
# defined by the candidate's names
basicPolls_grouped <- group_by(basicPolls, candidate_name)
summarise(basicPolls_grouped, 
          average_candidate = mean(pct),
          count = n())

# Groups defined by candidate and state of poll!
basicPolls_grouped <- group_by(basicPolls, candidate_name, state)
summarise(basicPolls_grouped, 
          average_candidate = mean(pct),
          count = n())

# Super powerful!