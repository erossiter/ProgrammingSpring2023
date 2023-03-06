# regular expressions -------

# Describes a pattern of text
# Can be used to:
# - check for the existence of a pattern
# - extract matches of a pattern (i.e., substrings) from longer strings
# - help edit the text

# Most of what you're going to want to do will
# involve looking for patterns!
# - Potential is limitless and can be as complex as you want it
# - Whatever you need to do, it is probably possible.

# Example: phone numbers all in different formats... need to clean it up

# Regular expressions have their own syntax.
# - Syntax common, not specific to R
# - Most frustrating thing is syntax uses things like:
#      `(`, `\`, `.`, `*`, `?`, `{`
#   which are things you might be **looking for**!


# We can't cover it all today.  Some things you can do:
# - Find a specific pattern
# - Find a approximate pattern
# - Matching only on the start of a string
# - Match only to the end
# - Match only to a complete string
# - Matches based on white space
# - Matches based on sets 
# - Matches based on digits
# - Matches based on patterns *within* the characters (e.g., letter repetition)


# -----------------------------

# Data - do not share
# Mayoral tweet data
# library(tidyverse)
# tweets <- read_csv("https://www.dropbox.com/s/rnaaglg5eaeou6s/Tweets.csv?dl=1")


# ------------------------------
# How to find matches?


# Play with basic patterns to start
# str_view_all highlights the matches
t3 <- tweets$Text[1:3]

# Basic pattern matches
str_view_all(string = t3, pattern = "#EarthDay")
str_view_all(string = t3, pattern = "to")
str_view_all(string = t3, pattern = "a")

# Need what is called "escapes"
# because period '.' means something else
# we will get to in a second
str_view_all(string = t3, pattern = "\\.")

# '(' also means something else in regex
str_view_all(string = t3, pattern = "\\(")


# Helpers
str_view_all(string = t3, pattern = "[:digit:]")
str_view_all(string = t3, pattern = "[:punct:]")
str_view_all(string = t3, pattern = "[:alpha:]")
str_view_all(string = t3, pattern = "[:space:]")

# Word boundaries
str_view_all(string = t3, pattern = "\\b")

# Digits (repetitive)
str_view_all(string = t3, pattern = "\\d")

# Whitespace (repetitive)
str_view_all(string = t3, pattern = "\\s")


# ------------------------------
# Adding logic

# '|' means or
str_view_all(string = t3, pattern = "a|e|i")
str_view_all(string = t3, pattern = "Earth")
str_view_all(string = t3, pattern = "Many|Earth")

# brackets mean any
# (more important when we're pulling words out etc)
str_view_all(string = t3, pattern = "[aei]")

# anything *except*
str_view_all(string = t3, pattern = "[^aei]")

# ------------------------------
# Adding locations

# Start of a string
str_view_all(string = t3, pattern = "^Many")

# End of a string
str_view_all(string = t3, pattern = "Many$")
str_view_all(string = t3, pattern = "D$")


# ------------------------------
# Using our new regex skills!

# `str_detect`: TRUE/FALSE on whether there is a match
# `str_subset`: Subset down to strings with a match
# `str_count`: Counts number of matches within a string
# `str_extract`: Pull out the first matches from the string
# `str_extract_all`: Pull out all actual matches from the string


str_detect(t5, pattern = "EarthDay")
str_subset(t5, pattern = "EarthDay")
str_count(t5, pattern = "EarthDay")
str_extract(t5, pattern = "EarthDay")

str_detect(t5, pattern = "thank|Thank")
str_subset(t5, pattern = "thank|Thank")
str_count(t5, pattern = "thank|Thank")
str_extract(t5, pattern = "thank|Thank")



# ------------------------------
# More examples (there are countless things you can do...)

# Note the "." is any character
str_extract(t5, pattern = "^.")
str_extract(t5, pattern = "^...")

# Note the "+" means one or more
# What's going on here?
str_extract(t5, pattern = "^[:alpha:]+")

# What about here?
str_extract(t5, pattern = "^[:alpha:]+\\s[:alpha:]+")
str_extract(t5, pattern = "^[:alpha:]+\\s[:alnum:]+")

# ------------------------------
# Let's look for all times, even getting the am and pm
# How would we do this?

# Take only start of string, every character, up through 'https'
# (Note, text can be bulky, and might be slow on your computer!)
t_nolink <- str_extract(tweets$Text, pattern = "^.+https")

# Just strings with digits
t_digits <- str_subset(t_nolink, pattern = "[:digit:]")
length(t_digits)

# Now, use the 'view all' function to make sure it is working
# as you build

# Assumes it doesn't start the string and is preceded by a space
# ...allows for one or more digits
str_view_all(t_digits[1:100], pattern = "\\s[:digit:]+[pm|am|:|\\s]")

# Building it out more... what's going on?!
str_view_all(t_digits[1:100], pattern = "\\s[:digit:]{1,2}:?[:digit:]{0,2}\\s?(a|p)m")

# Added in "case insensitive flag"
all_times <- str_extract(t_digits, pattern = "[:digit:]{1,2}:?[:digit:]{0,2}\\s?(?i)(am|pm)")
all_times <- all_times[!is.na(all_times)]
length(all_times)

# Still got radio stations :(
all_times
