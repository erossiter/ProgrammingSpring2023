# JSON

# Package in R to help read and write JSON structured data
#install.packages("rjson")
library(rjson)

# from local file name or url
indiana2018 <- fromJSON(file = "https://data.cnn.com/ELECTION/2018November6/IN/county/S.json")

# lists are back!
class(indiana2018)

# check it out
View(indiana2018)

# Remember how to access list elements
# Indiana Senate race 1
indiana2018[["raceid"]]
indiana2018$raceid

# TONS of data
str(indiana2018[["counties"]][[1]])
indiana2018[["counties"]][[1]]$name

# First county, first candidate 
indiana2018[["counties"]][[1]]$race$candidates[[1]]$lname
indiana2018[["counties"]][[1]]$race$candidates[[1]]$vpct

# second candidate
indiana2018[["counties"]][[1]]$race$candidates[[2]]$lname
indiana2018[["counties"]][[1]]$race$candidates[[2]]$vpct

# third candidate
indiana2018[["counties"]][[1]]$race$candidates[[3]]$lname
indiana2018[["counties"]][[1]]$race$candidates[[3]]$vpct


# Transform to dataframe
#install.packages("jsonlite")
library(jsonlite)
indiana2018_flat <- jsonlite::fromJSON("https://data.cnn.com/ELECTION/2018November6/IN/county/S.json",
                                       flatten = T)

# Notice the differences!
View(indiana2018)
View(indiana2018_flat)

# Clean df! 
# ... but see last column...
# still some list nesting
# remember data.frames are
# just a specific kind of list
county_df <- as.data.frame(indiana2018_flat$counties)


