# --------------------------------------------------------
# ISLR - CHAPTER 5 - Cross Validation & Boostrap
# Sample: Leave-one-out Cross Validation LOOCV
# Juan Zamora
# --------------------------------------------------------

library(ISLR)

# --------------------------------------------------------

# use the Auto dataset
attach(Auto)

# --------------------------------------------------------

# https://cran.r-project.org/web/packages/boot/index.html
# Functions and datasets for bootstrapping from the book "Bootstrap Methods and Their Applications" 
library(boot)

# --------------------------------------------------------

# linear regression using a generalized linear model
glm.fit = glm(mpg ~ horsepower, data=Auto)
coef(glm.fit)

# (Intercept)  horsepower 
# 39.9358610  -0.1578447

# cv functions are part of boot library
# get Cross Validation results
cv.error = cv.glm(Auto, glm.fit)
cv.error$delta
# output delta: 24.23151 24.23114
# cross validation test error: 24.23

# --------------------------------------------------------

# compute CV for multiple polynomials

# initialize array with 5 zeros
cv.error = rep(0,5)

# i is the polynomial order -> hp^i
for (i in 1:5){
  glm.fit = glm(mpg ~ poly(horsepower,i), data=Auto)
  cv.error[i] = cv.glm(Auto, glm.fit)$delta[1]
}

# print CV errors
cv.error

# 24.23151 19.24821 19.33498 19.42443 19.03321
# this means there is no major improvement after hp^2







