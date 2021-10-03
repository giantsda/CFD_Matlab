% load('D:\CFD_second_HHD\07162021\242\242\800s\results.mat')

close all;


figure;
set(gcf,'outerposition',get(0,'screensize'));

% 
% oPath=pwd();
% MainPath='D:\CFD_second_HHD\02212020\130\Data';
% cd (MainPath);
% fileName="C:\Users\chenshen.ETS01297\Desktop\temp\plot\PT\fig4.csv";
% x=linspace(0,0.3,1000).';
% write=[x];
% UzS={};
% for caseI=[1:40 49:56]
%     caseN=caseI
%     Uz=[];
%     cd (MainPath);
%     load(['Data_' num2str(caseN) '.mat']);
%     fprintf("Done with reading data.\n");
%     for i=1:length(Data.U)
%         Uz{i}=Data.U{i}(:,3);
%     end
%     Uz=vertcat(Uz{:});
% %     hist(Uz,1111)
%     n=randi(length(Uz),7000000,1);
%     UZZZ=double(Uz(n));
%     UZZZ(UZZZ<=0)=[];
%     UzS{caseI}=UZZZ;
% end
% 
% 
 x=linspace(0,0.4,1000).';

% mseS=[];
fileName="C:\Users\chenshen.ETS01297\Desktop\temp\plot\PT\fig6.csv";
% write=[x];
lambda=[];

for caseI=[1:40 49:56]
    caseI
    Uz=UzS{caseI}(1:end);
    
%     [f,xi] = ksdensity(Uz,x,'Support','positive');
%     plot(xi,f);
%     hold on;
    
    pd = fitdist(Uz,'Exponential');
    pdfEst = pdf(pd,x);
    lambda(caseI)=pdfEst(1);
    
%     plot(x,pdfEst)
%     mse=mean(sum((f(2:end)-pdfEst(2:end)).^2));
%     mseS(caseI)=mse;
%     write=[write f];
%     pd = makedist('Exponential');  
%     h=qqplot((Uz),pd);
%     h(1).Marker = '+';
%     h(2).LineStyle = '*';
%     h(3).LineStyle = 'o';
%     hold on;
 
 
end
% xlim([0 0.2])
% csvwrite(fileName,write);
 



