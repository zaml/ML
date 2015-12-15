%% Estimation of Residual Value of BMWs Serie 3
%  estimation performed with multiple linear regression

clc; clear; close all;

%% Load Data for BMWs
%  Price,Age,Mileage,Year,ResidualPrice,PredFormulaPrice

% load data for used cars (218 samples)
data = load('used_bmw.txt'); 
n = size(data,1);
k = 2; % there are 2 explanatory variables used.

% model parameters
price = data(:,1); % y
mileage = data(:,3); % x1
age = data(:,2); % x2
year = data(:,4);
residualPrice = data(:,5); % x3
predFormulaPrice = data(:,6); % x4

% Note:
% for this sample, we will be using age and mileage to predict the price
% there is a sense of correlation: an old car might have a lot of miles.

%% Initial Check for SRM
% Scatterplots will tell if the data is good for multiple linear
% regression

% Age x2  vs Price y
scatter(age, price, 'xb');
xlabel('Age');
ylabel('Price');
figure;

% Mileage x1 vs Price y
scatter(mileage, price, 'xb');
xlabel('Mileage');
ylabel('Price');
figure;

% Age x2 vs Mileage x1
scatter(mileage, age, 'xb');
xlabel('Mileage');
ylabel('Age');

% colinearity is envident between x1 and x2
% al charts seems to be linear with some outliers

%% Multiple Regression Model Fit

% standard deviations
Sy = std(price);
Sx1 = std(mileage);
Sx2 = std(age);

% estimation of b1 (or Theta1) b1 = -1,853.8
b1 = (Sy/Sx1)*((corr(price,mileage)-corr(price,age)*corr(mileage,age))/(1-corr(mileage,age)^2));
% estimation of b2 (or Theta2) b2 = -0.1240
b2 = (Sy/Sx2)*((corr(price,age)-corr(price,mileage)*corr(mileage,age))/(1-corr(mileage,age)^2));
% estimation of b0 (intercept of Theta0) = 40,324
b0 = mean(price) - b1 * mean(mileage) - b2 * mean(age);

% prediction array (linear regression)
pricePrediction = b0 + b1 * mileage + b2 * age;

% R-squared: ratio of sum of squares of the fitted values around y (0.5104)
r2 = sum((pricePrediction - mean(price)).^2) / sum((price - mean(price)).^2);
% adjusted r-suared
r2Adj = 1- (1 - r2) * ((n-1)/(n-k-1));

% Standard Squared Error
k = 2 % two explanatory variables (mileage and age)
Se2 = sum((price - b0 - b1 * mileage - b2 * age).^2) / (n-k-1);
Se = sqrt(Se2);

% Standard Error for Slopes
%Note: 1 / (1- corr(x1, x2)^2) = Variance Inflation Factor (VIF)
% Se(Mileage)
SeMileage = Se / (sqrt(n-1)*Sx1) * sqrt( 1 / (1- corr(age, mileage)^2)); 
% Se(Age)
SeAge = Se / (sqrt(n-1)*Sx2) * sqrt( 1 / (1- corr(age, mileage)^2));
% Se(Intercept b0) - computed / hard coded
SeIntercept = 721.8478;

% t-Ratios zscore(ratio) calculates p-value
interceptRatio = b0 / SeIntercept;
b1MileageRatio = b1 / SeMileage;
b2AgeRatio = b2 / SeAge;

% TODO: Confidence Interval for partial effects of age and mileage









