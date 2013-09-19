function [ k ] = rbfker( x1, x2, sigma )
%RBFKER Calculates exp^(-sigma^2*abs(x_i-x-j))
%   Detailed explanation goes here
if ~(length(x1)==length(x2)) 
    disp('The lengths of two vectors do not match.');
    k=-1;
    return;
end
k = exp(-1/sigma^2*norm(x1-x2));

end

