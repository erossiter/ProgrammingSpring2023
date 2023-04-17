# Rcpp Example

#install.packages("Rcpp")
library(Rcpp)

# Note: you can open and edit C++ files (.cpp extension) in RStudio
# Let's check out the function I wrote
sourceCpp("get_min.Cpp")

# Use our C++ function, but with R input and output
long_vec <- sample(1:100000, 100000, replace = F)
vec_min <- cpp_min(long_vec)

