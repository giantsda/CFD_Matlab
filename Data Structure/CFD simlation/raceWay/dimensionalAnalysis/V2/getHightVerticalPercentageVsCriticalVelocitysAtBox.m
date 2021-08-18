%The length of the straight channel does not significantly change the critical velocity,
%thus the critical vertical velocity is redefined as the 20 percent of the vertical velocity
%in the box that is defined as a rectangle of radius and 2*radius.
figure;
set(gcf,'outerposition',get(0,'screensize'));

criticalDistanceS=[];
MainPath='D:\CFD_second_HHD\02212020\130';
cd (MainPath);

 
PercentageVsUAtBox={};
for i=1:56
%     i=40
    caseN=i
 highEndUcritical=resultsnew{caseN}.UcriticalS(end);
    UcriticalS=0.0:0.002:highEndUcritical;
    Data={};
    cd (MainPath);
    cd (num2str(caseN));
    load('Data.mat');
     %% Find the examine box.
    radius=(max(Data.mesh(:,2))-min(Data.mesh(:,2)));
    leftPoint=min(Data.mesh(:,1));
    box=find(Data.mesh(:,1)<leftPoint+2*radius);
    Data.mesh=Data.mesh(box,:);
    Data.vof=Data.vof(box,:);
    for n=1:length(Data.U)
        Data.U{n}=Data.U{n}(box,3);
    end
    fprintf("Done with reading data.\n");
    
 
    DataS=abs(vertcat(Data.U{:}));
 
    for i=1:length(UcriticalS)
        Ui=i;
        Ucritical=UcriticalS(i);
        percentage=length(find(DataS>Ucritical))/length(DataS);
        PercentageVsUAtBox{caseN}.UcriticalS(Ui)=UcriticalS(Ui);
        PercentageVsUAtBox{caseN}.percentage(Ui)=percentage;
        
    end
%     load handel
%     sound(y/5,Fs)
    %     plot(UcriticalS,criticalDistanceS,'*-');
    %     saveas(gcf,['C:\Users\chenshen.ETS01297\Desktop\temp\k\case' num2str(caseN) '_criticalDistanceSVsUcriticalS.png']);
end
clearvars -except PercentageVsUAtBox MainPath
save([MainPath '/PercentageVsUAtBox.mat'], '-v7.3');
disp('store UcriticalStore to MainPath.............. \n');



