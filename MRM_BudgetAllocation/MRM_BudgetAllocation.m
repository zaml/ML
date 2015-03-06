clc; clear; close all;

% load data Ads info by week
data = load('budget_data.txt'); 

% data entries
n = size(data,1);

% # of explanatory variables (used)
k = 2; 

% model parameters (explanatory variables)
week = data(:,1); % x1 
print = data(:,2); % x2
tv = data(:,3); % x3 
% response
sales = data(:,4); % y

% setup of all variables in matrix X
X = [week, print, tv];

% print scatter plot matrix againt sales
[H,AX,BigAx,P,PAx] = plotmatrix([sales,X], [sales,X]);

% We will take week out of the analysis.
X = [print, tv];

% adding ones colum for regress function.
X = [ones(n,1), X];

% estimation of regression model using [regress]
% more info at: http://www.mathworks.com/help/stats/regress.html?searchHighlight=regress%20alpha
[b, bint, r, rint, stats] = regress(sales, X);

% residuals
residuals = r;

% r-squared
r2 = stats(1);

% linear regression Bi's
b0 = b(1); % intercept (sales)
b1 = b(2); % print
b2 = b(3); % tv

%Standard Error
Se2 = sum((sales - b0 - b1 * print - b2 * tv).^2) / (n-k-1);
Se = sqrt(Se2);

% VIF bewteen TV ads and Printed Ads
% this two variables has the highest correlation coeficient.
% VIF = 9. which mean that affects SE by 3 times.
VIF = 1 / (1 - corr(tv, print)^2); 

%Standard Error or Marginal Slope
Seb3 = (Se / sqrt(n)) * (1 / mean(print));

% Standaed Error of Marginal Slope 
% adjusted for collinearity
Seb3Adj = Se / ( sqrt(n) * mean(print)) * sqrt(VIF);

% Ratio of how bad collinarity affects Standard Error for print:
% Seb3Times tells hos many times is the Standard Error increased due to
% collinearity
Seb3Times = Seb3Adj / Seb3; % (3 Times Bro!)

% Linear Regression Prediction
salesPrediction = b0 + b1 * print + b2 * tv; 

% Check for Similar Variation
% if variation seems random, the models for far looks good.
% there should not be an obvious pattern
figure;
scatter(salesPrediction, residuals, '+r');
title('Variation Analysis');
xlabel('Sales Prediction');
ylabel('Sales Residuals');
refline;

% Check for Independence over time
% if variation seems random, the models for far looks good.
% there should not be an obvious pattern
figure;
scatter(week, residuals, 'xb');
title('Independence Analysis');
xlabel('Over Time (weeks)');
ylabel('Sales Residuals');
refline;

% Check if the residuals are nearly normally disitrbuted
% Interquartile plot
figure;
scatter(zscore(residuals), residuals, '.');
title('Interquartile - Sales Residuals');

figure;
hist(residuals,10);
title('Residuals - Normal Disitrbution');

% Partial Slope Standard Error
tvPSe = Se / (sqrt(n-1)* std(tv)) * sqrt( 1 / (1 - corr(tv, print)^2)); 
printPSe = Se / (sqrt(n-1)* std(print)) * sqrt( 1 / (1 - corr(tv, print)^2)); 

% t-statistic for Partial Slopes
% to obtain p-value and see if their contribution is 
% statistically significant
tstatTv = b2 / tvPSe;
tstatPrint = b1 / printPSe;

% p-values 
pValTV = 2*(1-tcdf(abs(tstatTv),n-2)); % = 0.4373 (warning!)
pValPrint = 2*(1-tcdf(abs(tstatPrint),n-2)); % < .0001

% Is the model statistically significant?
% F-test aims to tell if the variables explains the model.
% ratio of fitted values to the residuals
% R2 = 0.83, F = 167.5 with n = 104 (Looks Good)
% usually F > 5 is statistically significant. Well, we got 167.
F = (r2 / (1- r2)) * ((n-k-2)/k);

% THE MAGIC BALL: Prediction
% lets say we have 360 thousand dollars to use. I will suggest using
% 40% on Tv ads and 60% on printed. The earnings will be $5750 thousand.
earnings = b0 + b1 * (360 * 0.6) + b2 * (360 * 0.4);
% The standard error of this models is Se +- the predicted value.
% Se = 2.070675074888599e+02 = 207.06 x 2 = 414.135 with 95% confidence








