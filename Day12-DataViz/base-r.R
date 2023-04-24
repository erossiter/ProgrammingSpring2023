# Plotting with base R

# from CRAN...
#install.packages("tayloRswift")
library(tayloRswift)

# plot() function fills in missing information
# as best it can... what is it specifying that we
# didn't exactly ask for?
plot(5)

?plot

# Basics -----

# Axis labels
plot(x = 12, y = 14,
     xlab = "Class session", #string
     ylab = "Students in attendance", #string
     main = "Class Attendance") #string

# Axis "limits"
plot(x = 12, y = 14,
     xlab = "Class session",
     ylab = "Students in attendance",
     main = "Class Attendance",
     xlim = c(0,12), #num vector length 2
     ylim = c(0,16)) #num vector length 2

# x and y are usually vectors
# what is this error?
plot(x = 1:12,
     y = c(15,14,14,13,14,14,14,14,13,14,14),
     xlab = "Class session",
     ylab = "Students in attendance",
     main = "Class Attendance",
     xlim = c(0,12), 
     ylim = c(0,16)) 

# plot "type"
plot(x = 1:12,
     y = c(15,14,14,13,14,14,14,14,13,14,14,13),
     type = "b", #try l, s, n,
     xlab = "Class session",
     ylab = "Students in attendance",
     main = "Class Attendance",
     xlim = c(0,12), 
     ylim = c(0,16)) 

# Points and lines -----

?points #search 'pch' values
?lines
?par #search lty
plot(x = 1:12,
     y = c(15,14,14,13,14,14,14,14,13,14,14,13),
     # point shape
     pch = 17, # try "+", or "C" or 18 
     # point color
     col = "red",
     xlab = "Class session",
     ylab = "Students in attendance",
     main = "Class Attendance",
     xlim = c(0,12), 
     ylim = c(0,16)) 

# points function adds on to existing plot
# (these options can be used in plot() as well)
points(x = 4,
       y = 5,
       cex = 2, #shape size
       col = "blue",
       pch = "*")

# lines function adds on to existing plot
# (these options can be used in plot() as well)
lines(x = 1:12,
      y = c(15,14,14,13,14,14,14,14,13,14,14,13),
      lwd = 2, #line width
      lty = "dotted", #line type
      col = "blue")


# Adding layers to a plot ----

# plot() function restarts graphics window
# OR
# dev.off()


# Select advanced single plot parameters ----

# You have full control over everything with
# with base R plotting, so it is impossible
# to demonstrate every parameter you can change

# Some important ones

# supress axes
plot(1:10, 1:10, type = "n", axes = F)
# add them in yourself
# x-axis
axis(side = 1, at = 1:10, labels = LETTERS[1:10])
# y-axis
# horizontal text
axis(side = 2, las = 2) 
# box around plot (can vary shape)
box()
# let's add colors 
swift_palettes
points(1:10, 1:10,
       # vector recylcing!
       col = swift_palettes$lover,
       pch = -0x2665L, #unicode heart
       cex = 3)
#margin text
mtext(text = "Lover Album Colors",
      side = 3, #top
      line = 2) #two lines above axis
#plot text
text(1:10, 1:10, label = c("hi","bye"))


# Control of plotting environment -----

# What about things like plot margins?
# Or setting up the color for everything?
?par

par(mar = c(0,0,0,0))
plot(1:10, 1:10)
dev.off()

par(mar = c(2,2,1,1), col = "red",
    cex = 2, col.axis = "blue")
plot(1:10, 1:10)
lines(1:10, 1:10)
text(x = 2, y = 6, label = "hi")
dev.off()


# Multiple plotting windows -----

m <- matrix(c(1:12), ncol = 2)
m
layout(m)
layout.show(n = 12)
par(mar = c(0,0,3,0))

# Move to next plot each time plot() is called
for(i in 1:11){
  plot(x = 1:6, y = rep(1,6),
       col = swift_palettes[[i]],
       main = names(swift_palettes)[i],
       cex = 4,
       pch = 16,
       axes = F,
       xlab = "",
       ylab = "")
  box()
}


# Saving your plot -----

# (1) Turn on graphing device
# (note the .pdf extension)
# It will save to current working directory
# unless you specify different file path

# Lots of options in this function, too
pdf(file = "test-plot.pdf")

# (2) All your plotting code in between....
layout(m)
par(mar = c(0,0,3,0))

# Move to next plot each time plot() is called
for(i in 1:11){
  plot(x = 1:6, y = rep(1,6),
       col = swift_palettes[[i]],
       main = names(swift_palettes)[i],
       cex = 4,
       pch = 16,
       axes = F,
       xlab = "",
       ylab = "")
  box()
}


# (3) Turn off graphing device
dev.off() ## !


# Other base-r built in plots -----

# All of these options still apply
data(cars)

# Histogram
hist(cars$speed)
points(x = 2, y = 10, col = "blue", cex = 5)

hist(cars$speed, col = "green", xlab = "Speed")

# Barplot
cars$speed2 <- NA
cars$speed2[cars$speed < 10] <- "<10"
cars$speed2[cars$speed < 20 & cars$speed >= 10] <- "10-19"
cars$speed2[cars$speed > 20] <- "20+"

barplot(table(cars$speed2),
        xlab= "Speed", ylab = "Count",
        col = swift_palettes$taylorSwift[1:3])


# Legends -----

# Tons of parameters, something tricky to get right sometimes

?legend
legend("topright", legend = c("<10", "10-19", "20+"),
       col = swift_palettes$taylorSwift[1:3], pch = 18,
       bty = "n", pt.cex = 2)
