[counts,centers] = hist(interval,200);
counts=counts/sum(counts);

interval((interval==0))=[];
interval=double(interval);
parmHat = wblfit(interval);
plot(centers,counts);
cftool(centers,counts)



hold on;
x=centers;
a=parmHat(1);
b=parmHat(2);

y=a*b*x.^(b-1).*exp(-a.*x.^b)

plot(x,y)