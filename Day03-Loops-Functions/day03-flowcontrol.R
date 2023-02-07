# Flowcontrol (if, while, repeat)

## Flowcontrol makes your scripts less horrible.
## You'll find your scripts get *long*.
## Complex tasks turn into complex code
## Today we're working on efficiency,
##       speed, and readability.

## Idea 1: if you ever find yourself copy/pasting more
##       more than twice, you should write a loop or function.

## Idea 2: if you ever spend more than 20 mins
##       ~manually~ reshaping or editing data,
##       that should have been encoded for
##       replicability.

## Idea 3: some combination of the basic skills in today's
##       lessons can be used to solve most problems
##       (although it will take time to figure out how)


rm(list = ls()) #start fresh


## if ----

# Basic syntax:
# - input in parentheses can be anything that returns a logical
# - you can put anything in the braces

# if(condition){
#   commands to run
# }

if(TRUE){
  print("I got here!")
}

if(FALSE){ 
  print("I can't get here")
}

## Combining if with else ----

# if(condition){
#   commands to run when condition is TRUE
# } else {
#   commands to run when condition is FALSE
# }

x <- 10
if(x > 2) {
  print("X is larger than 2")
} else { 
  print("X is 2 or smaller")
}

# TODO: replace 10 with 1 and see what happens

# NOTE: if does not like vectors
if(c(3, 1) > 2){
  print("This is buggy")
}

## ifelse is fine with vectors ----

# Syntax:
# ifelse(condition, return when condition T, return when condition F)

x <- c(0, 2)
ifelse(x > 1, "yes", "no")

## Style guide

# You don't technically need the braces if you have a one-line command
# BUT you should almost always use them so others can read your code
x <- 3
if (x > 2) {
  y = 2 * x 
}else{
  y = 3 * x
} 
y


## while and repeat ----

# while(condition){
#   commands that repeat until condition flips to FALSE
#   (therefore, need to check condition inside loop)
# }

x <- 1
while(x < 5) {
  print(x)
  x <- x + 1 #note I'm updating the condition!
}

# repeat{ stuff to do until it sees break}

x <- 1
repeat{
  print(x)
  x <- x + 1
  if (x == 5) { 
    break #notice this is a function
  }
}

# NOTE: you need to be very careful with while loops
#       if you don't have a break, it will be an infinite loop!
#       You'll have to manually break the loop, which can
#       crash R.


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
vote_df$vpct <- vote_df$tv / vote_df$vap

# vectorized
vote_df$vpct_dummy <- ifelse(vote_df$vpct > .4, T, F)
head(vote_df)

if(vote_df$tv[2] < 1000000){
  print("less than 1mil")
}

# single element
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


# complex conditions
this_tv <- vote_df$tv[2]
this_pctdummy <- vote_df$vpct_dummy[2]
if(this_tv < 1000000 & this_pctdummy){
  print("less than 1mil AND greater than 40% turnout")
}else{
  print("...")
}




