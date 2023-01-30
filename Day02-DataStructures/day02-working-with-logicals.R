# Using logicals for basic tasks


# Now that we have our common *data structures*
# we need to be prepared to work with them, and 
# logicals come in handy

rm(list = ls()) # start fresh

# voting age population
vap <- c(3481823, 496387, 4582842, 2120139,26955438,
         3617942,2673154,652189,472143,14085749,6915512,
         995937,1073799,9600372,4732010,2265860,2068253,
         3213141,3188765,1033632,4242214,4997677,7620982,
         3908159,2139918,4426278,731365,1321923,1870315,1012033,
         6598368,1452962,14838076,6752018,494923,8697456,2697855,
         2850525,9612380,824854,3303593,594599,4636679,
         17038979,1797941,487900,5841335,4876661,1421717,
         4257230,392344) 
# total votes
tv <- c(NA, 238307, 1553032, 780409,8899059,1586105, 
        1162391,258053, 122356,4884544, 2143845,348988, 
        458927,3586292, 1719351,1071509, 864083,1370062, 
        954896,NA, 1809237, 2243835,3852008, 2217552,NA, 
        2178278, 411061,610499, 586274,418550, 2315643,568597, 
        4703830,2036451, 220479,4184072, NA,1399650, NA,392882, 
        1117311,341105, 1868363,NA, 582561, 263025,2398589, 
        2085074,473014, 2183155, 196217)

# Logicals with vectors ---------

# Subsetting
small_states <- vap[vap < median(vap)]

# Recoding
small_states_dummy <- (vap < median(vap))
small_states_dummy[small_states_dummy] <- "small"
small_states_dummy[small_states_dummy == "0"] <- "big"

# `which` function
# returns indices ~for which~ the statement is TRUE :)
which(vap < median(vap))

# `any` function
# returns a single TRUE or FALSE if ~any~ evaluated element is TRUE
any(vap < median(vap))

# `all` function
# returns a single TRUE or FALSE if ~all~ evaluated elements are TRUE
all(vap < median(vap))


# Logicals with dataframes (i.e., multiple vectors) ---------
vote_df <- data.frame("vap" = vap, "tv" = tv)

# Equivalent to what we did above, just a part of a dataframe now
any(vote_df$vap < median(vote_df$vap))

# What is this doing?
any(vote_df$vap < median(vote_df$vap) & is.na(vote_df$tv))

# What about this?
which(vote_df$vap < median(vote_df$vap) & is.na(vote_df$tv))

# Common use case -- get indices you need, then do calculations or subset
indices <- which(vote_df$vap < median(vote_df$vap) & is.na(vote_df$tv))
vote_df$vap[indices]
vote_df[indices, ]
