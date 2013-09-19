function [ groups ] = mysvmclassify( data, svmstruct )
%MYSVMCLASSIFY [ groups ] = mysvmclassify( data, svmstruct )
%   Detailed explanation goes here
Nt = size(data,1);
groups = false(Nt,1);
for i=1:Nt
    groups(i) = disfunction(data(i,:),svmstruct)>0;
end

end

