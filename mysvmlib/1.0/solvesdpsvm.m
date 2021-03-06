%{
min bt * y
At * y = ct

y=[	vecMu	vecNu	vecDelta	varLamda	varT ]
    Nk      Ntr     Ntr         1           1

lpos
lneg
C * vec_e
cpos=C/lpos
cneg=C/lneg
vecC = [cpos ... cneg...]
    Constrants for soft margin
vecC            Ntr
vecDelta        Ntr
vecNu           Ntr
vecMu           Nk
varLamda
varT
vecSigma        Nk

Nk
Ntr

TrPt
TrPtGp

MatA consists of semidefinite matrix
M0 + y1*M1 + y2*M2 + ... + yn*Mn >=0 is semidefinite
yi correspends to variables such as t Nu Mu Lamda Delta
%}

function [x y info vecC vecY] = solvesdpsvm(Nk,C,TrPt,TrPtGp,method,varargin)
%SOLVESDP formulate a semidefinite matrix problem and then solve it.
if ~(size(TrPt,1)==size(TrPtGp))
    disp('Training materials do not match.');
end;
TrPtGp=logical(TrPtGp);
vecY = -1*ones(length(TrPtGp),1);
vecY(TrPtGp) = 1;
Ntr = size(TrPt,1);
switch method
    case 'mkifarsvm'
        if ~(numel(varargin)==3)
            disp('argument error.');
            return;
        end
		vecSigma=varargin{1};
        lpos = varargin{2};
        lneg = varargin{3};
        vecC=C/lneg*ones(Ntr,1);
        vecC(TrPtGp)=vecC(TrPtGp)*lneg/lpos;
        %{
        equivalently
        for i=1:Ntr
            if TrPtGp(i)==1
                vecC(i)=vecC(i)/lpos;
            else
                vecC(i)=vecC(i)/lneg;
            end
        end
        %}
    case 'mkisvm'
		if ~(numel(varargin)==1)
			disp('argument error.');
			return;
		end
        vecC=C*ones(Ntr,1);
        vecSigma=varargin{1};
    otherwise
        disp('error method.');
        return;
end

%Determine the elements of semidefinite matrix
LMat=Nk+2*Ntr+3;
SizMat=Ntr+1;
MatA=cell(1,LMat);
for i=1:LMat
    MatA{i}=zeros(SizMat);
end
%for kernel matrix
for i=1:Nk
    MatA{i}(1:Ntr,1:Ntr) = matker(TrPt,vecSigma(i));
    MatA{i}(1:Ntr,1:Ntr) = diag(vecY)*MatA{i}(1:Ntr,1:Ntr)*diag(vecY);
end
%for Nu
for i=1:Ntr
    idx=i+Nk;
    MatA{idx}(SizMat,i)=1;
    MatA{idx}(i,SizMat)=1;
end
%for Delta
for i=1:Ntr
    idx=i+Nk+Ntr;
    MatA{idx}(SizMat,i)=-1;
    MatA{idx}(i,SizMat)=-1;
    MatA{idx}(SizMat,SizMat)=-2*vecC(i);
end
%for Lamda
idx=Nk+2*Ntr+1;
for i=1:Ntr
    MatA{idx}(SizMat,i)=vecY(i);
    MatA{idx}(i,SizMat)=vecY(i);
    %{
    MatA{idx}(1:Ntr,SizMat)=vecY;
    MatA{idx}(SizMat,1:Ntr)=vecY';
    %}
end
%for t
idx=Nk+2*Ntr+2;
MatA{idx}(SizMat,SizMat)=1;
%for Constant constraints
idx=LMat;
MatA{idx}(1:Ntr,SizMat)=ones(Ntr,1);
MatA{idx}(SizMat,1:Ntr)=ones(1,Ntr);


%Determine the equation matrix
M1 = zeros(1,LMat-1);
M1(1:Nk) = ones(1,Nk);
ct1 = 1;
K.f = 1;

%Determine the inequality matrix
M2 = zeros(Nk+Ntr*2,LMat-1);
M2(1:Nk,1:Nk) = eye(Nk);
M2(Nk+1:Nk+Ntr,Nk+1:Nk+Ntr) = eye(Ntr);
M2(Nk+Ntr+1:Nk+Ntr*2,Nk+Ntr+1:Nk+Ntr*2) = eye(Ntr);
%{
equivalently
M2(1:Nk+Ntr*2,1:Nk+Ntr*2)=eye(Nk+Ntr*2);
%}
ct2 = zeros(Nk+Ntr*2,1);
K.l = Nk+Ntr*2;

%Determine the semidefinite matrix
M3=zeros(SizMat^2,LMat-1);
for i=1:LMat-1
    M3(:,i)=vec(MatA{i});
end
K.s = SizMat;

%determine the coefficient matrix
At = [ M1; -M2; -M3 ];
bt=zeros(LMat-1,1);
bt(LMat-1)=-1;
ct = [ ct1; -ct2; vec(MatA{LMat})];
%{
test
K
size(At)
size(bt)
size(ct)
%}
[x y info] = sedumi(At,bt,ct,K);