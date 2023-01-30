rm(list=ls())

# Review ----

# As technically and as thoroughly as you can,
# describe what is going on when we
# execute this line of code:
ages <- c(25, 30, 32, 48, 77, 81, 20, 21)


# Accessing elements of a vector ----

# We access elements by position using:
# - integers to indicate the element positions/indices to access
# - logicals where TRUE indicates the positions/indices to access

ages[1] #first element
ages[c(TRUE, rep(FALSE, 7))] #first element
ages[2:4] #second through fourth element
ages[c(1,3,5,7)] #odd elements
ages[seq(1, 7, by = 2)] #what is this doing?

# Tip: run parts of code, gradually adding
#      in complexity, to see what is happening.
#      In other words, play!

# What is this doing?
# Run from the inside out
ages[which.max(ages)]

# What is this doing?
# Run from the inside out
ages[ages > mean(ages)]

# Negative integers *remove* elements
ages[-1]

# So far, we haven't updated our storage of the 
# `age` object
ages_young <- ages[-which(ages > 60)]
ages_young

# However, do not mix positive and negative integers
ages[c(-2,3)]


# Review classes ----

# There are lots of "types" of objects in R
# Classes indicate the properties of an object
# Core classes in R:
#   - numeric
#   - logical
#   - character (i.e., string)

class(mean)

class(ages)
is.numeric(ages)

ages_old <- (ages > 60)
class(ages_old)

# Functions have different instructions depending on the class

mean(ages)

mean(ages_old) # what is happening here?

ages_str <- as.character(ages)
mean(ages_str)

# Packages often create their own classes
# and functions are given specific instructions
# for the class
data(cars)
mod <- lm(speed ~ dist, data = cars)
class(mod)
plot(mod)
