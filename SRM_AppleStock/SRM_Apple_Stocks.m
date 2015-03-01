%% Simple Model Regresion
% Apple Stocks vs Market Returns
% Apple Stock returns as the response (Y) against the Market Returns (X) 

%% Initialization + Data Load
clear ; close all; clc;

% Load Dataset Size: 6324 samples from Apple Stock vs Market
data = load('data.txt');
Apple = data(:,1);
Market = data(:,2);
Dates = data(:,3);

fprintf('Apple vs Market Data Loaded. Press enter to continue.\n');
pause;

%% SRM Conditions
% We will validate the dataset can be used for SRM

% -- Step 1: Superficial Variation Analysis
scatter(Market, Apple, '.b');
title('Apple Stock Analysis Over Market');
xlabel('Daily Market returns');
ylabel('Daily Apple Returns');

fprintf('Step1 - Data Analysis. Press enter to continue.\n');
pause;

% -- Step2: Linear Regression - Equation
% y = mx + b, we will use this notation y = b1x + b0

% PARAMETERS
% correlation coeficient
r = corr(Market, Apple);
% standard deviation Apple (Sy)
Sy = std(Apple); 
% stabdard deviation Market (Sx)
Sx = std(Market);
% slope : b1
b1 = (Sy/Sx) * r;
% intercept : b0
b0 = mean(Apple) - b1 * mean(Market);

% The Linear Equation
% linear_reg_Apple the hypothesis line
% y = b1 * x + b0
linear_reg_Apple = b1 * Market + b0;

% plot the linear regression line on top
hold;
plot(Market, linear_reg_Apple, '-r');

fprintf('Step2 - Linear Regression. Press enter to continue.\n');
pause;
close;

% -- Step3: Linear Association - Residuals Plot
% Residuals plot will help clarify the linear trend of data
% Calculates residual between both variables against the exploratory var 
residuals = Apple - b0 - b1 * Market;
scatter(Market, residuals, '.b');
title('Variation Analysis - Residuals');
xlabel('Market');
ylabel('Residuals');
hold;
% reflie: this adds a line at axis-x zero. r
refline; 

fprintf('Step3 - Residuals Variation Analysis. Press enter to continue.\n');
pause;
close;

% -- Step4: Residual Errors - Independence Validation
% This will display a time-series to check if there is any pattern
% on errors over time.
plot(residuals);
title('Residuals Variation Over Time');
xlabel('Residuals Apple Stock Returns');
ylabel('Time');


fprintf('Step4 - Residuals Independence. Press enter to continue.\n');
pause;
close;

% -- Step5: Check if the residuals are nearly normal
% This will disp
hist(residuals,25);
title('Normal Disitrbution - Bell Shapped Residuals');
xlabel('Error Disitrbution');

fprintf('Step5 - Residuals Histogram. Press enter to continue.\n');
pause;
close;

% -- Step6: Normal Quantile Plot. This is the real test for fitting a normal 
% model
zscore_residuals =  zscore(residuals);
plot(zscore_residuals, residuals, 'oR'); 
title('Normal Quantile Plot - Residuals');
xlabel('Probability (z-score)');
ylabel('Residuals');

fprintf('Step6 - Residuals Normal Quantile Plot. Press enter to continue.\n');
pause;
close;

fprintf('Simple Sample Condition %f %f \n', theta(1), theta(2));


%% Section 2 Title
% Description of second code block

