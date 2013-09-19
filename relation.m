function [ res ] = relation( x, y, opt )
%RELATION Caculate the relation between x and y
%and decides which catogory (x,y) belongs.

switch opt
    case 'linear',
        if y>=x
            res=1;
        else
            res=0;
        end;
    case 'circular',
        if sqrt((x-2)^2+(y-2)^2)>2
            res=1;
        else
            res=0;
        end
    otherwise,
        sprintf('no such relation');
end
end

