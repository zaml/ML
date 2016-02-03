# -------------------------------------
# ISLR - CHAPTER 4 - Regression - LDA
# Juan Zamora
# -------------------------------------

# load Smarket from MASS lib
library(MASS)
require(ISLR)
attach(Smarket)
# Make training and test set
train = Year<2005
Smarket.2005=subset(Smarket,Year==2005)
Direction.2005 = Smarket$Direction[!train]

# Fit Linear Discriminant
lda.fit = lda(Direction~Lag1+Lag2, data = Smarket, subset = train)
# Pi1 = 0.492 & pi2 = 0.508
lda.fit

# Prediction
lda.pred = predict(lda.fit, Smarket.2005)
# "class": predictions of the movement of the market
# "posterior": posterior probability matrix of kth class
# "x": linear discriminants
names(lda.pred)

# fit Summary
lda.class = lda.pred$class
# LDA and the Smarket Logistic Regression is very similar.
table(lda.class, Direction.2005)

# apply 50% threshold to posterior probabilities
sum(lda.pred$posterior[,1] >= .5)
sum(lda.pred$posterior[,1] < .5)

# mean: 0.56
mean(lda.class == Direction.2005)

# the posterior probability corresponds to the probability that the
# market will decrease
lda.pred$posterior[1:20,1]
lda.class[1:20]



