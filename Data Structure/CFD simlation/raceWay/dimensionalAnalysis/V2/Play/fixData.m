%The length of the straight channel does not significantly change the critical velocity,
%thus the critical vertical velocity is redefined as the 20 percent of the vertical velocity
%in the box that is defined as a rectangle of radius and 2*radius.

MainPath='D:\CFD_second_HHD\02212020\130';
% MainPath='/scratch/chenshen/chenshen/project/';
cd (MainPath);

for i= [1:62]
    caseN=i
    Data={};
    cd (MainPath);
    cd (num2str(i));
    load('Data.mat');
    
    i=find(Data.mesh(:,3)>0.18); % remove the nodes that is adjcent to air. Data here will have close to 1 vof but huge velocity.
    if ismember(caseN,[9:16,57])
        i=find(Data.mesh(:,3)>0.15); % remove the nodes that is adjcent to air. Data here will have close to 1 vof but huge velocity.
    end
    if ismember(caseN,[17:24,58])
        i=find(Data.mesh(:,3)>0.24); % remove the nodes that is adjcent to air. Data here will have close to 1 vof but huge velocity.
    end
    Data.mesh(i,:)=[];
    Data.vof(i,:)=[];
    for n=1:length(Data.U)
        Data.U{n}(i,:)=[];
    end
    
    
    fprintf("Done with reading data for case %d.\n",caseN);
    
    save([MainPath '/Data/Data_' num2str(caseN) '.mat'],'Data', '-v7.3');
    disp('store UcriticalStore to MainPath.............. \n');
end


load handel
sound(y/5,Fs)

