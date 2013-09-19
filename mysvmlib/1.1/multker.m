function [ mker ] = multker( mt, lpar, lu)
%MULTKER Summary of this function goes here
%   Detailed explanation goes here
if ~(equals(sum(lu),1)==0)
    disp('This message means the weight vectors were not normalized.');
    disp('And we have done it automatically.');
    lu=lu/sum(lu);
end
if ~(length(lpar)==length(lu))
    disp('The numbers of parameters and weights do not match.');
    return;
end

Lfeature = size(mt,1);
Lpara = length(lpar);
mker = zeros(Lfeature);
for i=1:Lpara
    mker=mker+lu(i)*matker(mt,lpar(i));
end

end

