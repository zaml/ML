# --------------------------------------------------------
# ISLR - CHAPTER 5 - Cross Validation & Boostrap
# Sample: Boostrap Sampling  
# Juan Zamora
# --------------------------------------------------------

# Load ISLR Library

library(ISLR)

# https://cran.r-project.org/web/packages/boot/index.html
# Functions and datasets for bootstrapping from the book "Bootstrap Methods and Their Applications" 
library(boot)

# --------------------------------------------------------

# step 1 - create function to estimated alpha based on selected observations
# (5.7, p.187) ISLR
alpha.fn = function(data, index){
  X = data$X[index]
  Y = data$Y[index]
  return ((var(Y) - cov(X,Y)) / (var(X) + var(Y) - 2*cov(X,Y)))
}

# estimate Alpha using 100 portfolio observations (a = 0.5758321)
alpha.fn(Portfolio,1:100)

# MANUAL: Create bootstrapped dataset using sample fn
# this is just a manual way to obtain alpha from a random sample from Porfolio
set.seed(1)
alpha.fn(Portfolio,sample(100,100, replace=T))
# a = 0.6052472


# Automated: Automate Bootstrap using boot()
# this produces 1000 alpha estimates
boot(Portfolio, alpha.fn, R = 1000)

# RESPONSE:
# alpha =  0.57 with SE(alpha) = 0.09

# ORDINARY NONPARAMETRIC BOOTSTRAP
# Call:
#   boot(data = Portfolio, statistic = alpha.fn, R = 1000)
# Bootstrap Statistics :
#   original       bias    std. error
# t1* 0.5758321 -0.001890611  0.09152272


