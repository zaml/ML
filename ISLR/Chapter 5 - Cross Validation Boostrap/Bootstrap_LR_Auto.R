# --------------------------------------------------------
# ISLR - CHAPTER 5 - Cross Validation & Boostrap
# Sample: Boostrap for Linear Regression
# Juan Zamora
# --------------------------------------------------------

# Load ISLR Library

library(ISLR)

# https://cran.r-project.org/web/packages/boot/index.html
# Functions and datasets for bootstrapping from the book "Bootstrap Methods and Their Applications" 
library(boot)

attach(Auto)

# --------------------------------------------------------

# boot function for linear regression
boot.fn = function(data,index)
  return (coef(lm(mpg ~ horsepower, data = data, subset = index)))

# (Intercept)  horsepower 
#  39.9358610  -0.1578447
boot.fn(Auto,1:392)

# Bootstrap to compute SE of 1000 bootstrap estimates
boot(Auto, boot.fn, 1000)

# SE(b0) = 0.884 && SE(b1) = 0.0072

# compare bootstrap agains linear regression
summary(lm(mpg ~ horsepower, data = Auto))$coef