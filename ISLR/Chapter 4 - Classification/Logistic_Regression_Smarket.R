# -------------------------------------
# ISLR - CHAPTER 4 - Regression
# Juan Zamora
# -------------------------------------

# -------------------------------------
# Basic Dataset Inspection
# -------------------------------------

# If no ISLR installed
# install.packages("ISLR") 
library(ISLR)
# Smarket dataset of S&P 500 stock index from 2001 - 2005
# five previous trading days lag1-lag5
# volume: number of trades shared in billions
names(Smarket)
# 1250 x 9 matrix
dim(Smarket)
summary(Smarket)
#creation of correlation matrix
# remove "Direction" since is qualitative
cor(Smarket[,-9])
#is better to display this (correlations) graphically
attach(Smarket)
plot(Smarket)
# the most important correlation is volumen x year (0.53900647)
plot(Volume)

# -------------------------------------
# Logistic Regression
# -------------------------------------

# predict Direction(Y) as a function of Lag1..5 and volume
# glm fits generalized linear models
# glm  family = binomial == logistic regression!
glm.fit = glm(Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume,
                data = Smarket, family = binomial)
summary(glm.fit)
# analysis of coefficients
coef(glm.fit)
# or (a bit more detail)
summary(glm.fit)$coef


# Model Fit P(Y = 1 | X)

# this uses by default the training data
glm.probs = predict(glm.fit, type="response")
# get top 10 probabilities of the market going up (up = 1)
glm.probs[1:10]
# Constrasts indicates how the dummy variables was converted
contrasts(Direction)
# create a class prediction vector
# those with pro > 0.5, then are considered UP
glm.pred = rep("Down", 1250)
glm.pred[glm.probs >.5] = "Up"
#create confusion matrix to asses model accurary
table(glm.pred, Direction)
# the table shows correct labels 145(down) + 507(up)
# Diagonal Elements: (507 + 145) / 1250 = 0.5216 (52%) 
(507 + 145) / 1250
# Training Error Rate 100 - 52 = 48%

# Because this is over optimistic, we will re-train the model
# only using the data between 2001 to 2004. 2005 will be used to
# asses accuracy 

# create vector data just for 2005
# train: boolean vector (2005 observations == FALSE)
train = (Year<2005)
Smarket.2005 = Smarket[!train,]
# 2005: 252 x 9
dim(Smarket.2005)
Direction.2005 = Direction[!train]

#fit Logistic regression using the train subset
glm.fit = glm(Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume,
              data = Smarket, family = binomial, subset = train)
# predict probabilities for 2005 using the training set
glm.probs = predict(glm.fit, Smarket.2005,  type="response")
# create a class prediction vector
# those with pro > 0.5, then are considered UP
glm.pred = rep("Down", 252)
glm.pred[glm.probs >.5] = "Up"
#create confusion matrix to asses model accurary
table(glm.pred, Direction.2005)
# (77+44)/252 = 0.4801587 = 48% (predicted)
# Training Error Rate 100 - 48 = 52% THIS SUCKS! because random guessing is better. 

# hint: this model fitted just with Lag1 and Lag2 gives a 56% predicted. This means
# that works better than using all variables, however this might be due to luck....



