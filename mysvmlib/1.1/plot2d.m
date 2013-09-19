function [ ] = plot2d( data, groups,varargin )
%PLOT2D Summary of this function goes here
%   Detailed explanation goes here
if numel(varargin)==0
    figure;
    style='.';
else
    fid = varargin{1};
    figure(fid);
    style=varargin{2};
end
hold on;
plot(data(groups,1),data(groups,2),strcat('r',style));
plot(data(~groups,1),data(~groups,2),strcat('b',style));
hold off;
end