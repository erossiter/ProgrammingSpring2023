# R Selenium

#install.packages("RSelenium")
library(RSelenium)

# Download chromedriver
# - https://chromedriver.chromium.org/
# Download selenium-standalone 4.0 alpha
# - http://selenium-release.storage.googleapis.com/index.html?path=4.0/
# Save in same location
# Navigate there and run (whatever version you downloaded)
# - java -jar selenium-server-standalone-4.0.0-alpha-2.jar

# This works for me for getting a server running
remDr <- remoteDriver(
  remoteServerAddr = "localhost",
  port = 4444L,
  browserName = "chrome"
)
remDr$open() # open up the browser

# Direct navigation
remDr$navigate("https://www.courts.mo.gov/casenet/base/welcome.do")
remDr$navigate("https://www.courts.mo.gov/casenet/cases/searchCases.do?searchType=date")

# Standard browsing behavior
remDr$goBack()
remDr$goForward()
remDr$getCurrentUrl()
remDr$refresh()

# Finding an element on the page
thisElement <- remDr$findElement(using = "name", value = "courtId" )
thisElement$getElementAttribute("name")
thisElement$getElementAttribute("id")
thisElement$getElementAttribute("class")

# A useful visual tool
thisElement$highlightElement()

# Let's try and find some other elements on this page
thisElement2 <- remDr$findElement(using = "name",
                                  value = 'inputVO.startDate')
thisElement2$highlightElement()

# Sending key presses and clicks
# - start date
thisElement2$sendKeysToElement(list("02/01/2020"))

# - court option
thisElement3 <- remDr$findElement(using = "xpath",
                                value = '//*[@id="courtId"]/option[26]')
thisElement3$clickElement()

# - case type
thisElement4 <- remDr$findElement(using = "xpath",
                                  value='//*[@id="inputVO.caseType"]/option[2]')
thisElement4$clickElement()

# Click find!
findButton <- remDr$findElement(using = "name",
                                value = "findButton")
findButton$clickElement()


# Now let's actually get some data
# I tried :)
tbody_elems <- remDr$getPageSource()[[1]] %>%
  read_html() %>%
  html_elements("tbody")
tab <- tbody_elems[19] %>%  html_table()
tab <- tab[[1]]
