function [ kmat ] = matker( mt, sigma)
%MATKER Summary of this function goes here
%   Detailed explanation goes here

N = size(mt,1);
kmat=zeros(N);
for i=1:N
    for j=1:N
        kmat(i,j)=rbfker(mt(i,:),mt(j,:),sigma);
    end
end

end