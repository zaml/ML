# -------------------------------------
# ISLR - CHAPTER 4 - Regression - QDA
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

# Fit Quadratic Discriminant
qda.fit = qda(Direction~Lag1+Lag2, data = Smarket, subset = train)
# Pi1 = 0.492 & pi2 = 0.508
qda.fit

# Prediction
qda.class = predict(qda.fit, Smarket.2005)$class

# LDA and the Smarket Logistic Regression is very similar.
table(qda.class, Direction.2005)

# mean: 0.599 (Accurate almost 60% of the time, much better than LDA)
mean(qda.class == Direction.2005)



