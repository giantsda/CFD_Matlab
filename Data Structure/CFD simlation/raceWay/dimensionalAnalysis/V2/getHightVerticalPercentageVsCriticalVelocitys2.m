%The length of the straight channel does not significantly change the critical velocity,
%thus the critical vertical velocity is redefined as the 20 percent of the vertical velocity
%in the box that is defined as a rectangle of radius and 2*radius.
figure;
set(gcf,'outerposition',get(0,'screensize'));

criticalDistanceS=[];
MainPath='D:\CFD_second_HHD\02212020\130';
cd (MainPath);

UcriticalS=0.06:0.01:0.28;
% resultsnew={};
for i=1:56
%     i=40
    caseN=i
    
    Ucritical=results{caseN}.UcriticalS;
    percentage=results{caseN}.percentage;
    Ucritical=[0 Ucritical];
    percentage=[1 percentage];
    
    highEndUcritical = interp1(percentage,Ucritical,0,'spline','extrap')*1.3;
    
    highEndUcritical=0.30;
    UcriticalS=0.0:0.002:highEndUcritical;
    Data={};
    cd (MainPath);
    cd (num2str(caseN));
    load('Data.mat');
    
    
    DataS=abs(vertcat(Data.U{:}));
    DataS=DataS(:,3);
    for i=1:length(UcriticalS)
        Ui=i;
        Ucritical=UcriticalS(i);
        percentage=length(find(DataS>Ucritical))/length(DataS);
        resultsnew{caseN}.UcriticalS(Ui)=UcriticalS(Ui);
        resultsnew{caseN}.percentage(Ui)=percentage;
        
    end
    load handel
    sound(y/5,Fs)
    %     plot(UcriticalS,criticalDistanceS,'*-');
    %     saveas(gcf,['C:\Users\chenshen.ETS01297\Desktop\temp\k\case' num2str(caseN) '_criticalDistanceSVsUcriticalS.png']);
end
clearvars -except resultsnew MainPath
save([MainPath '/resultsnew.mat'], '-v7.3');
disp('store UcriticalStore to MainPath.............. \n');



