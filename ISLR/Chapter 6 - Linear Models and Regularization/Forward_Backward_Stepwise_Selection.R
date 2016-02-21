# --------------------------------------------------------
# ISLR - CHAPTER 6 - Linear Models & Regularization
# Sample: Forward and Bacward Stepwise Selection
# Juan Zamora

# Preduction of baseball Salary based on previous year performance 

# --------------------------------------------------------

# Load ISLR Library

library(ISLR)

# Best subset selection library
# https://cran.r-project.org/web/packages/leaps/index.html
# install.packages("leaps")
library(leaps)


# DATA CLEANUP -------------------------------------------

fix(Hitters)

# 322 rows x 20 attributes
dim(Hitters)

# Get entries where salary is NULL (59)
sum(is.na(Hitters$Salary))

# remove all enties with missing values
Hitters = na.omit(Hitters)

# 263 rows x 20 attributes (59 removed!)
dim(Hitters)

# Souble check that there are no Null entries (zero!)
sum(is.na(Hitters))

# --------------------------------------------------------

# Forward Stepwise Selection
regfit.fwd = regsubsets(Salary ~ ., data = Hitters, nvmax = 19, method = "forward")
summary(regfit.fwd)


# Backward Stepwise Selection
regfit.bwd = regsubsets(Salary ~ ., data = Hitters, nvmax = 19, method = "backward")
summary(regfit.bwd)

# --------------------------------------------------------

# Forward vs Forward Selections for seven predictors

coef(regfit.fwd, 7)
coef(regfit.bwd, 7)



