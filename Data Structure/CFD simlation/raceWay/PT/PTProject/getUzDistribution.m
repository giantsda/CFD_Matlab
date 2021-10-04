figure;
set(gcf,'outerposition',get(0,'screensize'));


oPath=pwd();
MainPath='D:\CFD_second_HHD\02212020\130\Data';
cd (MainPath);

fileName="C:\Users\chenshen.ETS01297\Desktop\temp\plot\PT\fig4.csv";
x=linspace(0,0.3,1000).';
write=[x];
UzS={};
for caseI=[25:32]
     
    Uz=[];
    cd (MainPath);
    load(['Data_' num2str(caseI) '.mat']);
    fprintf("Done with reading data.\n");
    for i=1:length(Data.U)
        Uz{i}=Data.U{i}(:,3);
    end
    Uz=vertcat(Uz{:});
%     hist(Uz,1111)

    n=randi(length(Uz),200000,1);
    UZZZ=double(Uz(n));
%     UZZZ(UZZZ<0)=[];
    UzS{caseI}=UZZZ;
%     [f,xi] = ksdensity(UZZZ,x,'Support','positive','Bandwidth',0.2);
%     plot(xi,f);
    hold on;
%     write=[write  f];
end
xlim([-0.2,0.2])
% csvwrite(fileName,write);


