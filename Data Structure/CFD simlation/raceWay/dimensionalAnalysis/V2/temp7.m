%The length of the straight channel does not significantly change the critical velocity,
%thus the critical vertical velocity is redefined as the 20 percent of the vertical velocity
%in the box that is defined as a rectangle of radius and 2*radius.

MainPath='D:\CFD_second_HHD\02212020\130';
cd (MainPath);
inspectLocationRaduis=0.05;
UcriticalPercentage=0.15;
 
% MeanmagU=[];
% MeanUx=[];
for i=1:62
    caseN=i
    Data={};
    cd (MainPath);
    cd (num2str(i));
    load('Data.mat');
 
 
    fprintf("Done with reading data.\n");
    
    Us=vertcat(Data.U{:});
    magU=sqrt(Us(:,1).^2+Us(:,2).^2+Us(:,3).^2);
    MeanmagU(caseN)=mean(magU);
    MeanUx(caseN)=mean(abs(Us(:,1)));
    
%     load handel
%     sound(y/5,Fs)
end
% 
% clearvars -except MeanmagU MeanUx MainPath
% save([MainPath '/MeanVekocity.mat'], '-v7.3');
% disp('store UcriticalStore to MainPath.............. \n');
% 
