# Helpful R tools

# rvest makes scraping in R easier!
# special functions, special objects, etc.
# They're website: https://rvest.tidyverse.org/

install.packages("rvest") #run once to install
install.packages("xml2")
library(rvest)
library(xml2) #just for saving files

indiana <- read_html("https://ballotpedia.org/Presidential_election_in_Indiana,_2020")
class(indiana)
indiana

# rvest is particularly useful because of special functions to
# navigate the HTML

# Header element
indiana %>% html_elements("h1")

# Just the text from the element
indiana %>% html_elements("h1") %>% html_text()

# tables are a commonly desired HTML element
in_tables <- indiana %>% html_table()

class(in_tables) #hey a list!
in_tables[[2]] #the table we want


## Let's scrape! ------

states <- c("Indiana", "Illinois", "Iowa", "Minnesota", "Ohio")
all_tables <- vector("list", length = 5)
for(i in 1:5){
  # download
  url <- paste0("https://ballotpedia.org/Presidential_election_in_",
                               states[i],
                               ",_2020")
  html <- read_html(url)
  
  # let's save it, who knows we might want FULL html later
  write_html(x = html, file = paste0(states[i],".html"))
  
  # get election results table
  state_tables <- html %>% html_table()
  
  # store in our list
  all_tables[[i]] <- state_tables[[2]]
  
  # write yourself an informative message
  print(paste("Scraped state", i))
}
names(all_tables) <- states
all_tables

# did it save?
list.files()



## Extracting specific elements with rvest -----

arkansas_url <- "https://ballotpedia.org/United_States_Senate_election_in_Arkansas,_2022"
arkansas_html <- read_html(arkansas_url)

# all paragraph text
main_text <- arkansas_html %>%
  html_nodes('p') %>%
  html_text2() #trims white space
main_text[83:90]

main_text_ws <- arkansas_html %>%
  html_nodes('p') %>%
  html_text() #notice the white space?
main_text_ws[83:90]

# all the urls
all_urls <- arkansas_html %>% 
  html_nodes('a') %>%
  html_attr('href')
all_urls[1:10]

# all the main headers
arkansas_html %>% 
  html_nodes('h1')

# just the main headers' text
arkansas_html %>% 
  html_nodes('h1') %>%
  html_text2()

# More granular -----
# tag's with a specific class/id

# Method #1: look up the class
arkansas_html %>% 
  html_nodes('h1.firstHeading') %>% 
  html_text()

# Method #2: Use Chrome to help
# right click > Copy > Copy XPath
# use the 'xpath' argument and make sure
# quotes are happy
arkansas_html %>% 
  html_nodes(xpath = '//*[@id="firstHeading"]') %>% 
  html_text()

# Try it:
# See the heading entitled "Democratic primary election"?
# Get all the elements of the same class
# get just the `div` elements of class `electionsectionheading`
arkansas_html %>% 
  html_nodes('div') %>% 
  html_text()

# Try it:
# See the heading entitled "Footnoes" at the bottom?
# Get the text of all 11 footnotes



## Nesting ----

# Sometimes you want to get certain information
# from a group of tags, and discard the rest of the info
# Example -- the links from the footnoes
arkansas_html %>% 
  html_nodes('span.reference-text') %>% # Select `span` tags of this class
  html_nodes('a') %>% # Within `span` tags, get just `a` tags
  html_attr('href') # Within the `a` tags, get just `href` attribute


