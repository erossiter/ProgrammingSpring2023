# Reading a webpage into R

## First things first, we need to read the HTML of a webpage
## into R systematically (i.e., not hand-downloading it...)

## We're going to use base R to do it first.

rm(list = ls())

## Reading text into R ------
## readLines is the most basic function
## doesn't rely on packages to structure the HTML,
## just returns a character vector, where each HTML
## line is a string

url <- "https://ballotpedia.org/Presidential_election_in_Indiana,_2020"

flat_html <- readLines(con = url)
flat_html[1:10]

# Note the class
class(flat_html)

## Saving it to a folder ----

## Oftentimes, we want to save our scraping output
## and clean/organize it later

# Create a folder on your Desktop
# (we can delete it after this exercise)
# call it "class4"

# Navigate to it
setwd("~/desktop/class4")

# Look inside
list.files()

# Save to clean later
# Note the html file extension
writeLines(flat_html, con = "indiana2020.html")

# Check it out
# - both the un-rendered HTML (right click > open with RStudio)
# - the rendered HTML (right click > open with Chrome)

## Let's scrape! ------

states <- c("Indiana", "Illinois", "Iowa", "Minnesota", "Ohio")
for(i in states){
  # download
  url <- states_urls <- paste0("https://ballotpedia.org/Presidential_election_in_", i, ",_2020")
  html <- readLines(con = url)
  
  # save
  file_name <- paste0(i, "2020.html")
  writeLines(html, con = file_name)
  
  # write yourself an informative message
  print(paste("Scraped state", i))
}



