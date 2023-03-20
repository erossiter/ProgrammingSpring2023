## parallelization with plyr
library(plyr)

# This package does a ton of things well
# But one further extension is that any times we
# are actually writing code that you can make 
# *much* faster on modern computers by actually making it parallel. 

# install these packages
library('doMC')
library('foreach')
library('microbenchmark')

myFunction <- function(x,y){
  data(cars)
  mean(cars$speed)
  mean(cars$dist)
  return(x+y)
}
myFunction(1, 3)


# .data holds the first argument to the function
out <- laply(.data = 1:10, .fun = myFunction, y = 3)
out

# Now let's time it for 100K
microbenchmark(laply(.data = 1:100, .fun = myFunction, y = 3, .parallel = F), unit = "s", times = 3)


# Now let's try that again but divide the task
# into 4 "instances" of R all running in the background.

registerDoMC() # Set up 4 instances
microbenchmark(laply(.data = 1:100, .fun = myFunction, y = 3, .parallel = T), unit = "s", times = 3)


# Note: This will not always be faster due to overhead.