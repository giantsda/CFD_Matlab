path='C:\CFD_second_HHD\racewayOpenfoam\01232018\15\';
files=dir([path '*solution']);
maxConcentration=0.08; % 0.08 is the mass fraction= NaHCO3/solution
close all;
threholdLow=0.00025;
threholdHigh=0.0014;

data=[];
for i=1:length(files)
    filename=files(i).name;
    delimiterIn = ','; %read txt file
    headerlinesIn=11;
    fprintf('reading %s \n',[path filename]);
    tmp= importdata([path filename],delimiterIn,headerlinesIn);
    data(i).data=tmp.data;
    data(i).filename=filename;
end

%% plot
% format: cellnumber,    x,    y,    z,        w-nahco3,           w-vof
figure;
set(gcf,'outerposition',get(0,'screensize'));
for i=1:length(data)
    dataI=data(i).data;
    filename=data(i).filename;
    totalCell=length(dataI);
    waterCell=dataI(find(dataI(:,6)>=0.5),:);
    highConcenCell=waterCell(find(waterCell(:,5)>=threholdLow),:);
    highPercentage=length(highConcenCell)/length(waterCell)*100;
    lowConCell=waterCell(find(waterCell(:,5)<=threholdHigh),:);
    [counts,centers] = hist(lowConCell(:,5),1000);
    counts=counts/length(waterCell)*100;
    bar(centers,counts);
    ylim([0 1])
    uniformity=std(counts) ;
    title(['Case ' filename ': mass fraction>=' num2str(threholdLow) 'is ' num2str(highPercentage) ...
        '% Uniformity=' num2str(uniformity)]);
    
%     %% save plot
%     saveas(gcf,[path filename '.png']);
%     fprintf('saved as %s\n', [path filename '.png']);
    
    pause();
end



%% plot mesh
% vtkFile='C:\CFD_second_HHD\racewayOpenfoam\01192019\10\racewayWall.vtk';
% Plot_VTK_mesh(vtkFile);
% hold on;
% scatter3(highConcenCell(:,2),highConcenCell(:,3),highConcenCell(:,4),100,'filled');
% xlabel('x');
% ylabel('y');
% zlabel('z');

