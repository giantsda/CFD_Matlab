%  close all
% [f,xi] = ksdensity(interval,linspace(0,80,1000));
% plot(xi,f);
% hold on;
% pd = fitdist(interval.','Lognormal');
% pdfEst = pdf(pd,linspace(0,80,1000));
% plot(linspace(0,80,1000),pdfEst)
%
%
%

% r = normrnd(10,2,[2000000,1]);
% expR=exp(r);
% expR(expR>200000)=[];
% hist(expR,20000)
% xlim([0 60])


%  hist(interval,200);
%  aa=log(interval);
%  hist(aa,200);

% for i=1:100
%     yp =particle{i}(:,5);
%     diffyP=[diffyP; diff(yp)];
%
% end
% hist(diffyP,2000);



% sum(r)
% x0=0;
% x(1)=0;
% x=zeros(1,1000000);
% a(0)=0;
% for i=1:1000000
%  
%     r = normrnd(0,0.1,[1000,1]);
%     x(i)=sum(r);
% end
% hist(x,3000)



% [pks,locs] = findpeaks(x,'MinPeakHeight',-200,'MinPeakProminence',20);
%   
% time_interval=diff(locs);
% hist(time_interval,1111)
 

% hist(x,1111)
t=1:10000;
x = rand([1,10000]);
tp=linspace(1,10000,100000000);
xp=interp1(t,x,tp,'spline');
plot(tp,xp,'*-');
 

% hist(x)
dx=diff(x);
% hist(dx,1000)

[pks,locs] = findpeaks(xp,'MinPeakHeight',0.4,'MinPeakProminence',0.1);
  
time_interval=diff(tp(locs));
hist(log(time_interval),1111)

% yps=[];
% for i=1:1000
%     yp =particle{i}(:,5);
%     diffyP=[diffyP; diff(yp)];
%     yps=[yps;yp];
% 
% end
% 
% hist(diffyP,200);





