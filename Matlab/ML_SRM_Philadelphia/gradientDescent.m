function [theta, gradients, debug] = gradientDescent( X, y, theta, alpha, iterations)
%GRADIENTDESCENT calculates the cost MSE on every iteration until
%convergence.

%% Parameter Description
% theta: this function will return the minimized theta parameters where the
% squared error (MSE) is the smallest one. Each iteration, we will calculate a
% new theta value.
% alpha: learning rate. how big or small each step will be.
% iterations: iterations that look to minimize(theta0,theta1) based in the
% lower MSE
% gradients: all the MSE estimated over the iterations. This will help us
% later debug the algorithm.

%% Gradient Descent
m = length(X);
gradients = zeros(iterations, 1);

debug = zeros(iterations, 3);

for i = 1:iterations

    % Theta Calculation
    % d/dtheta * min(theta0, theta1)
    % H(x): hypothesis: X * theta (linear regresion)
    d = (1/m) * ((X * theta - y)' * X);
    theta = theta - ( d' * alpha );
      
    % calculation of cost of MSE per theta
    % the lowest value means the line will fit the model as best as
    % possible
    gradients(i) = costFx(X, y, theta);
    
        
    debug(i,:) = [gradients(i) theta(1) theta(2)];
end   

end

