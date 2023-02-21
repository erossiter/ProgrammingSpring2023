##Code to scrape Pol Science Core Faculty Website##


library(rvest)
url <- "https://politicalscience.nd.edu/people/core-faculty/"
html <- read_html(url)

#for to their websites
websites <- html %>% 
  html_nodes('h2.faculty-item-name') %>% 
  html_nodes('a') %>% 
  html_attr('href')


#setting up the dataframe

base_url <- "https://politicalscience.nd.edu"
faculty_df<- data.frame("link" = websites, 
                "name" = NA,
                "title" = NA,
                "field of study" = NA,
                "office hours" = NA,
                "office location" = NA,
                "phone" = NA,
                "email" = NA)

#code for office hours
for(i in 1:nrow(faculty_df)){
  url <- paste0(base_url, faculty_df$link[i])
  html <- read_html(url)
  office_hours <- html %>%
    html_nodes('div.faculty-details') %>%
    html_nodes('p') %>%
    html_text2()
  idx <- which(grepl("Office Hours", office_hours))
  if(length(idx) == 0){
    next
  }else{
    faculty_df$office.hours[i] <- office_hours[idx]
  }
}


#code for names
for(i in 1:nrow(faculty_df)){
  url <- paste0(base_url, faculty_df$link[i])
  # get html
  html <- read_html(url)
  names <- html %>% 
    html_nodes('h1.page-title') %>%
    html_text2()
  faculty_df$name[i] <- names
}


#code for their titles
for(i in 1:nrow(faculty_df)){
  url <- paste0(base_url, faculty_df$link[i])
  html <- read_html(url)
  title <- html %>%
    html_nodes('div.faculty-details') %>%
    html_nodes('p') %>%
    html_nodes('em') %>%
    html_text2()
  faculty_df$title[i] <- title
}


#code for their field of study
for(i in 1:nrow(faculty_df)){
  url <- paste0(base_url, faculty_df$link[i])
  html <- read_html(url)
  study <- html %>%
    html_nodes(xpath = '//*[@id="content"]/div/main/div[1]/p[3]') %>%
    html_text2()
    faculty_df$field.of.study[i] <- gsub("Fields of Study:","",study)
}

#code for their location
for(i in 1:nrow(faculty_df)){
  url <- paste0(base_url, faculty_df$link[i])
  html <- read_html(url)
  location <- html %>%
    html_nodes(xpath = '//*[@id="content"]/div/main/div[1]/p[5]') %>%
    html_text2()
  faculty_df$office.location[i] <- location
}

for(i in 1:nrow(faculty_df)){
  url <- paste0(base_url, faculty_df$link[i])
  html <- read_html(url)
  phone_tags <- html %>%
    html_nodes('div.faculty-details') %>%
    html_nodes('p') %>%
    html_text()
  idx1 <- which(grepl('574',phone_tags))
  if(length(idx1) == 0){
    next
  }else{
    faculty_df$phone[i] <- phone_tags[idx1]
  }
}

#code for emails

for(i in 1:nrow(faculty_df)){
  url <- paste0(base_url, faculty_df$link[i])
  html <- read_html(url)
  email <- html %>%
    html_nodes(xpath = '//*[@id="content"]/div/main/div[1]/p[7]/a')
    faculty_df$email[i] <- email
}


View(faculty_df)




                         