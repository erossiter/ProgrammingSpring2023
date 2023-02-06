# The mighty for loop

## The for command is probably the most common flow control option.
## It has three basic parts:
## (1) An object name that will be used in the following commands
## (2) A vector that we will "loop over"
## (3) Commands that will be executed for each value of the vector


rm(list = ls()) #start fresh


## for ----

# Basic syntax:

# for(name in vector){
#   execute these commands using each value of the vector
# }

# Each loop does the equivalent of
# cat = "Leonard"
# cat = "Pogo"
# ... 
for(cat in c("Leonard", "Pogo")) {
  print(cat)
}

# Or more commonly, looping over integers
for (i in 1:10){
  print(i)
}

# iterate over 5 state abbreviations
states <- c("IA", "NE", "MO", "IN", "IL")
for(i in states){
  print(i)
}

# but the the "iterator" can be anything!
for(s in states){
  print(s)
}

# we usually use for loops because we need to apply
# an operator to every element of a vector
for(x in 1:5){
  print(x*2)
}

# usually it's something more complex than this example
# where we can't do vectorized operations
my_vec <- 1:5
my_vec*2


# something with more conditions and operations
results <- rep(NA, 10)
for(i in 1:10){
  if(i < 5){
    results[i] <- "less than 5"
  }else{
    results[i] <- "5 or more"
  }
}
results

# another way to store information
# append to an empty vector
results <- c()
for(i in 1:10){
  if(i < 5){
    results <- append(results, i)
  }
}
results

## for loops are very useful in many situations
plot(NULL, xlim = c(1, 10), ylim = c(0, 1))
for (i in 1:10) {
  points(x = i, y = 1/i)
}

## next and break ----

# Sometimes you might not want to execute the
# commands for every element in the vector, so
# use the next command to skip (you can also use the break)

# Run this and explain what is happening
some_odds <- c()
for(i in 1:200) {
  if(i %% 2 == 0) {
    next #next stops the current iteration and moves to next iteration
  }
  some_odds = c(some_odds, i)
}
some_odds

## style guide again ----

# Technically, you don't have to be so formal,
# But the indenting and braces are there for
# the protection of your future self
# AND so other can read it
for(i in 1:10) print(i)


## Examples ----

# voting age population
vap <- c(3481823, 496387, 4582842, 2120139,26955438,
         3617942,2673154,652189,472143,14085749,6915512,
         995937,1073799,9600372,4732010,2265860,2068253,
         3213141,3188765,1033632,4242214,4997677,7620982,
         3908159,2139918,4426278,731365,1321923,1870315,1012033,
         6598368,1452962,14838076,6752018,494923,8697456,2697855,
         2850525,9612380,824854,3303593,594599,4636679,
         17038979,1797941,487900,5841335,4876661,1421717,
         4257230,392344) 
# total votes
tv <- c(NA, 238307, 1553032, 780409,8899059,1586105, 
        1162391,258053, 122356,4884544, 2143845,348988, 
        458927,3586292, 1719351,1071509, 864083,1370062, 
        954896,NA, 1809237, 2243835,3852008, 2217552,NA, 
        2178278, 411061,610499, 586274,418550, 2315643,568597, 
        4703830,2036451, 220479,4184072, NA,1399650, NA,392882, 
        1117311,341105, 1868363,NA, 582561, 263025,2398589, 
        2085074,473014, 2183155, 196217)

vote_df <- data.frame(vap = vap, tv = tv)

# remember this?
this_tv <- vote_df$tv[2]
if(this_tv < 1000000){
  print("less than 1mil")
}else if(this_tv > 1000000){
  print("greater than 1mil")
}else if(this_tv == 1000000){
  print("equal to 1mil")
}else{
  print("NA or problem!")
}


# Putting it inside a for loop to evaluate
# all elements
for(i in 1:nrow(vote_df)){
  this_tv <- vote_df$tv[i] # the critical line that changed
  if(is.na(this_tv)){
    print("NA value")
    next
  }
  
  if(this_tv < 1000000){
    print("less than 1mil")
  }else if(this_tv > 1000000){
    print("greater than 1mil")
  }else if(this_tv == 1000000){
    print("equal to 1mil")
  }else{
    print("NA or problem!")
  }
}

