# let working directory to:
setwd("~/Desktop/GMC_LR_GD")

# load the gmc dataset from CSV file
gmc <- read.csv(file="gmc.csv",head=TRUE,sep=",")

# plot data in XY scatterplot
# X: List Price - Y: Best Price
plot(gmc$X,gmc$Y,xlab='List price (in $1000)',ylab='Best price (in $1000)',pch=16,col='gray', ylim = c(10,40))

# --------- Step 1 -------------------

# lets use random theta values to test the hypothesis: this is h(x)
hyp <- function(x, t0, t1) t0 + t1 * x 

# plot charts sequentially
par(mfrow=c(1,3)) 

# plot first random line using thetas (0.7 & 1.5)
plot(gmc$X,gmc$Y,xlab='List price (in $1000)',ylab='Best price (in $1000)',
     pch=16,col='gray', ylim = c(10,38))
title(main = "t0: 0.7, t1: 1.5")
par(new=TRUE)
plot(gmc$X, hyp(gmc$X, 0.7, 1.5), axes = FALSE, type = 'l', bty = 'n', 
     xlab = '', ylab = '', col = 34, ylim = c(10,38))

# plot first random line using thetas (4.5 & 0.5)
plot(gmc$X,gmc$Y,xlab='List price (in $1000)',ylab='Best price (in $1000)',
     pch=16,col='gray', ylim = c(10,38))
title(main = "t0: 4.5, t1: 0.5")
par(new=TRUE)
plot(gmc$X, hyp(gmc$X, 4.5, 0.5), axes = FALSE, type = 'l', bty = 'n', 
     xlab = '', ylab = '', col = 34, ylim = c(10,38))

# plot first random line using thetas (1 & 1.2)
plot(gmc$X,gmc$Y,xlab='List price (in $1000)',ylab='Best price (in $1000)',
     pch=16,col='gray', ylim = c(10,38))
title(main = "t0: 1, t1: 1.2")
par(new=TRUE)
plot(gmc$X, hyp(gmc$X, 1, 1.2), axes = FALSE, type = 'l', bty = 'n'
     ,xlab = '', ylab = '', col = 34, ylim = c(10,38))

# --------- Step 3 -------------------

# implementation of the cost function J
costFn <- function(X, y, m, t0, t1)  (1/(2*m)) * sum((hyp(X, t0, t1) - y)^2) 

# example of cost function invocation for theta0 = 0.7 and theta1 = 1.5
costFn(gmc$X, gmc$Y, length(gmc$Y), 0.7, 1.5)

theta0Vec = seq(-1, 1, 0.01);
theta1Vec = seq(-5, 5, 0.05);

# create empty matrix
z <- matrix(, nrow = length(theta0Vec), ncol = length(theta1Vec))

# fill z matrix with cost values from theta arrays (CostFn map)
i = 1
j = 1
for (t_0 in theta0Vec) {
  for (t_1 in theta1Vec) {
    localCost <- costFn(gmc$X, gmc$Y, length(gmc$Y), t_0, t_1)
    z[i,j] <- localCost
    j <- j + 1 
  }
  j = 1
  i <- i + 1;
}

# if plot3D is not installed, then uncomment this line...
# install.packages("plot3D")
library("plot3D")

# plot theta 0, theta 1 against the result of the costFn -> z
contour3D(y = theta1Vec, x = theta0Vec, z = z, colvar = z, lwd = 2, 
          nlevels = 300, clab = c("height", "m"), 
          colkey = FALSE, theta = 120, d = 1, shade = 0.2,
          ticktype = "detailed", ylab = "theta1", 
          xlab = "theta0", zlab = "CostFn", cex.lab=0.75,
          cex.axis = 0.5)

# plot first random line using thetas (0.6 & 0.8)
plot(gmc$X,gmc$Y,xlab='List price (in $1000)',ylab='Best price (in $1000)',
     pch=16,col='gray', ylim = c(10,38))
title(main = "t0: 0.6, t1: 0.8")
par(new=TRUE)
plot(gmc$X, hyp(gmc$X, 0.6, 0.8), axes = FALSE, type = 'l', bty = 'n'
     ,xlab = '', ylab = '', col = 34, ylim = c(10,38))

# --------- Step 4 -------------------

# Gradient Descent Function
# returns thetas 
gdc <- function (X,y, t_0, t_1, alpha, iter){
  
  thetaVec <- c(0,0)
  
  m <- length(y)
  
  for (i in 1:iter) {
    temp0 = t_0 - (alpha * (1/m) * sum(hyp(X, t_0, t_1) - y)) 
    temp1 = t_1 - (alpha * (1/m) * sum((hyp(X, t_0, t_1) - y) * X ))
    
    t_0 = temp0
    t_1 = temp1
    
    cost = costFn(X, y, m, t_0, t_1)
  }
  
  thetaVec[1] <- t_0
  thetaVec[2] <- t_1
  
  return (round(thetaVec, digits=2))
}
  
# test gdc
min_thetas <- gdc(gmc$X, gmc$Y, 0, 0, 0.0001, 500)

# plot fit with minimized thetas
plot(gmc$X,gmc$Y,xlab='List price (in $1000)',ylab='Best price (in $1000)',
     pch=16,col='gray', ylim = c(10,38))
title(main = paste("New Fit: ", "t0:", toString(min_thetas[1]), " t1:", toString(min_thetas[2])))
par(new=TRUE)
plot(gmc$X, hyp(gmc$X, min_thetas[1], min_thetas[2]), axes = FALSE, type = 'l', bty = 'n'
     ,xlab = '', ylab = '', col = 34, ylim = c(10,38))








