%The length of the straight channel does not significantly change the critical velocity,
%thus the critical vertical velocity is redefined as the 20 percent of the vertical velocity
%in the box that is defined as a rectangle of radius and 2*radius.

MainPath='D:\CFD_second_HHD\02212020\130\Data';
cd (MainPath);
 
 
 
MeanmagU=zeros(1,62);
MeanUx=zeros(1,62);
for i=[1:62]
    caseN=i
    Data={};
    cd (MainPath);
    load(['Data_' num2str(caseN) '.mat']);
  
    %% Find the examine box.
    radius=(max(Data.mesh(:,2))-min(Data.mesh(:,2)));
    leftPoint=min(Data.mesh(:,1));
    box=find(Data.mesh(:,1)<leftPoint+5*radius & Data.mesh(:,1)>leftPoint+4*radius);
    Data.mesh=Data.mesh(box,:);
    Data.vof=Data.vof(box,:);
    magUS=[];
    MeanmagUS=[];
    for n=1:length(Data.U)
        Data.U{n}=Data.U{n}(box,:);
        Us= Data.U{n};
        MagU=sqrt(Us(:,1).^2+Us(:,2).^2+Us(:,3).^2);
        MeanmagUS(n)=mean(MagU);
    end
    
    fprintf("Done with reading data.\n");
 
    plot(Data.time,MeanmagUS);
 
    MeanmagU(caseN)=mean(MeanmagUS);
%     title(['case=' num2str(caseN) ' MeanmagU=' num2str(mean(MeanmagUS)) ]);
%     saveas(gcf,['D:\CFD_second_HHD\02212020\130\Data\MeanmagU_' num2str(i) '.png'])
    
end

% clearvars -except MeanmagU MeanUx MainPath
% save([MainPath '/MeanVekocity.mat'], '-v7.3');
% disp('store UcriticalStore to MainPath.............. \n');

% MeanmagUSorted=MeanmagU(results.Index);
% MeanUxSorted=MeanUx(results.Index);
% plot(MeanmagUSorted);
% hold on;
% plot(MeanUxSorted);


scatter3(Data.mesh(:,1),Data.mesh(:,2),Data.mesh(:,3),15,MagU,'filled');
axis equal;
colormap jet;
colorbar

