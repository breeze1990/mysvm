function [ out ] = equals( a,b )
%EQUALS Determines if two numbers are equal
%   within certain accuracy
acc = 5e-5;
if abs(a-b)<acc
    out = 0;
else
    if (a-b)>=acc
        out = 1;
    else
        out = -1;
    end
end
end

