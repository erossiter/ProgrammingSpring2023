#install.packages("dbplyr")
#install.packages("RSQLite")
library(dbplyr)

# FYI this is how I created the remote data
# mayors <- read_csv(file="https://raw.githubusercontent.com/jmontgomery/jmontgomery.github.io/master/PDS/Datasets/Mayors.csv")
# con <- dbConnect(RSQLite::SQLite(), "mayors.db")
# dbWriteTable(con, name = "mayors", value = mayors)
# dbDisconnect(con)

# Connect to db
# - First arg -- the RSQLite backend
# - Second arg -- our data
con <- DBI::dbConnect(RSQLite::SQLite(), dbname = "mayors.db")

# List of tables at our connection
dbListTables(con)

# Reference it
mayors <- tbl(con, "mayors")

# Looks like a normal dataset!
# But we can see it says:
# ?? for rows
# and its "sqlite" dataset
mayors

# But nothing works because it isn't actually in memory
unique(mayors$FullName)
mayors$GenderFemale[1]

# Still not in memory
# Look at environment and object
in_mayors <- mayors %>%
  select(FullName, Ideology, State) %>%
  filter(State == "Indiana")
in_mayors 

# We can't even ask for how many rows
in_mayors %>% nrow()

# We have to explicitly ask for the data using `collect()`
in_mayors_inmem <- in_mayors %>% collect()
in_mayors_inmem



