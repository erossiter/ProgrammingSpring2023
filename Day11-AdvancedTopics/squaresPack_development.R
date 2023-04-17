# We're going to make a package!
# Help from here: https://r-pkgs.org/whole-game.html

## Step 1 -----

# Determine where you want to store `squaresPack`  locally
# It should not be nested inside another RStudio Project,
# R package, or GitHub repo

# I'm going to try as a new repo in your GitHub folder

# Navigate there
setwd("~/documents/github/")


## Step 2 -----

# Use this code to create package bones
# Then, go look to see the package structure 
# is indeed in that directory
library(devtools)
create_package("squaresPack", open = F)

# Also (optional) get GitHub prepped now
use_git("squaresPack")


## Step 3 -----

# Be a developer!
# Write some functions, test them out, etc.
# We put them in the package once they work!

addSquares <- function(x, y){
  return(list(square = (x^2 + y^2),
              x = x,
              y = y))
}

subtractSquares <- function(x, y){
  return(list(square = (x^2 - y^2),
              x = x,
              y = y))
}


## Step 4 -----

# Add our functions to the package with `use_r` function from devtools
# Let's have each function live in its own file of the same name
# (Argument is the file/function name)

use_r("addSquares")
use_r("subtractSquares")

# When file opens, put code in, save, and close.
# Is it saved in the package?



## Step 5 -----

# Let's load and test
# Remove functions from the environment
rm("addSquares")
rm("subtractSquares")

# We've loaded the local version of our package
load_all("squaresPack") # like library()
addSquares(x = 5, y = 5)

# No documentation yet
?addSquares


## Step 6 -----

# To create documentation, open R/addSquares.R and put the cursor somewhere
# in the function definition, then Code > Insert roxygen skeleton. 

# Then, edit that documentation.

# Then, compile it with the following function
document("squaresPack")

# You'll know this worked in two ways:
# (1) if there's a file in the /man directory
# (2) checking it out
?addSquares

# Repeat for the other function


## Step 7 -----

# Edit the DESCRIPTION file template


## Step 8 -----

# Just look at the NAMESPACE file
# When you create documentation, it takes care of this file for you
# Don't manually edit it


## Step 8 -----

# Upload to Github
# You can just follow along or try it out
# GitHub Desktop > File > Add Local Repository >
# Then find squaresPack
# And commit!
# (Have it be public not private)


## Step 9 -----

# Your TODO:

# Add a new function to your package
# Whatever you want as long as it only uses base R

# Here's a quick summary of the steps:

# - development
# - put in package
# - load_all
# - test it
# - create documentation
# - render documentation
# - commit changes


## Step 10 -----

# Practice installing a classmate's (or my)
# version of squaresPack

devtools::install_github("erossiter/squaresPack")



