
% Response: change in selling price per sq feet
% locations: city, suburbs and rural
% sample size: 120 houses sold on a year
% parameters for home pricing
% - size of house in sqft
% - number of bathrooms
% - distance in miles to nearest public school

%% Data Processing
clc; clear; close all;

data = readtable('data2.txt'); 

ChangePriceSqft = table2array(data(:,1));
OneOverSqft = table2array(data(:,2));
Baths = table2array(data(:,3));
Distance = table2array(data(:,4));
Location = table2array(data(:,5));
HomeType = table2array(data(:,6));
Price = table2array(data(:,7));
PriceSqft = table2array(data(:,8));
Squarefeet = table2array(data(:,9));

% number of cases
n = size(Price,1);

% Matlab regress variables
Y = ChangePriceSqft;
X = [OneOverSqft, Baths, Distance]; 

% print scatter plot matrix againt sales
[H,AX,BigAx,P,PAx] = plotmatrix([Y,X],[Y,X]);

%% Multivariate linear regression
% regression model 
X = [ones(n,1), X];
%[b, bint, r, rint, stats] = regress(Y, X);
[beta,Sigma,E,CovB,logL] = mvregress(X,Y);

Hypothesis = beta(1) + beta(2) * OneOverSqft +  beta(3) * Baths + ...
    beta(4) *  Distance;

% r-squared
r2 = sum((Hypothesis - mean(Y)).^2) / sum((Y - mean(Y)).^2);

% number of explanatory variables
k = 3;

% Data from the Regression Model
% beta(1); % intercept
% beta(2); % 1/sqft
% beta(3); % baths
% beta(4); % distance

% model Standard Error
Se2 = sum((Y - beta(1) - beta(2) * OneOverSqft -  beta(3) * Baths + ...
    beta(4) *  Distance).^2) / (n-k-1);
Se = sqrt(Se2);

% Partial Slopes - Standard Errors Bx
PartialStdErr = diag(sqrt(CovB)); % mvregress

%t-statistics (Beta / PartialStdErr)
tRatio = beta ./ PartialStdErr;

%p-values
pVals = 2*(1-tcdf(abs(tRatio),n-2));

% Summary Table of the Regression Model
RegressionSummary = [beta, PartialStdErr, tRatio, pVals];

%% Boxplot of Residuals per Location
% get location indexes
iRural = find(not(cellfun('isempty', strfind(Location, 'Rural'))));
iCity = find(not(cellfun('isempty', strfind(Location, 'City'))));
iSuburb = find(not(cellfun('isempty', strfind(Location, 'Suburb'))));

% create arrays of residuals for boxplot
C = [E(iRural)' E(iCity)' E(iSuburb)'];
G = [ zeros(1,size(E(iRural),1)), ones(1,size(E(iCity),1)),  2 .* ones(1,size(E(iSuburb),1))];

figure;
boxplot(C,G, 'Labels',{'Rural','City','Suburb'});
refline;

%% Extension with Dummy Variables

% lazy initialization
DummyCity = zeros(n,1);
DummyRural = zeros(n,1);

% Dummy Variables
DummyCity(iCity) = 1;
DummyRural(iRural) = 1;

% Dummy Interaction Variables: OneOverSqft
InterCityOneOverSqft = OneOverSqft .* DummyCity;
InterRuralOneOverSqft = OneOverSqft .* DummyRural;

% Dummy Interaction Variables: Baths
InterCityBaths = Baths .* DummyCity;
InterRuralBaths = Baths .* DummyRural;

% Dummy Interaction Variables: Distance
InterCityDistance = Distance .* DummyCity;
InterRuralDistance = Distance .* DummyRural;

%% Regression Model with the Dummy Variables
Xdummy = [OneOverSqft, Baths, Distance, DummyCity, DummyRural,...
    InterCityOneOverSqft, InterRuralOneOverSqft, InterCityBaths,...
    InterRuralBaths, InterCityDistance, InterRuralDistance]; 

% regression model execution
Xdummy = [ones(n,1), Xdummy];
[beta,Sigma,E,CovB,logL] = mvregress(Xdummy,Y);

% new hypothesis
HypothesisDummy = beta(1) + beta(2) * OneOverSqft +  beta(3) * Baths + ...
    beta(4) *  Distance + beta(5) * DummyCity +...
    beta(6) * DummyRural +  beta(7) * InterCityOneOverSqft +...
    beta(8) * InterRuralOneOverSqft + beta(9) * InterCityBaths+...
    beta(10) * InterRuralBaths + beta(11) * InterCityDistance +...
    beta(12) * InterRuralDistance;

% r-squared for Dummy-based hypothesis
r2 = sum((HypothesisDummy - mean(Y)).^2) / sum((Y - mean(Y)).^2);

% number of explanatory variables
k = 11;

% model Standard Error
Se2 = sum((Y - beta(1) - beta(2) * OneOverSqft -  beta(3) * Baths - ...
    beta(4) *  Distance - beta(5) * DummyCity -...
    beta(6) * DummyRural -  beta(7) * InterCityOneOverSqft -...
    beta(8) * InterRuralOneOverSqft - beta(9) * InterCityBaths -...
    beta(10) * InterRuralBaths - beta(11) * InterCityDistance -...
    beta(12) * InterRuralDistance).^2) / (n-k-1);

Se = sqrt(Se2);

% Partial Slopes - Standard Errors Bx
PartialStdErr = diag(sqrt(CovB)); % mvregress

%t-statistics (Beta / PartialStdErr)
tRatio = beta ./ PartialStdErr;

%p-values
pVals = 2*(1-tcdf(abs(tRatio),n-2));

% Summary Table of the Regression Model
RegressionSummaryDummy = [beta, PartialStdErr, tRatio, pVals];

%% Boxplot of Residuals per Location - for Dummy Model
% get location indexes
iRural = find(not(cellfun('isempty', strfind(Location, 'Rural'))));
iCity = find(not(cellfun('isempty', strfind(Location, 'City'))));
iSuburb = find(not(cellfun('isempty', strfind(Location, 'Suburb'))));

% create arrays of residuals for boxplot
C = [E(iRural)' E(iCity)' E(iSuburb)'];
G = [ zeros(1,size(E(iRural),1)), ones(1,size(E(iCity),1)),  2 .* ones(1,size(E(iSuburb),1))];

figure;
boxplot(C,G, 'Labels',{'Rural','City','Suburb'});
refline;


