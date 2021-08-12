close all;
figure;
set(gcf,'outerposition',get(0,'screensize'));

MainPath='D:\CFD_second_HHD\02212020\130\Data';
cd (MainPath);
caseN=32;
load(['Data_' num2str(caseN) '.mat']);
Ucritical=0.399902344


 for timeIndex=1:length(Data.U)
    index=zeros(size(Data.vof));
    for j=1:timeIndex
        index(abs(Data.U{j}(:,3))>Ucritical)=1;
    end
    ii=find(index==1);
    scatter3(Data.mesh(ii,1),Data.mesh(ii,2),Data.mesh(ii,3),6,Data.U{j}(ii,1),'filled')
    axis equal;
    view(0,90);
    title(['case=' num2str(caseN) '  Ucritical=' num2str(Ucritical) ' time=' num2str(Data.time(timeIndex))])
    colormap jet;
    colorbar;
    pause();
 end
 
 
 
 
 