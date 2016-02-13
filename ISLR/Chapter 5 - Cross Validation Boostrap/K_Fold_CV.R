# --------------------------------------------------------
# ISLR - CHAPTER 5 - Cross Validation & Boostrap
# Sample: K-Fold Cross Validation
# Juan Zamora
# --------------------------------------------------------

library(ISLR)

# --------------------------------------------------------

# cv,glm can be used for k-fold cross validation 
# common sizes for k are 5 or 10 (folds)

# --------------------------------------------------------

# use the Auto dataset
attach(Auto)

# --------------------------------------------------------

# https://cran.r-project.org/web/packages/boot/index.html
# Functions and datasets for bootstrapping from the book "Bootstrap Methods and Their Applications" 
library(boot)

# --------------------------------------------------------

set.seed(17)
cv.error.10 = rep(0:10)

for(i in 1:10){
  glm.fit = glm(mpg ~ poly(horsepower,i), data=Auto)
  cv.error.10[i] = cv.glm(Auto, glm.fit, K=10)$delta[1]
}

# print  cv.error.10
# gets best fold performance for each polynomial
# 24.20520 19.18924 19.30662 19.33799 18.87911 19.02103 18.89609 19.71201 18.95140 19.50196 

# after x^2 there is no major improvement.
