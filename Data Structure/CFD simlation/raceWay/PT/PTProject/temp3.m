

close all
x=linspace(0,0.2,1000);
fileName="C:\Users\chenshen.ETS01297\Desktop\temp\plot\PT\fig5b.csv";
write=[x.'];
for caseI=[25:32]
    caseI
    
    UZZZ=double(UzS{caseI});
    % UZZZ(UZZZ<=0)=[];
    
    % hist(UZZZ,1111);
    haha=abs(UZZZ);
    [f,xi] = ksdensity(haha,x,'Support','positive','Bandwidth',0.4);
    plot(xi,f);
    hold on;
    write=[write f.' ];
    
%     pd = makedist('Exponential');
%     qqplot(UZZZ,pd)
%     pd = fitdist(UZZZ,'Exponential')
    
%     x=linspace(-0.2,0.2,1000).';
%     y = pdf(pd,x);
%     plot(x,y)

end


% csvwrite(fileName,write);
