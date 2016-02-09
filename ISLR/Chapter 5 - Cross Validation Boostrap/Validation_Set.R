# --------------------------------------------------------
# ISLR - CHAPTER 5 - Cross Validation & Boostrap
# Sample: Validation Set Assestment  
# Juan Zamora
# --------------------------------------------------------


library(ISLR)

# --------------------------------------------------------

# SEED 1
set.seed(1)
# select 196 samples from 392 using sample() method from R
train = sample(392,196)

# use the Auto dataset
attach(Auto)

# MSE: LINEAR: Mean Squared Error of Test Set (26.14)
lm.fit = lm(mpg ~ horsepower, data=Auto, subset=train)
mean((mpg-predict(lm.fit, Auto))[-train]^2)

# MSE: POLYNOMIAL: Mean Squared Error of Test Set (19.82)
lm.fit2 = lm(mpg ~ poly(horsepower,2), data=Auto, subset=train)
mean((mpg-predict(lm.fit2, Auto))[-train]^2)

# MSE: CUBIC: Mean Squared Error of Test Set (19.78)
lm.fit3 = lm(mpg ~ poly(horsepower,3), data=Auto, subset=train)
mean((mpg-predict(lm.fit3, Auto))[-train]^2)

# --------------------------------------------------------

# SEED 2
set.seed(2)
# select 196 samples from 392 using sample() method from R
train = sample(392,196)

# use the Auto dataset
attach(Auto)

# MSE: LINEAR: Mean Squared Error of Test Set (23.29)
lm.fit = lm(mpg ~ horsepower, data=Auto, subset=train)
mean((mpg-predict(lm.fit, Auto))[-train]^2)

# MSE: POLYNOMIAL: Mean Squared Error of Test Set (18.90)
lm.fit2 = lm(mpg ~ poly(horsepower,2), data=Auto, subset=train)
mean((mpg-predict(lm.fit2, Auto))[-train]^2)

# MSE: CUBIC: Mean Squared Error of Test Set (19.25)
lm.fit3 = lm(mpg ~ poly(horsepower,3), data=Auto, subset=train)
mean((mpg-predict(lm.fit3, Auto))[-train]^2)
