# -------------------------------------
# ISLR - CHAPTER 4 - Regression - KNN
# Juan Zamora
# -------------------------------------

# K Nearest Neighbors receive 4 params
# 1 - a matrix with the predictors associated with the training data (training set)
# 2 - a matrix with the predictors for the data that we want to do predictos (test set)
# 3 - vector with class labels for the training set
# 4 - The value of K: the nearest neighbors

# load data
library(class)
require(ISLR)
attach(Smarket)

# create training set and test set
# example of cbind cbind(c(1,2,3),c(5,6,7))
train = Year<2005
train.X = cbind(Lag1, Lag2)[train, ]
test.X = cbind(Lag1, Lag2)[!train, ]
train.Direction = Direction[train]

# KNN = 1
set.seed(1)
knn.pred = knn(train.X, test.X, train.Direction, k = 1)
table(knn.pred, Direction.2005)
# (83 + 43) / 252 = 0.5 (only 50% prediction is correct with K = 1)

knn.pred = knn(train.X, test.X, train.Direction, k = 3)
table(knn.pred, Direction.2005)
# (87 + 48) / 252 = 0.53 (only 53% prediction is correct with K = 1)

# for this prediction of Smarket, QDA works best



