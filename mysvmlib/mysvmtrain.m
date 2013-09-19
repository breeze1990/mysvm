function [ svmstruct ] = mysvmtrain( data, groups, varargin )
%MYSVMTRAIN Summary of this function goes here
%   Detailed explanation goes here
if numel(varargin)==0
    Nk = 1;
    vecSigma = 1;
    varC = 1;
else
    lvarargin = numel(varargin);
    method = varargin{1};
    switch method
        case 'mkifarsvm'
            options = varargin{2:lvarargin};
        case 'mkisvm'
            optinos = varargin{2:lvarargin};
        otherwise
            disp('error method');
            return;
    end
end

solvesdefprog

end

