# Matrices and lists

# Datastructure in R:
# - vector
# - matrix
# - array 
# - data.frame
# - list

# We've discussed vectors
# Skipping arrays because hardly used
# Focusing on *matrix, data.frame, and list*
#   Most other R objects are a combo of these
#   Ex: 'lm' object


# Matrix ---

# A matrix is a collection of vectors

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

vote_mat <- cbind(vap, tv) #bind two columns

# Attributes
head(vote_mat)
is.matrix(vote_mat)

# #2-dimensional
dim(vote_mat) #number of row, number of columns
nrow(vote_mat)
ncol(vote_mat) 

# contrast that with a vector
#1-dimensional
dim(tv) 
length(tv)

# Matrix rules ---- 
# 1. every element must be of the same class
vote_mat_messy <- cbind(vap, tv, paste0("state", 1:51))
head(vote_mat_messy) #what happened? 

# 2. vector recycling apples! (whether a friend or foe)
vote_mat_rep <- cbind(vap, tv, c(1,2,3))
head(vote_mat_rep)

# Subsetting a matrix

# Like a vector, you use the brackets []
# Now, you must indicate positions of *both* dimensions
# matrix[row-indices, col-indices]

# A single row and column:
head(vote_mat)
vote_mat[3, 2]
vote_mat[6, 1]

# A range of rows, 1 column
vote_mat[1:3, 1]

# A range of columns, 1 row
vote_mat[2, 1:2]

# Empty means return all
vote_mat[,1] #return all rows
vote_mat[2,] #return all columns

# Access by column name
vote_mat[,"tv"]
vote_mat[1:5,c("vap", "tv")]

# TODO: Save the submatrix m2
# containing the first five rows
# and both columns


# Row and column names are also attributes
colnames(vote_mat) # a function to see column names
colnames(vote_mat) <- c("Voting Age Pop", "Total Votes") #also to set them
colnames(vote_mat)

rownames(vote_mat) <- paste0("state", 1:51)
rownames(vote_mat)
head(vote_mat)


# List ---

# Many objects you are going to see in R are lists or versions of lists.
# Lists are a very flexible way to store loosely structure data

# Makes a list using the list() function
# Contains (in this order):
# - matrix
# - vector
# - integer numberic
list1 <- list(vote_mat, vap, 3)
str(list1) # "structure"

# Hint: look at it in global environment

# This is the advantage of lists! They can contain
# basically anything... even other lists
list2 <- list(list1, "hi")
str(list2)

# List attributes

# length of the first level of sub-elements
length(list2)
dim(list2) # doesn't help
colnames(list2) # doesn't help...

# Let's set names
names(list2) <- c("vote_list", "hi_string")
str(list2)

# Or, skip that and name elements right away
list2_named <- list("vote_list" = list1,
                    "hi_string" = "hi")
str(list2_named)

# Accessing elements of a list.

# 1. via index
list2[[1]]
list2[[2]]

# 2. by name and "$"
list2$hi_string

# 3. by name and []
list2[["hi_string"]]

# Adding elements to a list

list2[[3]] <- c("New vector", "lists are complicated") #unnamed :(
str(list2)
list2[["NewListElement"]] <- c("New vector", "lists are complicated")
str(list2)

# Accessing sub-elements!

# Get to the subelement, then follow all rules as normal

# Vector subelement, then vector accessing []
list2$NewListElement[1]
list2[["NewListElement"]][1]

# Integer subelement, then... nothing else needed
list2[["hi_string"]]

# List subelement, then first element of that list is a matrix
list2[["vote_list"]][[1]]
list2[["vote_list"]][[1]][1:2, 1:2]

# Basic commands don't work well with lists
# (makes sense)
list2 + 1


# TODO: Create a two element list.
# The first element is named `name` is is a string with your name.
# The second element is a vector named `ten` with integers 1 through 10.


