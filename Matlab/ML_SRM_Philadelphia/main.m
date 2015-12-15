%% Linear Regression with Gradient Descent
%  consider this sample the Machine learning equivalent for
%  SRM_Philadelphia_Outliers

clc; clear; close all;

%% Load Data
% Description of first code block
data = load('philadelphia.txt');
%data = load('data.txt');
% house prices (y)
y =  data(:,1); 
% crime rates (1000 / CrimeRate) : reciprocal
X = data(:,3);
% cases in the data set
m = length(X);

%Data Normalization... [-1 to +1]
[X muX sigmaX] = normalize(X);
[y muY sigmaY] = normalize(y);

% plot data to check pattern
plot(X,y, 'or', 'MarkerSize', 2);


%% Gradient Descent
% Goal minimize J(theta0, theta1) -> min(theta)

% add columns of 1's to X
X = [ones(m,1), X];

% initialize thetas with zeros (Theta0 and Theta1)
theta = zeros(2,1); % column vector with two entries [0,0]

% gradient descent parameters
iterations = 10;
alpha = 0.001;

% computea gradient descent and obtains lowest thetas
[theta, gradients, debug] = gradientDescent( X, y, theta, alpha,...
    iterations);

% plot hypothesis based on obtained thetas
hold;
% predicted response based on X
yPred = X * theta;
% plot regression line on top.
plot(X(:,2),yPred, '-b');

%% Gradient Descent Diagnostics
% Surface and Contour Charts
t0 = linspace( -2, 2, 30);
t1 = linspace( -2, 2, 30);
t = zeros(100,1);
thetaCosts = zeros(length(t0), length(t1));

% Fill out J_vals
for i = 1:length(t0)
    for j = 1:length(t1)
	  tx = [t0(i); t1(j)];
      % estimate the cost for plotting
	  thetaCosts(i,j) = costFx(X, y, tx);
    end
end

% Surface plot
figure;
surf(t0, t1, thetaCosts');
xlabel('Theta 0'); ylabel('Theta 1');

% Contour plot
figure;
% Plot J_vals as 15 contours spaced logarithmically between 0.01 and 100
contour(t0, t1, thetaCosts, logspace(-1, 2, 20))
xlabel('Theta 0'); ylabel('Theta 1');
title(sprintf('Global Optima: Theta0: %d , Theta1: %d', theta(1), theta(2)));
hold on;
plot(theta(1), theta(2), 'rx', 'MarkerSize', 14, 'LineWidth', 2);
