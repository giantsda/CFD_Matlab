% load('D:\CFD_second_HHD\07162021\242\242\800s\results.mat')

close all;
x=linspace(0,30,1000).';

% mseS=[];
fileName="C:\Users\chenshen.ETS01297\Desktop\temp\plot\PT\fig2b.csv";
write=[x];
caseI=17;
caseI
interval=result{caseI}.interval;
[f,xi] = ksdensity(interval,x,'Support','positive','Bandwidth',0.2);
write=[write f  ];
plot(xi,f);
hold on;
pd = fitdist(interval.','logNormal');
pdfEst = pdf(pd,x);
write=[write pdfEst];
plot(x,pdfEst)
% pd = fitdist(interval.','Logistic');
% pdfEst = pdf(pd,x);
% write=[write pdfEst];
% plot(x,pdfEst)
% pd = fitdist(interval.','Rayleigh');
% pdfEst = pdf(pd,x);
% write=[write pdfEst];
% plot(x,pdfEst)
% pd = fitdist(interval.','Gamma');
% pdfEst = pdf(pd,x);
% write=[write pdfEst];
% plot(x,pdfEst)
% pd = fitdist(interval.','Weibull');
% pdfEst = pdf(pd,x);
% write=[write pdfEst];
% plot(x,pdfEst)
 
mse=mean(sum((f-pdfEst).^2));
%     mseS(caseI)=mse;
write=[write f pdfEst];
hold on;
xlim([0 50])

legend('x','1','2','3','4','5')

% csvwrite(fileName,write);




