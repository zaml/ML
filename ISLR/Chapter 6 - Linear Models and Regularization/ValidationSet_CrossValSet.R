# --------------------------------------------------------
# ISLR - CHAPTER 6 - Linear Models & Regularization
# Sample: Validation Set & Cross Validation
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

# ------------- VALIDATION SET ---------------------------

set.seed(1);

# random {TRUE FALSE} array of size of Hitters dataset (254)
train = sample(c(TRUE,FALSE), nrow(Hitters), rep=TRUE)

# Test set (inverse of train set)
test = (!train)


# Best Subset Fit with Train Data
regfit.best = regsubsets(Salary ~ ., data = Hitters[train,], nvmax = 19)


# generate an X matrix for test data using model.matrix
test.mat = model.matrix(Salary ~ ., data = Hitters[test,])

# compute Test MSE from each row of the matrix
val.errors = rep(NA,19)
for(i in 1:19)
{
  # coeficients for each row[i]
  coefi = coef(regfit.best, id = i)
  pred = test.mat[, names(coefi)]%*%coefi
  val.errors[i] = mean((Hitters$Salary[test]-pred)^2)
}

# determine the model with the lowest number of variables (10 vars)
which.min(val.errors)

# now that we know that using 10 variables will 
# regsubsets selects the best 10 variable model for you
regfit.best = regsubsets(Salary ~ ., data = Hitters, nvmax = 19)
coef(regfit.best, 10)

# ------------- CROSS VALIDATION SET ---------------------

k = 10
set.seed(1)
# allocate each obserbation into a fold
folds = sample(1:k, nrow(Hitters), replace=TRUE)
# create a matrix to hold the jth folds
cv.errors = matrix(NA,k,19, dimnames = list(NULL, paste(1:19)))

# custom predict method for regsubsets (p.249)
predict.regsubsets = function(object, newdata, id,...)
{
  form = as.formula(object$call[[2]])
  mat = model.matrix(form, newdata)
  coefi = coef(object, id=id)
  xvars = names(coefi)
  mat[,xvars]%*%coefi
}


for(j in 1:k)
{
  best.fit = regsubsets(Salary ~ ., data = Hitters[folds!=j,], nvmax = 19)
  for (i in 1:19)
  {
    pred = predict(best.fit, Hitters[folds==j,], id=i)
    cv.errors[j, i] = mean((Hitters$Salary[folds==j]-pred)^2)
  }
}

# use best 10 variables
regfit.best = regsubsets(Salary ~ ., data = Hitters, nvmax = 19)
coef(regfit.best, 10)













