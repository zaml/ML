# --------------------------------------------
# K-NN Simple Example from Scratch
# juan.zamora@nerdyne.com
# --------------------------------------------

# Data Loading -------------------------------

data <- read.csv(file="data/data_scratch_1.csv",head=TRUE,sep=",")

# Plot Data ----------------------------------

plot(data$x1, data$x2, col = factor(data$y), pch = 19)

# Calculate Euclidean Distance ---------------

# new instance point for prediction 
# Question: is point (p1,p2) 1 or 0?
p1 <- 8.093607318
p2 <- 3.365731514

# add this to the plot for reference.
# this will look different for user reference...
points(p1, p2, pch = 13, col = "purple", bg = "cyan")

# Euclidean distance is calculated as the square
# root of the sum of the squared differences 
# between a point a and point b across all input 
# attributes i.
# Distance(a,b) = sqrt[ sum( ai - bi )^2   ]

# the squared root will be removed from the formula
# as this just adds overhead for classification

# vectorization of the distance formula

# create new variable for euclidiean diffs for x1
data$x1e <- (data$x1 - p1)^2

# create new variable for euclidiean diffs for x1
data$x2e <- (data$x2 - p2)^2

# sum both x1e and x2e in xsum
data$xsum <- (data$x1e + data$x2e)

# calculate distance as sqrt(data$xsum)
data$distance <- sqrt(data$xsum)

# review dataset
head(data)

# k-NN Settings ------------------------------

# We will chose 3 as this is an odd number as n = 10
# set k to 3 and choose the 3 most similar neighbors 
# to the data instance

k = 3

# the distance column in data$distance shows how close
# the points are two (p1,p2). Then sorting this DESC will
# give the closest instances. We will select 3 of them as
# k = 3 and we will use mode to get the class that is most
# frequent

# sort data
dataSorted <- data[order(data$distance),] 

# get top k observations
dataSorted <- dataSorted[1:k,]

# function to obtain the mode of a vector
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

# get the mode over y for prediction
# prediction = mode(class(i))
prediction <- getmode(dataSorted$y)

# points (p1,p2) SHOULD BE 1!!!
cat("The Class for point (p1,p2) is ", prediction)








