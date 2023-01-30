# Data-frames

# Dataframes are mix between a matrix and a list
# They are rectangular like a matrix.
# But each column can be of a different class.
# And you can access elements of the data frame like it's a list.

rm(list = ls()) #start fresh


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

# Notice it is similar to a list
# Named elements
# But elements must be vectors
vote_df <- data.frame("vap" = vap, "tv" = tv)

# Functions for matrices work similarly
head(vote_df)

# But not a matrix!
is.matrix(vote_df)
is.data.frame(vote_df)

# Looks like a list's structure
str(vote_df)

# 2-dimensional like a matrix
dim(vote_df) #number of row, number of columns
nrow(vote_mat)
ncol(vote_mat) 

# Accessing elements

vote_df[[1]] # first column by index like a list
vote_df$vap # first column by name like a list
vote_df[,1] # first column by index like a matrix
vote_df[,"tv"] # first column by name like a matrix


# Attributes work like a matrix
colnames(vote_df) # a function to see column names
colnames(vote_df) <- c("Voting Age Pop", "Total Votes") #also to set them
colnames(vote_df)

rownames(vote_df) # the default
rownames(vote_df) <- paste0("state", 1:51)
rownames(vote_df)
head(vote_df)

# TODO: Create a new dataframe called `my_data` with two columns.
# The first column called `age` is five numeric elements.
c(30, 35, 80, 47, 33)
# The second column called `PID` is five strings indicating partisanship.
c("R", "D", "R", "R", "D")

