# stringr -------
# Great cheatsheet: https://github.com/rstudio/cheatsheets/blob/main/strings.pdf

# Data - do not share
# Mayoral tweet data
library(tidyverse)
tweets <- read_csv("https://www.dropbox.com/s/rnaaglg5eaeou6s/Tweets.csv?dl=1")

# Don't remove `tweets` from R environment if it took awhile
# to load, we'll keep using it throughout class

# A single tweet & several useful tools
t <- tweets[1,]$Text
t

# String length
str_length(t)

# Old tool
nchar(t)

# Split at spaces
# Notice it returns a list
words <- str_split(t, pattern = " ")
words

# Dealing with 1-element lists
words[[1]]
unlist(words)

# Old tool
strsplit(t, split = " ")


# Join back into one string
str_c(words, collapse = " ") # Mad bc it is a list
str_c(unlist(words), collapse = " ")

# Old tool
paste0(unlist(words), collapse = " ")

# More options with concatenating strings
str_c(unlist(words), collapse = "! ")
str_c(unlist(words), "AFTER", sep = " ")
str_c("BEFORE", unlist(words), "AFTER", sep = " ")
str_c("BEFORE", unlist(words), "AFTER", sep = " ", collapse = " ")

# String subsetting 
colors <- c("red", "yellow", "blue", "green", "magenta", "cyan")
str_sub(colors, start = 1, end = 3)
str_sub(colors, start = -3, end = -1) #count back from the end
str_sub(colors, start = 2, end = 10) # Robust to going out of index

# Can also assign to those indices
str_sub(colors, start = 1, end = 3) <- str_to_upper(str_sub(colors, start = 1, end = 3))
# Notice it updated our `colors` vector
colors


# More editing
colors <- str_to_lower(colors)
colors

# Works on vectors, too
t5 <- tweets$Text[1:5]

str_split(t5, pattern = " ") #that's why it returns a list
str_to_lower(t5)
str_to_title(t5)
str_to_upper(t5)
str_count(t5)

# A few more functions
# Locate pattern matches *within* strings
str_locate(t5, pattern = "https://")

# Like `which` function, returns indices with matches
str_which(t5, pattern = "#EarthDay")

# Adds lines breaks `\n`
str_wrap(t5, width = 50)



