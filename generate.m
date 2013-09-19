MAXN=50;
data=zeros(MAXN,2);
groups=logical(zeros(MAXN,1));
for i=1:MAXN
    x=rand*5;
    y=rand*5;
    data(i,:)=[x y];
    if relation(x,y,'circular')
        groups(i)=1;
    else
        groups(i)=0;
    end
end