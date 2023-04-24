# ggplot plotting

library(ggplot2)

# Grab this data from day09 folder
primaryPolls <- read.csv('../day09-datawrangling-part2/president_primary_polls_feb2020.csv', stringsAsFactors = F)
primaryPolls$start_date <- as.Date(primaryPolls$start_date, "%m/%d/%Y")
primaryPolls <- primaryPolls[primaryPolls$state == "New Hampshire", ]
these_cands <- c("Amy Klobuchar", "Bernard Sanders", "Elizabeth Warren",
                 "Joseph R. Biden Jr.", "Michael Bloomberg", "Pete Buttigieg")
primaryPolls <- primaryPolls[primaryPolls$candidate_name %in% these_cands, ]


# Setup -----

# - The first line is always `ggplot`
#     - basic object that we will layer onto

# Nothing to show yet!
ggplot(data = primaryPolls)


# Layers -----

# - Then we use the `+` to add layers
#     - In this case `geom_points`
# Conveniently, the dataset only needs to be specified once.  

# First layer...
# "mapping" means how should data map to (X,Y)?
ggplot(data = primaryPolls) +
  geom_point(mapping = aes(x = start_date, y = pct))

# Look at everything ggplot took care of for us!


# Aesthetics -----

# `aes` stands for aesthetics.  
# `ggplot` has great defaults to handle color choices, legends, etc.
# this would take LOTS of lines of code in base R

ggplot(data = primaryPolls)+
  geom_point(mapping = aes(x = start_date, y = pct, 
                           color = candidate_name))


# function automatically chose a unique color
#   given our third variable 'candidate_name'
# It can do the same with shapes, point size, and transparency (alpha).
# You can also set aesthetic characteristics manually (as I do with alpha here)


ggplot(data = primaryPolls) +
  geom_point(mapping = aes(x = start_date, y = pct, 
                           shape = candidate_name, 
                           color = candidate_name),
             alpha = .8)


# Facets -----

# Perhaps most helpfully we can parse the data
# by features using a simple line

# Single variable
ggplot(data = primaryPolls)+
  geom_point(mapping = aes(x = start_date, y = pct)) + 
  facet_wrap(~candidate_name, nrow = 2)

# Multiple variables
table(primaryPolls$population, primaryPolls$candidate_name)
ggplot(data = primaryPolls)+
  geom_point(mapping = aes(x = start_date, y = pct)) + 
  facet_wrap(population ~ candidate_name, nrow = 2)


# More geom options -----

# Built in statistics!

# smoothing
ggplot(data = primaryPolls)+
  geom_smooth(mapping = aes(x = start_date, y = pct,
                            color = candidate_name)) + 
  facet_wrap(~ candidate_name, nrow = 2)

# smoothing AND points
ggplot(data = primaryPolls)+
  geom_smooth(mapping = aes(x = start_date, y = pct,
                            color = candidate_name)) + 
  geom_point(mapping = aes(x = start_date, y = pct,
                            color = candidate_name),
              alpha = .4) + 
  facet_wrap(~ candidate_name, nrow = 2)

# Maybe we want to do this all on one plot
# instead of facets
ggplot(data = primaryPolls)+
  geom_smooth(mapping = aes(x = start_date, y = pct, 
                            group = candidate_name))

# Maybe we want to suppress the legend, but still
# have different colors
ggplot(data = primaryPolls)+
  geom_smooth(mapping = aes(x = start_date, y = pct, 
                            color = candidate_name), 
              show.legend = FALSE)


# Passing arguments -----

# We don't have to specify aes() over and over...
# Data AND aes() carried forward
ggplot(data = primaryPolls,
       mapping = aes(x = start_date, y = pct,
                     color = candidate_name))+
  geom_smooth() +
  geom_point(alpha = .4)


# Then change things just for a sublayer as needed
# This maps the `sample_size` variable to the `size`
# aesthetics in the `geom_point()` layer
ggplot(data = primaryPolls,
       mapping = aes(x = start_date, y = pct,
                     color = candidate_name))+
  geom_smooth() +
  geom_point(alpha = .4, aes(size = sample_size))


# Tons more to try -----

# This usually requires knowing the right `geom` function

# Bar chart
ggplot(data = primaryPolls, mapping = aes(x = fte_grade))+
  geom_bar()


# This summaries the data first, then plots
ggplot(data = primaryPolls, mapping = aes(x = fte_grade))+
  stat_count()

# More summaries of the data, then plotting
ggplot(data = primaryPolls, mapping = aes(x = candidate_name, y = pct))+
  stat_summary(
    fun.min = min,
    fun.max = max,
    fun = median
  )


# You can also flip the coordinate system fairly quickly
ggplot(data = primaryPolls, mapping = aes(x = candidate_name, y = pct))+
  geom_boxplot()

ggplot(data = primaryPolls, mapping = aes(x = candidate_name, y = pct))+
  geom_boxplot() +
  coord_flip()


