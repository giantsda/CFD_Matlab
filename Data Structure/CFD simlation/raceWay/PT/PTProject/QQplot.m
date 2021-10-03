% load('D:\CFD_second_HHD\07162021\242\242\800s\results.mat')

close all;
x=linspace(0,30,1000).';

% mseS=[];
fileName="C:\Users\chenshen.ETS01297\Desktop\temp\plot\PT\fig2.csv";
write=[x];
for caseI=[13  ]
    caseI
    interval=result{caseI}.interval;
    [f,xi] = ksdensity(interval,x,'Support','positive');
    plot(xi,f);
    hold on;
    pd = fitdist(interval.','logNormal');
    pdfEst = pdf(pd,x);
    plot(x,pdfEst)
    mse=mean(sum((f-pdfEst).^2));
%     mseS(caseI)=mse;
    write=[write f pdfEst];
%     pd = makedist('Normal');  
%     qqplot((interval),pd)
    hold on;
    
%     hold on;
xlim([0 50])
%     caseI
%     interval1=result{caseI}.interval;
%     interval2=result{caseI+1}.interval;
%     qqplot(interval1,interval2)
%     hold on;

% pause();
end

% csvwrite(fileName,write);
 



