function [ data_norm, mu, sigma ] = normalize( data )
% normalize function 

X_norm = data;
mu = zeros(1, size(data, 2));
sigma = zeros(1, size(data, 2));

mu = mean(data);
data = data - mu;
sigma = std(data);
data = data ./ sigma;

data_norm = data;

end