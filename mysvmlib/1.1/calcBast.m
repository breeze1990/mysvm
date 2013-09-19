function [ Bast, Isv ] = calcBast( MatK, vecY, vecAlpha, vecC )
%CALCBAST Calculate the parameter B for the discrimination function.
%   Detailed explanation goes here
Isv = [];
vecB = [];
for i=1:length(vecAlpha)
    if equals(vecAlpha(i),0)~=0
        Isv = [Isv i];
        if equals(vecAlpha(i),vecC(i))==-1
            vecB =[vecB i];
        end
    end
end
vecBp = vecY(vecB);
for i=1:length(vecB)
    idx = vecB(i);
    for j=1:length(Isv)
        idy=Isv(j);
        vecBp(i) = vecBp(i) - vecAlpha(idy)*vecY(idy)*MatK(idx,idy);
    end
end
%disp('Bp');
%disp(vecBp);
Bast = mean(vecBp);
end