# Google Civic API wrapper in R

# Practicing a more complicated API, requiring the 
# set up of a key


# Install package from GitHub ------------

install.packages("devtools")
library(devtools)
install_github("willdebras/googlecivic")
library(googlecivic)

# Set up your API Key: 

# run this line, it should open a file
usethis::edit_r_environ() 

# put this line in the file, with your key

# restart R like it prompts

# this keeps the information safe, which is important
# because sometimes API calls are not free!

# **DO NOT POST YOUR KEYS PUBLICLY (SO NO GITHUB)**


# Our first API call with R wrapper ------------------

old_reps <- get_rep_address(address = "6126 Washington Blvd St. Louis, MO",
                            includeOffices = TRUE,
                            levels = "country",
                            roles="legislatorLowerBody", 
                            key = Sys.getenv("google_civic_api")) #safely gets our key
str(old_reps)


# Note the output is no different than without the helpful wrapper
# But the set up is less friendly
# - need to know endpoint
# - need to know query params
# - need to manually clean

library(httr)
old_reps_httr <- GET("https://www.googleapis.com/civicinfo/v2/representatives",
                     query = list(address="6126 Washington Blvd St. Louis, MO",
                                  includeOffices = "true",
                                  levels = "country",
                                  roles = "legislatorLowerBody", 
                                  key = Sys.getenv("google_civic_api")))
old_reps_httr

library(jsonlite)
old_reps_clean <- fromJSON(rawToChar(old_reps_httr$content))
str(old_reps_clean)


Sys.setenv(SPOTIFY_CLIENT_ID = 'c0a8099de912475f8e18cc29035360e3')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '45187b512e1b4ea6a098ee70baceee91')
access_token <- get_spotify_access_token()
