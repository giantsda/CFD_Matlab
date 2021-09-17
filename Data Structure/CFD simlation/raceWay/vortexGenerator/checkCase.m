close all;
figure;
set(gcf,'outerposition',get(0,'screensize'));
oPath=pwd();
MainPath='D:\CFD_second_HHD\06232021\204\Data';
opath=pwd();
cd (MainPath);
criticalU4=[];

for i=[213]
    ii=1;
    caseN=i
    Data={};
    cd (MainPath);
    load(['Data_' num2str(caseN) '.mat']);
    fprintf("Done with reading data.\n");
    
    Ucritical=0.18;
    
    for timeIndex=1:length(Data.U)
        index=zeros(size(Data.vof));
        for j=timeIndex
            index(abs(Data.U{j}(:,3))>Ucritical)=index(abs(Data.U{j}(:,3))>Ucritical)+1;
        end

%         for j=timeIndex
%             index(abs(Data.U{j}(:,3))>Ucritical)=index(abs(Data.U{j}(:,3))>Ucritical)+1;
%         end

        ii=find(index>=1);
        xmin=min(Data.mesh(:,1));
        xmax=max(Data.mesh(:,1));
        ymin=min(Data.mesh(:,2));
        ymax=max(Data.mesh(:,2));
        
        scatter3([xmin xmax],[ymin ymax],[0 0],18,[1 1],'filled')
        hold on
        scatter3(Data.mesh(ii,1),Data.mesh(ii,2),Data.mesh(ii,3),18,Data.vof(ii),'filled')
        axis equal;
        view(0,90);
        title(['case=' num2str(caseN) '  Ucritical=' num2str(Ucritical) ' time=' num2str(Data.time(timeIndex))])
        colormap jet;
        colorbar; 
        pause(0.1);
    end
%     saveas(gcf,['D:\CFD_second_HHD\02212020\130\Data\checkCase\checkCase_' num2str(caseN) '.png'])
%     pause();
end
% load handel.mat;
% soundsc(y, 2*Fs);
cd(oPath);

