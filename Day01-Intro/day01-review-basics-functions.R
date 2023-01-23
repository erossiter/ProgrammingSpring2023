#############################
# Functions
#############################

rm(list = ls())

# Functions are objects that contain a list of instructions
# We "call" a function to execute a command
# A function has inputs and outputs

# Example: f(x) = x^2
#   - "f of x equals x squared"
#   - x is the input; a placeholder
#   - x^2 is the output; what to do with x
# f(x=2) = 2^2 = 4


# In R:
f <- function(x){
  return(x^2)
}
f(x = 2)
f(3)
f(4)


# Syntax must have
# function_name <- function(var1, var2, ...){
#   do whatever with var1, var2, ...
#   return(output)
#}


# Example 1:

# Need to read in our function, then you'll
# see it in the environment panel
sum_of_squares <- function(x, y){
  return(x^2 + y^2)
}

# Then, we can use it with different values 
sum_of_squares(x = 2, y = 3)
sum_of_squares(x = 1, y = 1)

mynum <- 5
sum_of_squares(x = mynum, y = 1)
sum_of_squares(mynum, 1)

# x and y are defined only in the "local environment" of the function
# notice they are not in the global environment! We can't access them:


# Example 2:

# This is equivalent to sum_of_squres()
# but we break the operations out over multiple lines
# NOTE:  "return statement" must be on the last line
sum_of_squares2 <- function(x, y){
  x_sq <- x^2
  y_sq <- y^2
  return(x_sq + y_sq) #
}
sum_of_squares2(x = 2, y = 3)


# Built-in functions

# NOTE: Why use functions? Any time you you use code repeatedly
# to do a task, you should think of making it into a function.
# That's why we have so many "built-in" functions to make life easier.

data("USArrests")
sum(USArrests$Assault)
mean(USArrests$Assault, na.rm = T)
boxplot(USArrests$Assault)
print("hi")
x <- 1
y <- 2
x + y # a function!
mean(c(1,2,3))



# Functions with vectors

# Many functions have been "Vectorized"
# meaning that they work on each element in the vector
# or "elementwise" operations
x <- 1:5 # vector
x + 1 # + is a Vectorized function
x^2
y <- 1:5
x*y

# Other functions use the whole vector as its input
x <- 1:5 
mean(x)
sum(x)
length(x)
summary(USArrests$Assault)
max(USArrests$Assault)

# Some functions evaluate each element
is.na(USArrests$Assault)
sum(USArrests$Assault > 100)


# Some functions will create vectors as outputs
rep(1, 5)
seq(1, 21, by = 2) # Make the sequence 1 to 21 moving by increments of 2
rep(seq(2, 20, by = 2), 2) # Repeat the pattern 2, 4, ... 20, twice
rep(c(1,4), each = 3) # Repeat each value 3 times


# WARNING!!  VECTOR RECYCLING!

# When vectors have different lengths, the shorter one is extended
# by repeating the vector.

# This means two things:
# 1. The vector lengths must be multiples of each other
# 2. This is a very easy way to make a bad, bad mistake.

# Example: say we wanted to add the murder and assault arrests
# for each state... what is this code doing?
USArrests$Murder[1:5] + USArrests$Assault
USArrests$Assault*100000

