# http

# Simple GET request to an API ---------

# Package in R to help read and write JSON structured data
#install.packages("httr")
library(httr)

# our request to the API using GET
# response is stored in `resp` object
space_url <- "http://api.open-notify.org/astros.json"
resp <- GET(space_url)

# Let's inspect their summary of the object
# when we print it
# - API endpoint
# - Status (200 means success)
# - Conent type (JSON)
# - Size
resp

# Also see that it holds lots of info that we don't care about
# (e.g., cookies, lots of meta data about request, etc.)
str(resp)

# Class is technically "response"
# All of the information that is returned by the API server
class(resp)

# Let's get the data we came for
# unicode --> character --> JSON (list)
resp$content #what???
rawToChar(resp$content) # one big string, but we see it is JSON structure
resp_cleaned <- jsonlite::fromJSON(rawToChar(resp$content)) #our friend the list!

# Check out the data by accessing elements
# of the list
resp_cleaned$number
resp_cleaned$people


# Adding parameters to our query ---------

# Most of the time the API requests will need info from you
# Ex: Star Wars API
# https://swapi.dev/documentation

person1 <- "https://swapi.dev/api/people/1/"
resp <- GET(person1)

# print the summary
resp

# unicode mess
resp$content

# to list
resp_cleaned <- jsonlite::fromJSON(rawToChar(resp$content))
str(resp_cleaned)

# Notice how we are pointed to
# API endpoints for more information?

resp <- GET(resp_cleaned$homeworld)
homeworld <- jsonlite::fromJSON(rawToChar(resp$content))
homeworld

# Then we are pointed to even more info!
# residents, films, etc....

# TODO:
# practice reading the documentation to do the following

