function [ svmstruct ] = mysvmtrain( data, groups, varargin )
%MYSVMTRAIN [ svmstruct ] = mysvmtrain( data, groups, varargin )
%varargin
%'mkifarsvm'
%   method C vecSigma lpos lneg
%'mkisvm'
%   method C vecSigma


groups = logical(groups);
Ntr = size(data,1);
if numel(varargin)==0
    Nk = 1;
    vecSigma = 1;
    vecC = ones(Ntr,1);
else
    lvarargin = numel(varargin);
    method = varargin{1};
    C = varargin{2};
    options = varargin(3:lvarargin);
    switch method
        case 'mkifarsvm'
            
            if ~(numel(options)==3)
                disp('argument error.');
                return;
            end
            vecSigma=options{1};
            Nk = length(vecSigma);
            lpos = options{2};
            lneg = options{3};
            vecC=C/lneg*ones(Ntr,1);
            vecC(TrPtGp)=vecC(TrPtGp)*lneg/lpos;
        case 'mkisvm'
            if ~(numel(options)==1)
			disp('argument error.');
			return;
            end
            vecC=C*ones(Ntr,1);
            vecSigma=options{1};
            Nk = length(vecSigma);
        otherwise
            disp('error method');
            return;
    end
end
vecY = -1*ones(length(groups),1);
vecY(groups) = 1;
[x y info] = solvesdefprog(data,groups,vecC,vecY,vecSigma);
vecMu = y(1:Nk);
vecNu = y(Nk+1:Nk+Ntr);
vecDelta = y(Nk+Ntr+1 : Nk+Ntr*2);
varLamda = y(Nk+Ntr*2+1);
MatK = multker(data,vecSigma,vecMu);
vecAlpha = ( diag(vecY) * MatK * diag(vecY) ) \ ...
    (ones(Ntr,1) + vecNu - vecDelta + varLamda*vecY );
[Bias Isv] = calcBast(MatK,vecY,vecAlpha,vecC);
svmstruct = struct('TrainingData',data,'GroupNames',groups,...
    'vecAlpha',vecAlpha,'Bias',Bias,'Isv',Isv,'vecY',vecY,...
    'vecSigma',vecSigma,'vecMu',vecMu,'sdpinfo',info);
end

