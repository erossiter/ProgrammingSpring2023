#############################
# R Objects and Basic Syntax
#############################

## Note: We will be moving quickly.  I assume this is all very familiar.

## Goals:
# 1. Logistics of running R in RStudio
# 2. Calculate simple arithmetic
# 3. Assign a value to an object
# 4. Types of Data
# 5. Logical statements

## Layout (Four windows):
# Editor: Top left window. The .R or .Rmd "scripts" or files. Where you edit
# Console: Bottom left window. Displays executed code and output.
# Workspace: Top right window. All active objects, history of commands, etc.
# Plots and help files: Bottom right window.

## Comments
# Anything that comes after a "#" sign.
# Comments describe what the code is doing.

## Running R code
# To send a line of code to your console...
# 1. Choose code
# - put cursor on the line of code, or
# - highlight exact code you want to run
# 2. Run it
# - (PC users) "control + enter"; (Mac users) "command + return", or
# - highlight and hit "Run" at top of Editor (not recommended), or
# - copy and paste the line of code (not recommended) 
print("Hello world")
print("My name is Erin")


## Side note on code in .Rmd vs. .R files
# Everything we're talking about applies when
# the R code is inside an .Rmd code chunk!!!
# You'll often work in a .R script instead,
# so we want to be comfortable with both.


## Features
# - R is case sensitive (it is also spelling sensitive)
# - R comes with many basic functions.
# - Additional functionality are available in user-contributed packages
#   that can be downloaded, loaded, and used.
library("ggplot2")


## R as a calculator
# Basic arithmetic
2 + 3  #addition
2*3  # multiplication
5/3 #division
4 - 5 #subtraction
3^3 # exponents
625^(1/4) # More exponents
log(10) # natural log

# R follows the order of operations
3+4/2 
(3+4)/2 
2*(3-4)+2
2*(3-4)+2*(4 + 3)^(1/3)


# R comes with a number of constants pre-stored that you can use
6.25 # numbers
pi # And a few others
NA # Missing value
NULL # Nothing.
0/0 # NaN means "Not a number"
NaN
1/0 # Inf means infinity
Inf

# Tip: Use the up and down arrows to access previously typed commands


## Objects and named storage
# The "<-" and "=" symbols are used to *assign* a variable to a value.
# This is called "assignment", and these are "assignment operators"
a <- 7 # after running this line, now R considers `a` as the number 7
b = 8 # after running this line, now R considers `b` as the number 8
# Print the values.
print(a)
print(b)
# or simply
a
b

# We might call `a` and `b` "objects" or "variables"

## Using objects
a + 3 # because `a` is a number, we can perform math
a <- 4 # You can change the value an object takes  by executing this command
a
a + 3


## Vectors:
# - an ordered sequence of elements of the same data type
# - like a "list", but we don't call it that,
#   because list means something specific in R
c(1,4,9) # built-in command is `c()`
my_vec <- c(1,2,3)
my_vec
my_vec[3] # ordered
my_vec*4 # math is "vectorized" -- applied to each element
my_vec + 4
my_vec - 4
my_vec / 4


## Beyond numbers
# three data types: numeric, character, and logical	

# numeric are numbers
numeric_vector <- c(1,2,3,4,5)
numeric_vector

# strings
# using quotation marks tells R we're working with this data type
string_vector <- c("Erin", "Peitong", "Leonard")
string_vector
string_vector + 1 #Error! R knows it can only do math with certain object types

# logicals
# TRUE, FALSE, NA (must be all caps, that's who R knows what you mean)
logical_vector <- c(TRUE, TRUE, FALSE, TRUE)
logical_vector

# Tip: Did you notice RStudio gives different object types different colors?

## More operations using logicals
# R knows how to compare objects as greater than, less than, or equal to each other
4 < 5 #strictly less than
4 <= 4 # less than or equal to
4 > 5 # strictly greaeter than
4 >= 5 # greater than or equal to
4 == 4 # equal #one = is assignment
4 != 5 # not equal

# More logical operators and truth tables
# https://sites.millersville.edu/bikenaga/math-proof/truth-tables/truth-tables.html
! (4 < 5) # read `!` as "NOT", it is negation

ages <- c(16, 17, 22, NA)
mean(ages[!is.na(ages)])
mean(ages, na.rm = T)

a <- TRUE
b <- TRUE
c <- FALSE
d <- FALSE

# `&` means "AND"
a & b # T AND T is T 
a & c # T AND F is F
c & d # F AND F is F

# `|` the "pipe" means "OR"
a | b # T OR T is T 
a | c # T OR F is T 
c | d # F OR F is F


# Example putting things together
total_votes <-  238307
voting_age_population <- 496387
turnout <- total_votes/voting_age_population
turnout

# Task: use R to see if turnout was 50% or more
turnout >= .50

# Tip:
# - Objects are stored in the "global environment"
# - You can easily see what you're working with
# - These can be accessed at any time

ls()

# - You can also remove files from global environment

hi <- "hi! :)"
rm(hi)

hi <- "hi! :)"
bye <- "bye :("
rm(list = c("hi", "bye"))

rm(list = ls()) #removes ~everything~ 

# Tip: comment multiple lines of code with command + shift + c (mac)



