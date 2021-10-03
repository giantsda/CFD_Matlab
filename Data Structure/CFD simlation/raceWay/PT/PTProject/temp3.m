
 
close all



n=randi(length(Uz),1000000,1);
 
 
UZZZ=double(Uz(n));
UZZZ(UZZZ<=0)=[];

% hist(UZZZ,1111);

[f,xi] = ksdensity(UZZZ,x,'Support','positive');
plot(xi,f);
hold on;
 

pd = makedist('Exponential');
qqplot(UZZZ,pd)


pd = fitdist(UZZZ,'Exponential')
 
x=linspace(-0.2,0.2,1000).';
y = pdf(pd,x);
plot(x,y)