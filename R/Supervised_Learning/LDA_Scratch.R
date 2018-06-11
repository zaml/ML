# --------------------------------------------
# LDA Simple Example from Scratch
# juan.zamora@nerdyne.com
# --------------------------------------------

# Data Loading -------------------------------

# Data for Linear Discriminant Analysis sample
data <- read.csv(file="data/data_scratch_2.csv",head=TRUE,sep=",")

# Plot Data ----------------------------------

plot(data$X, col = factor(data$Y), pch = 18)

x0 <- data[data$Y == 0,]$X
x1 <- data[data$Y == 1,]$X

# Histogram for Class Y = 0
hist(x0)
lines(density(x0))

# Histogram for Class Y = 1
hist(x1)
lines(density(x1))

cat("Class 0 Mean and Variance:", mean(x0), var(x0))
cat("Class 1 Mean and Variance:", mean(x1), var(x1))

# Develop the Model --------------------------

# calculate means for each class
meanX0 <- mean(x0)
meanX1 <- mean(x1)

# calculate class probabilities P(y=0) and P(y=1)
# p(y = 0)
Px0 <- length(x0) / ( length(x0) + length(x1) ) 
# p (y = 1)
Px1 <- length(x1) / ( length(x0) + length(x1) ) 

# calculate variance for each class
# Variance: variance is the difference of each instance from the mean
sumDiffX0 <- sum((x0 - meanX0)^2)
sumDiffX1 <- sum((x1 - meanX1)^2)

# variance is 0.832931... 
# the number 2 belongs to the amount of classes.
variance <- (1 / (length(data$X) - 2)) * (sumDiffX0 + sumDiffX1)

# Perform Predictions ------------------------

# Predictions are made by calculating the discriminant function 
# for each class and predicting the class with the largest value

# discr(x) = xi * (mean/variance) - (mean^2/ 2 * variance) * ln(prob)
# discr(Y = 0|x) = 
discrY0 <- data$X * (meanX0/variance) - ((meanX0^2)/(2 * variance)) + log(Px0) 
# discr(Y = 1|x) = 
discrY1 <- data$X * (meanX1/variance) - ((meanX1^2)/(2 * variance)) + log(Px1) 
# predition if discrY0 < discrY1 predict zero otherwise 1
prediction <- (discrY0 < discrY1) * 1

predData <- data.frame(X = data$X, Discr_Y_0 = discrY0, Discr_Y_1 = discrY1, Prediction = prediction)

# Predictions vs Training Set ----------------

plot(data$X, col = factor(data$Y), pch = 20)
points(predData$X, col = factor(predData$Prediction), pch = 1, cex = 2)
# 100% accuracy prediction!