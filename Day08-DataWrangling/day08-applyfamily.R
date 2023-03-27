## Base R apply functions
## More practice and advanced features
library(plyr)

## apply -----

# Our basic example again
ex_mat <- matrix(rep(1:3, 3), ncol = 3)
ex_mat

# Sum each row
apply(ex_mat, 1, sum)

# Sum each column
apply(ex_mat, 2, sum)

# Now in plyr
aaply(ex_mat, 1, sum)
aaply(ex_mat, 2, sum)


## Using custom functions -----

# using a user defined function
sum_plus_two <- function(x){
  sum(x) + 2
}

# What is this doing?
apply(ex_mat, 1, sum_plus_two)

# Or, write the function in-line.
apply(ex_mat, 1, function(x) sum(x) + 2)


## Functions with arguments -----

# Of course many functions have more than one argument.
# That's where the `...` comes in handy.
# Anything you pass will then be passed into the function.


# A simple function with two arguments
sum_plus_y <- function(x, y){
	sum(x) + y
}
x
# Apply the function to an matrix specifying the argument
apply(ex_mat, 1, sum_plus_y, y = 3)

# Equivalently
apply(ex_mat, 1, function(x, y) sum(x) + y, y = 3)

# plyr
aaply(ex_mat, 1, function(x, y) sum(x) + y, y = 3)



## Replacing loops -----

# A useful application of this is using a "dummy sequence"
# The "data" argument is the dummy sequence and it is only used
# to specify how many iterations we would like to have the function executed. 

# Example 1

# example loop
out_loop <- c()
for(i in 1:5){
  out_loop <- c(out_loop, 5 + i)
}
out_loop

#using the lapply function instead of the for loop
out_apply <- lapply(1:5, function(i) 5+i)
out_apply
unlist(out_apply)

# OR
sapply(1:5, function(i) 5+i)


# plyr
llply(1:5, function(i) 5+i)
laply(1:5, function(i) 5+i)


## tapply instead of loops -----

# fake data
x1 <- runif(16)*10 # Continuous
cat1 <- rep(1:4, 4) # Categorical
cat2 <- c(rep(1, 8), rep(0, 8))# categorical
ex_df <- data.frame(time_spent = x1, region = cat1, fb_account = cat2)
ex_df

# What is this doing?
tapply(X = ex_df$time_spent, INDEX = ex_df$region, FUN = mean)

# Compare this to:
out_means <- NULL
for (i in unique(ex_df$region)){
  out_means <- c(out_means, mean(ex_df$time_spent[ex_df$region==i]))
}
out_means
# (still important you can comprehend the loop as what's happening
# behind the scenes!)




## more tapply  -----

# combinations of values of variables
list(ex_df$region, ex_df$fb_account)
table(ex_df$region, ex_df$fb_account)

## Four values for cat1 and two values for cat2
tapply(ex_df$time_spent, list(ex_df$region, ex_df$fb_account), mean)

# The first cell is the same as 
mean(ex_df$time_spent[ex_df$region==1 & ex_df$fb_account==0])

# The third row second column is the same as
mean(ex_df$time_spent[ex_df$region==3 & ex_df$fb_account==1])

