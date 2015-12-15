%% Simple Regression Model and Identification of Outliers

clc; clear; close all;

%% Load Information for Crime Rate and House Prices

data = load('philadelphia.txt'); 
price =  data(:,1); % house prices
crimeRate = data(:,2); % crime rates
tCrimes = data(:,3); % 1000 / crime rates (reciprocal of crimeRate)

%plot of pricing against reciprocal: linearity visual test
plot(tCrimes, price, 'ok');
title('Philadelphia House Prices vs Crimes per Thousand Persons');
xlabel('1000 / Crimes Rate');
ylabel('House Pricing');

%% Linear regression price prediction = b0 + b1 * tCrimes
% PARAMETERS
% correlation coeficient
r = corr(tCrimes, price);
% standard deviation Prices (Sy)
Sy = std(price); 
% stabdard deviation Crimes (Sx)
Sx = std(tCrimes);
% slope : b1
b1 = (Sy/Sx) * r;
% intercept : b0
b0 = mean(price) - b1 * mean(tCrimes);

% The Linear Equation
% linear_reg_housing the hypothesis line
% y = b1 * x + b0
linear_reg_housing = b1 * tCrimes + b0;

hold;
% plot the linear regression line on top
plot(tCrimes, linear_reg_housing, '--b');

fprintf('Linear regression. Press enter to continue.\n');
pause;

%% Visual Test for Outliers: Residuals vs
% estimation of standard error se(y)
% residuals
residuals = price - b0 - b1 * tCrimes;

% 95% confidence levels
stdRes = std(residuals);
linear_reg_upperBound = linear_reg_housing + (1.96 * stdRes);
linear_reg_lowerBound = linear_reg_housing - (1.96 * stdRes);
plot(tCrimes, linear_reg_upperBound, 'r');
plot(tCrimes, linear_reg_lowerBound, 'r');


fprintf('Linear regression 95 percent Confidence limits. Press enter to continue.\n');
pause;
close;

%% Identification of Outliers
% identification of the 4 biggest outliers
plot(tCrimes, residuals, 'xb');
refline;
res_sort = sort(residuals, 'descend');
outliers_index = find(residuals > res_sort(5));
hold;
plot(tCrimes(outliers_index), residuals(outliers_index), 'Or');
title('Variation Analysis - Residuals vs 1000/Crimes Ratio');
xlabel('1000 / Crimes Rate');
ylabel('Residuals');

fprintf('4 Biggest outliers on the residual analysis. Press enter to continue.\n');
pause;
close;








