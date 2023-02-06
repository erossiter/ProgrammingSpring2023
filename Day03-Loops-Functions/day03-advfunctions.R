# Functions

## We've already talked about functions!
## Functions can do more than what we've discussed.
## Understanding functions helps you keep your code organized,
## and helps you better understand other people's functions.


rm(list = ls()) #start fresh


## function basics ----

# Basic syntax:
# - a function is a named object
# - as many inputs as you want
# - do stuff with the inputs...
# - return a single output


# function_name <- function(x1, x2, ...) {
#   do stuff here with arguments
#   return(output)
# }

# Three ways to write a function
 
# (1) 
my_function <- function(x) { # take in a value of x
  y = x^2 + 3*x - 2 # conduct operations using the input values
  return(y) # return some value. 
  # In this case we are returning a simple numeric value
}

# (2) 
my_function2 <- function(x) {
  x^2 + 3*x - 2 
  # You don't have to specify a return
  # R will return the last line
}

# (3)
my_function3 <- function(x) x^2 + 3*x - 2
# Dropping the brackets -- usually a bad idea!

# Test it out
my_function(1)
my_function2(1)
my_function3(1)

# Also it is magically vectorized!  Why?
my_function(1:5)
my_function2(1:5)
my_function3(1:5)


## Multiple arguments and outputs ----

# What are the inputs to this function?
# How did I get "multiple" outputs?
advanced_function <- function(pid, age, vote){
  mean_ages <-  c(mean(age[pid == "R"]), mean(age[pid == "D"]))
  names(mean_ages) <- c("R", "D")
  
  mean_vote <-  c(mean(vote[pid == "R"]), mean(vote[pid == "D"]))
  names(mean_vote) <- c("R", "D")
  
  sizes <-  c(sum(pid == "R"), sum(pid == "D"))
  names(sizes) <- c("R", "D")
  
  output <- list(sample_size = sizes,
                 age_by_party = mean_ages,
                 vote_by_party = mean_vote)
  return(output)
}

# Generate some fake data
set.seed(13234)
df <- data.frame(age = sample(20:80, 20, replace = T),
                 pid = sample(c("R", "D"), 20, replace = T),
                 vote = sample(c(0,1), 20, replace = T))

# When you call the function, you can specify what
# data goes with what argument...
advanced_function(pid = df$pid,
                  age = df$age,
                  vote = df$vote)

# if you don't specify, it is order specific 
advanced_function(df$pid, df$age, df$vote)
advanced_function(df$age, df$pid, df$vote) #breaks


## Nesting functions and defaults ----

ra <- function(n = 2){
  out <- paste0(rep("ra", times = n), collapse = "-")
  return(out)
}

ah <- function(n = 3){
  out <- paste0(rep("ah", times = n), collapse = "-")
  return(out)
}

roma <- function(n = 1){
  out <- paste0(rep("roma", times = n), collapse = "-")
  return(out)
}

roma_ah <- function(n = 1){
  out <- paste0(rep("roma-ah", times = n), collapse = "-")
  return(out)
}

bad_romance <- function(n = 1){
  lyric <- paste(ra(), ah(), roma(), roma_ah())
  out <- paste0(rep(lyric, n), collapse = "! ")
  return(out)
}

bad_romance()
bad_romance(n = 10)


