function [ k ] = multirbfker( x1, x2, vecMu, vecSigma )
%KERFUN Summary of this function goes here
%   Detailed explanation goes here
if (length(x1)~=length(x2)) || (length(vecMu)~=length(vecSigma))
    disp('The lengths of parameters do not match.');
    return;
end
Lp = length(vecSigma);
k = 0;
for i=1:Lp
    k = k + vecMu(i) * rbfker(x1,x2,vecSigma(i));
end
end

