function [x_norm,mu,sigma] = normalize_data(x)
    mu = mean(x,2);
    sigma = std(x');
    x_norm = (x-mu)/(1+sigma);
end