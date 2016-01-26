# -------------------------------------
# ISLR - CHAPTER 3 - Regression
# Juan Zamora
# -------------------------------------


library(MASS)
library(ISLR)
install.packages("ISLR") 

# -------------------------------------
# Linear Regression Boston House Values
# -------------------------------------
fix(Boston)
# variables Boston
# mdev: median value house
# rm: rooms average
# age: age of house
# lstat: percent of houses with low socioeconomic status
names(Boston)
# SIMPLE LINEAR REGRESSION
# - response (y): mdev
# - predictor (x): lstat
# attach(Boston) # only if data=Boston is removed
lm.fit = lm(medv ~ lstat, data=Boston)
# show intercept and b1->lstat
lm.fit 
# regression summary wih t-stat and p-value
summary(lm.fit)
# Confidence Intervals
confint(lm.fit)
# confidence intervals and prediction intervals
# 95% confidence interval lstat = 10 [24.47,25.63]
predict(lm.fit, data.frame(lstat=(c(5,10,15))), interval="confidence")
# 95% pediction interval lstat = 10 [12.82,37.27]
predict(lm.fit, data.frame(lstat=(c(5,10,15))), interval="prediction")
# PLOT
plot(lstat, medv)
# Least Squares Regression Line
abline(lm.fit)
# ABLINE EXPERIMENTS
abline(lm.fit, lwd=3)
abline(lm.fit, lwd=3, col="red")
plot(lstat, medv, pch=20) # makes dots
plot(lstat, medv, pch="+") # marker = +
plot(1:20,1:20,pch=1:20) # 20 different markers
# LM.FIT Diagnostic plots
par(mfrow=c(2,2))
plot(lm.fit)
# Residuals Plot
plot(predict(lm.fit), residuals(lm.fit))
# Studentized Residuals Plot
plot(predict(lm.fit), rstudent(lm.fit))
#leverage statistics
plot(hatvalues(lm.fit))
# high leverage identify unusual values of xi (p.97)
which.max(hatvalues(lm.fit)) # higest leverage statistic

# -------------------------------------
# Multiple Linear Regression 
# -------------------------------------
lm.fit = lm(medv ~ lstat+age, data=Boston)
# regression summary wih t-stat and p-value
summary(lm.fit)
# Linear regression with ALL variables
lm.fit = lm(medv ~., data=Boston)
# Get R2
summary(lm.fit)$r.sq
# Get RSE (Residual Square Error)
summary(lm.fit)$sigma
# Variance Inflation Index VIF
# get car package first
install.packages("car")
library(car)
vif(lm.fit)
# Regression with all variables except one (age!)
lm.fit = lm(medv ~.-age, data=Boston)

# -------------------------------------
# Interaction Terms
# -------------------------------------
# short for lstat+age+lstat:age
summary(lm(medv ~ lstat * age, data=Boston))

# -------------------------------------
# Predictor non-linear transformations
# -------------------------------------
# x + x^2
lm.fit2 = lm(medv ~ lstat + I(lstat^2), data=Boston)
summary(lm.fit2)
# Analysis of Variance ANOVA to quantify how better is
# the quadratic fit is against the simple model
# f-stat is 135 and p value is virtually zero for quadratic model
# this confirms the superiority of the quadratic fit
anova(lm.fit2, lm.fit)
par(mfrow=c(2,2))
plot(lm.fit2)
# create a 5th order polynomial fit 
lm.fit5 = lm(medv ~ poly(lstat,5), data=Boston)
summary(lm.fit5)
# log transformation
summary(lm(medv ~  log(rm), data=Boston))

# -------------------------------------
# Qualitative Predictors
# -------------------------------------
fix(Carseats)
names(Carseats)
# ShelveLoc: indicador of quality: qualitative
# multiple regression using interaction terms
# dummy variables are generated automatically
lm.fit = lm(Sales ~ .+Income:Advertising+Price:Age, data=Carseats)
# return coding for dummy variables ShelveLocGood & ShelveLocMedium (p.118)
attach(Carseats)
contrasts(ShelveLoc)

# -------------------------------------
# Writing Functions
# -------------------------------------
LoadLibraries=function(){
  library(MASS)
  library(ISLR)
  print("MASS & ISLR Libs loaded")
}



