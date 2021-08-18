%The length of the straight channel does not significantly change the critical velocity,
%thus the critical vertical velocity is redefined as the 20 percent of the vertical velocity
%in the box that is defined as a rectangle of radius and 2*radius.

MainPath='D:\CFD_second_HHD\02212020\130';
cd (MainPath);
inspectLocationRaduis=0.05;


MeanCU3=zeros(1,62);
MeanUx=zeros(1,62);
for i=[13]
    caseN=i
    Data={};
    cd (MainPath);
    cd (num2str(i));
    load('Data.mat');
    
    %% Find the examine box.
    radius=(max(Data.mesh(:,2))-min(Data.mesh(:,2)));
    leftPoint=min(Data.mesh(:,1));
    box=find(Data.mesh(:,1)<leftPoint+2*radius);
    Data.mesh=Data.mesh(box,:);
    Data.vof=Data.vof(box,:);
    magUS=[];
    MeanmagUS=[];
    UcriticalS3=[];
    for n=1:length(Data.U)
        Data.U{n}=Data.U{n}(box,3);
        Us=abs(Data.U{n});
        Us=sort(Us);
        UcriticalS3(n)=Us(floor(length(Us)*(1-0.03)));
    end
    
    fprintf("Done with reading data.\n");
%     figure;
    plot(Data.time,UcriticalS3);
    title(num2str(i));
    MeanCU3(i)=mean(UcriticalS3);
    
    title(['UcriticalS3=' num2str(MeanCU3(i)) ]);
    saveas(gcf,['C:\Users\chenshen.ETS01297\Desktop\temp\k\CU3_' num2str(i) '.png'])
    
    %     load handel
    %     sound(y/5,Fs)
end
load handel
sound(y/5,Fs)




