function [ spe ] = disfunction( Xt, svmstruct)
%DISFUNCTION Determines which group the input data belongs to
%   given the information about kernel function and support vector

data = svmstruct.TrainingData;
Isv = svmstruct.Isv;
spe = svmstruct.Bias;
vecAlpha = svmstruct.vecAlpha;
vecMu = svmstruct.vecMu;
vecSigma = svmstruct.vecSigma;
groups = svmstruct.GroupNames;
vecY = -1*ones(length(groups),1);
vecY(groups) = 1;

for i=1:length(Isv)
    idx = Isv(i);
    spe = spe + vecAlpha(idx) * vecY(idx) * ...
        multirbfker(data(idx,:),Xt,vecMu,vecSigma);
end
end