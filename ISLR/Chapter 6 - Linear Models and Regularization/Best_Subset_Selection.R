# --------------------------------------------------------
# ISLR - CHAPTER 6 - Linear Models & Regularization
# Sample: Best Subset Selection
# Juan Zamora

# Preduction of baseball Salary based on previous year performance 

# this code was reviewed under the influence of this :P
# https://www.youtube.com/watch?v=T6KKxm0uzM0&ebc
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

# BEST SUBSET SELECTION

# regsubsets selects best model quantified by Residual Sum of Squares (RSS)
# this by default evaluates 8 variables... thsi can be fixed with nvmax
regfit.full = regsubsets(Salary ~ ., Hitters)

# details of fit
# best two variables: Hits and CRBI
summary(regfit.full)

regfit.full = regsubsets(Salary ~ ., Hitters)

# details of fit
summary(regfit.full)

# include 19 variables in a new fit
regfit.full = regsubsets(Salary ~ ., Hitters, nvmax = 19)
reg.summary = summary(regfit.full)

# R2 (r-squared) -----------------------------------------
reg.summary$rsq

# plot adjusted r^2 vs RSS
par(mfrow=c(2,2))
# plot
plot(reg.summary$rss, xlab= "# of Variables", ylab = "RSS", type = "l")
plot(reg.summary$adjr2, xlab= "# of Variables", ylab = "Adjusted R2", type = "l")
# max point in vector
which.max(reg.summary$adjr2)
# plot a point where max point located
points(11, reg.summary$adjr2[11], col = "red", cex=2, pch=20)


# Cp and BIC Models --------------------------------------

# Cp
plot(reg.summary$cp, xlab= "# of Variables", ylab = "Cp", type = "l")
which.min(reg.summary$cp)
# plot a point where min point is located
points(10, reg.summary$cp[10], col = "red", cex=2, pch=20)

#BIC
plot(reg.summary$bic, xlab= "# of Variables", ylab = "BIC", type = "l")
which.min(reg.summary$bic)
# plot a point where min point is located
points(6, reg.summary$cp[6], col = "red", cex=2, pch=20)


# regsubsets built in plot
# ?plot.regsubsets
plot(regfit.full,scale = "r2")
plot(regfit.full,scale = "adjr2")
plot(regfit.full,scale = "Cp")
plot(regfit.full,scale = "bic")

# best subset coeficients for 6 variables
coef(regfit.full, 6)
#  (Intercept)        AtBat         Hits        Walks         CRBI    DivisionW      PutOuts 
#   91.5117981   -1.8685892    7.6043976    3.6976468    0.6430169 -122.9515338    0.2643076 













