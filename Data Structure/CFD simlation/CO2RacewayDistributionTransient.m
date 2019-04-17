addpath('./PIV'); % add PIV for parfor_progress.m
path='C:\CFD_second_HHD\racewayOpenfoam\01232018\16\data\';
files=dir([path 'case2*']);
maxConcentration=0.08; % 0.08 is the mass fraction= NaHCO3/solution
close all;
threholdLow=0.00025;
threholdHigh=0.01; % remove the high concentration cell so that the distributio is more detailed

% %% readFiles
% datTime=[];
% for i=1:length(files)
%     % sort files based on time
%     for j=1:length(files)
%         try
%             datTime(j,1)=sscanf(files(j).name,'case2-%f');
%         end
%     end
%     [datTime,index]=sort(datTime);
%     files=files(index);
% end
% 
% data=[];
% parfor_progress(length(files));
% parfor i=1:length(files)
%     filename=files(i).name;
%     delimiterIn = ','; %read txt file
%     headerlinesIn=11;
%     fprintf('reading %s \n',[path filename]);
%     tmp= importdata([path filename],delimiterIn,headerlinesIn);
%     data(i).data=single(tmp.data);
%     data(i).filename=filename;
%      parfor_progress;
% end
% parfor_progress(0);
% 
% clearvars -except data  path
% fprintf('storing all data to data.............. \n');
% save(['C:\CFD_second_HHD\racewayOpenfoam\01232018\16\data-case2.mat'], '-v7.3');


%% plot
% format: cellnumber,    x-coordinate,    y-coordinate,    z-coordinate,     cell-volume,        w-nahco3,           w-vof
figure;
set(gcf,'outerposition',get(0,'screensize'));
minCellVolume=min(data(1).data(:,5));

FIRST=1;
for i=1:length(data)
    dataI=data(i).data;
    %     dataI(:,6)*dataI(:,5)/maxCellVolume;
    filename=data(i).filename;
    totalCell=length(dataI);
    waterCell=dataI(find(dataI(:,7)>=0.5),:);
    %     highConcenCell=waterCell(find(waterCell(:,6)>=threholdLow),:);
    %     highPercentage=length(highConcenCell)/length(waterCell)*100;
    lowConCell=waterCell(find(waterCell(:,6)<=threholdHigh),:);
    if FIRST
        totalCellVOlume=sum(waterCell(:,5));
        FIRST=0;
    end
    weightDistribution=lowConCell(:,6);
    weightDistribution(:,2)=lowConCell(:,5)/minCellVolume;
    weightDistribution=sortrows(weightDistribution);
    [histCounts,centers] = hist(lowConCell(:,6),1000);
    weightCounts=zeros(length(histCounts),1);
    j=1;
    for i=1:length(histCounts)
        weightCounts(i)=sum(weightDistribution(j:j+histCounts(i)-1,2));
        j=j+histCounts(i);
    end
    %     counts=counts/length(waterCell)*100;
    weightCounts=weightCounts/(totalCellVOlume/minCellVolume)*100;
    sum(weightCounts);
    bar(centers,weightCounts);
    ylim([0 10]);
    xlim([0 8e-3]);
    ylabel('percent')
    xlabel('mass fraction, injection mass fraction=0.08');
    uniformity=std(weightCounts) ;
    title(['Case ' filename   ' seconds Uniformity=' num2str(uniformity)]);
    
%     %% save plot
%     saveas(gcf,[path filename '.png']);
%     fprintf('saved as %s\n', [path filename '.png']);
    
    pause(0);
end



%% plot mesh
% vtkFile='C:\CFD_second_HHD\racewayOpenfoam\01192019\10\racewayWall.vtk';
% Plot_VTK_mesh(vtkFile);
% hold on;
% scatter3(highConcenCell(:,2),highConcenCell(:,3),highConcenCell(:,4),100,'filled');
% xlabel('x');
% ylabel('y');
% zlabel('z');

