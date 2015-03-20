function [ J ] = costFx( X, y, theta )
%COSTFX This is the cost function
%   returns the Mean Square Error MSE for the parameters selected Theta
%   parameters against the variables X and the response Y.
%   J is the calculated MSE

J = 0;
m = length(X);

%   Vectorized implementation of MSE
%   J is the current squared error.
J = (1 / (2 * m)) * sum((X * theta - y).^2);

% X * theta is the hypothesis function. h(x)


end

