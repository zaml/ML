# let working directory to:
setwd("~/Desktop/GREGPA_LOGREG")

# ------------------------------------------------------------------
# 1 - Load Data
# ------------------------------------------------------------------
# load default dataset with GPA and GRE Scores
data <- read.csv(file="gre_gpa_data.csv",head=TRUE,sep=",")

# ------------------------------------------------------------------
# 2 - Features Definition (Variables)
# ------------------------------------------------------------------
# reponse
Y <- as.matrix(data["admit"])
# dummy variables for Rank (categorical)
rank2 <- as.numeric(data$rank == 2)
rank3 <- as.numeric(data$rank == 3)
rank4 <- as.numeric(data$rank == 4)
# identity represents a ones-vector for the intercept
# in sigmoid function 
identity = rep(1, length(t(Y)));
# independent variables with dummy variables for rank
Xframe <- data.frame(identity, data["gre"], data["gpa"],
                     rank2, rank3, rank4);
# X as a matrix with identity column
X <- data.matrix(Xframe)

# ------------------------------------------------------------------
# 3 - Hypothesis Function - Sigmoid Function
# ------------------------------------------------------------------
# sigmoid function for one X feature.... (very limited)
# hyp <- function(X, b0, b1) { exp(b0 + b1*X) / (1 + exp(b0 + b1*X)) }
# -- 
# vectorized implementation for multiple logit regression...
hyp <- function(X, b) { exp(X%*%b) / (1 + exp(X%*%b)) }

# ------------------------------------------------------------------
# 4 - Convex Cost Function - CostFn
# ------------------------------------------------------------------
# this optimization fn looks to fit the Beta variables.
costFn <- function(t){
  # number of features in X
  m <- nrow(X)
  # sigmoid or logit fn
  s <- hyp(X,t)
  # cost function J
  j <- (-1/m) * sum((Y*log(s)) + ((1-Y)*(log(1-s))))
  
  return (j)
}

# ------------------------------------------------------------------
# 5 - Gradient Descent with the Optim Function
# ------------------------------------------------------------------
# the R optim function is similar to fminunc in Matlab
# https://stat.ethz.ch/R-manual/R-devel/library/stats/html/optim.html

# build a zero vector size of X columns to start optimization
initialTheta <- rep(0,ncol(X))
# Minimize costFn and return theta values at convergence
optimThetas <- optim(par = initialTheta,fn = costFn)
# get minimized thetas for prediction:
thetas <- optimThetas$par
# get cost function at convergence:
cost <- optimThetas$value

# ------------------------------------------------------------------
# 6 - Prediction! 
# ------------------------------------------------------------------
# we will no use the hyp function with the thetas to make predictions
# for students with GRE and GPA scores for different university types

# prediction # 1 
# What is the probability to enter to Harvard University with
# - identity: 1
# - GRE: 315
# - GPA: 3.1
# - Rank: 1 == (0,0,0)

xHarvard <- c(1, 315, 3.1, 0, 0, 0)
pHarvard <- hyp(X = xHarvard, b = thetas)
round(pHarvard, digits=3)
# :) 19% chance, there is always hope.


# ------------------------------------------------------------------
# Quick: glm - Logistic Regression
# ------------------------------------------------------------------
setwd("~/Desktop/GREGPA_LOGREG")
data2 <- read.csv(file="gre_gpa_data.csv",head=TRUE,sep=",")
attach(data2)
data2$rank <-factor(data2$rank)
glm.fit <- glm(admit ~ gre + gpa + rank, data = data2, family = binomial)
param <- with(data2, data.frame(gre = 515, gpa = 3.7, rank = factor(1:4)))
predict(glm.fit, newdata= param, type="response")
# 1: 0.3134222 
# 2: 0.1885268 
# 3: 0.1067504
# 4: 0.0882146

# points(515, 3.7, pch = 19 , bg = "black", cex = 1, type = "p")



