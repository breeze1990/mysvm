function [ spe ] = disfunction( Xt, data, Isv, Bast, vecAlpha, vecY, vecMu, vecSigma )
%DISFUNCTION Determines which group the input data belongs to
%   given the information about kernel function and support vector
spe = Bast;
for i=1:length(Isv)
    idx = Isv(i);
    spe = spe + vecAlpha(idx) * vecY(idx) * ...
        multirbfker(data(idx,:),Xt,vecMu,vecSigma);
end
end

