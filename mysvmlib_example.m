%y=[	vecMu	vecNu	vecDelta	varLamda	varT ]
%       Nk      Ntr     Ntr         1           1

acc = 5e-5;
generate;
Nk = 1;
varC = 1;
Ntr = length(groups);
vSigma = [0.8];
[x y info vecC vecY] = solvesdpsvm(Nk,varC,data,groups,'mkisvm',vSigma);
vecMu = y(1:Nk);
vecNu = y(Nk+1:Nk+Ntr);
vecDelta = y(Nk+Ntr+1 : Nk+Ntr*2);
varLamda = y(Nk+Ntr*2+1);
MatK = multker(data,vSigma,vecMu);
vecAlpha = ( diag(vecY) * MatK * diag(vecY) ) \ ...
    (ones(Ntr,1) + vecNu - vecDelta + varLamda*vecY );
%Isv = find(abs(vecAlpha)>=acc);

[Bast Isv] = calcBast(MatK,vecY,vecAlpha,vecC);

%Xt is a test point
Dtr = data;
Gtr = groups;
generate;
Ct = zeros(length(groups),1);
for i=1:Ntr
Xt = data(i,:);
Ct(i) = disfunction(Xt,Dtr,Isv,Bast,vecAlpha,vecY,vecMu,vSigma);
end
bCt = Ct>0;

figure,hold
plot(Dtr(Gtr,1),Dtr(Gtr,2),'r.');
plot(Dtr(~Gtr,1),Dtr(~Gtr,2),'b.');
plot(data(bCt,1),data(bCt,2),'rx');
plot(data(~bCt,1),data(~bCt,2),'bx');
