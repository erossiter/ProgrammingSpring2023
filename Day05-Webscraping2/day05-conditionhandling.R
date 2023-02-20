# Condition handling


# Writing an error
for(i in 1:10){
  print(i)
  if(i == 5){
    stop("This will stop my code!")
  }
}

# Writing an error
for(i in 1:10){
  print(i)
  if(i == 5){
    warning("This will *not* stop my code, but it will warn me at the end.")
  }
}

# Writing a message
for(i in 1:10){
  print(i)
  if(i == 5){
    message("This will *not* stop my code, but it will message me.")
  }
}


# Now let's use a function
sum_function <- function(n){
  my_sum <- 0
  for(i in 1:n){
    my_sum <- my_sum + i
    if(i == 5){
      stop("This will stop my code!")
    }
  }
  return(my_sum)
}
sum_function(n = 2)
sum_function(n = 4)
sum_function(n = 10)

# Let's catch the error and deal with it
for(i in 1:10){
  #print the result
  print(sum_function(i))
  #print iteration
  print(paste0("iteration: ", i))
}

# We need to add in try() and see how it affects loop
for(i in 1:10){
  #print the result
  try(print(sum_function(i)))
  #print iteration
  print(paste0("iteration: ", i))
}

# Now, we need to add in tryCatch to deal with it
for(i in 1:10){
  tryCatch({
    print(sum_function(i))
  }, error = function(e){
    print(e)
    # imagine this was visiting a website
    # you could wait 5 seconds and try again
    # if internet is poor
  })
  print(paste0("iteration: ", i))
}


# Now in the context of scraping
library(rvest)
library(xml2)

# First, another scraping practice

# Get it to work for first page
base_url <- "https://www.presidency.ucsb.edu/documents/app-categories/elections-and-transitions/debates"
debate_pg0 <- read_html(base_url)

links <- debate_pg0 %>%
  html_elements("div.field-title") %>%
  html_elements("a") %>%
  html_attr("href")

# Iterate across all pages
# What are we iterating over?
for(i in 1:17){
  url_i <- paste0(base_url, "?page=", i)
  page_i <- read_html(url_i)
  links_i <- page_i %>%
    html_elements("div.field-title") %>%
    html_elements("a") %>%
    html_attr("href")
  links <- c(links, links_i)
  print(i)
}
length(links)

# Got to each link, download *full* html
# What are we iterating over?
setwd("~/Desktop/")
base_url <- "https://www.presidency.ucsb.edu"
for(l in links){
  # read binary
  this_url <- url(description = paste0(base_url, l), open = "rb")
  debate <- read_html(this_url)
  file_name <- gsub("/documents/", "", l)
  write_html(x = debate, file = paste0("debates/", file_name,".html"))
  print(file_name)
  close(this_url)
}

# did they save?
folder_files <- list.files("debates")
length(folder_files)


# What if links don't work for some reason?
# (sabotoge for the sake of the example)
idx <- sample(1:length(links), 10)
links_sabotage <- links
links_sabotage[idx] <- paste0(links_sabotage[idx], "SABOTOGE")
links_sabotage

# (Delete debates folder contents)
# Error!! What do we do?
base_url <- "https://www.presidency.ucsb.edu"
for(l in links_sabotage){
  this_url <- url(description = paste0(base_url, l), open = "rb")
  debate <- read_html(this_url)
  file_name <- gsub("/documents/", "", l)
  write_html(x = debate, file = paste0("debates/", file_name,".html"))
  close(this_url)
  print(file_name)
}

# Syntax
tryCatch(
  expr = {
    # Your code...
    # goes here...
    # ...
  },
  error = function(e){ 
    # (Optional)
    # Do this if an error is caught...
  },
  warning = function(w){
    # (Optional)
    # Do this if an warning is caught...
  },
  finally = {
    # (Optional)
    # Do this at the end before quitting the tryCatch structure...
  }
)


# (Delete debates folder contents)
options(warn=-1) #supress warnings for the sake of the example
base_url <- "https://www.presidency.ucsb.edu"
for(l in links_sabotage){
  tryCatch({
    this_url <- url(description = paste0(base_url, l), open = "rb")
    debate <- read_html(this_url)
    file_name <- gsub("/documents/", "", l)
    write_html(x = debate, file = paste0("debates/", file_name,".html"))
    close(this_url)
  }, error = function(e){
    close(this_url)
    print(e)
  })
}

# did they save?
folder_files <- list.files("debates")
length(folder_files)

# turn back on
options(warn=0)

# More on exception handling next week with APIs