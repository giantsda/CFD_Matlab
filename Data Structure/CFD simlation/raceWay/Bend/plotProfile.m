%  load('C:\CFD_second_HHD\racewayOpenfoam\05102019\65\profiles\profile');

%%%% cellnumber,    x-coordinate,    y-coordinate,    z-coordinate,        pressure,velocity-magnitude,      x-velocity,      y-velocity,      z-velocity,           w-vof
close all;
figure;
set(gcf,'outerposition',get(0,'screensize'));
surfaceIndexPair(:,1)=find(profile{1}(:,1)==1);
for i=1:length(surfaceIndexPair)-1
    surfaceIndexPair(i,2)=surfaceIndexPair(i+1,1)-1;
end
surfaceIndexPair(end,2)=length(profile{1});
%
surface=2;
valueS=[];
dataI=profile{1};
deadZoneindex=zeros(dataI(surfaceIndexPair(surface,2)-surfaceIndexPair(surface,1),1)+1,1);
imagepath='E:\desktop\temp\2\';
%
xlimit=double([ min(profile{1}(surfaceIndexPair(surface,1):surfaceIndexPair(surface,2),2))    max(profile{1}(surfaceIndexPair(surface,1):surfaceIndexPair(surface,2),2))]);
ylimit=double([min(profile{1}(:,4)),max(profile{1}(:,4))]);
N=200;
[x1,y1]=meshgrid(linspace(xlimit(1),xlimit(2),N),linspace(ylimit(1),ylimit(2),N));
%
parfor_progress(200); % Set the total number of iterations
for i=1:200
    dataI=double(profile{i});
    xp=dataI(surfaceIndexPair(surface,1):surfaceIndexPair(surface,2),2);
    yp=dataI(surfaceIndexPair(surface,1):surfaceIndexPair(surface,2),3);
    zp=dataI(surfaceIndexPair(surface,1):surfaceIndexPair(surface,2),4);
    pressure=dataI(surfaceIndexPair(surface,1):surfaceIndexPair(surface,2),5);
    vMag=dataI(surfaceIndexPair(surface,1):surfaceIndexPair(surface,2),6);
    vX=dataI(surfaceIndexPair(surface,1):surfaceIndexPair(surface,2),7);
    vY=dataI(surfaceIndexPair(surface,1):surfaceIndexPair(surface,2),8);
    vZ=dataI(surfaceIndexPair(surface,1):surfaceIndexPair(surface,2),9);
    water=dataI(surfaceIndexPair(surface,1):surfaceIndexPair(surface,2),10);
    
    %     x1=linspace(-0.5,2,1000);
    %     y1=ones(1,1000)*-0.1;
    %     valueI=griddata(xp,yp,vMag,x1,y1); %% 2D interpolation
    %     valueS(:,i)=valueI;
    %     plot(x1,valueI);
    %     ylim([0 1])
    
    value_i=griddata(xp,zp,vMag,x1,y1);
    pcolor(x1,y1, fliplr(value_i));
    
    %     scatter(xp,zp,40,(vZ),'filled');
    shading interp;
    axis equal
    colormap jet
    colorbar
%     caxis([-0.5 0.5])
    title(num2str(timeTag(i,2)));
    
%     saveas(gcf,[imagepath num2str(i,'%0.5d') '.png'])
    deadZone(:,i)=vMag<0.1;
    parfor_progress;
    pause(0);
end

parfor_progress(0);



%%%%%%%%%%%
% haha=sum(deadZone,2);
% haha2=find(haha>length(profile)/2)
% scatter(xp,yp,40,haha,'filled');
% color bar;
%  hold on;
%  scatter(xp(haha2),yp(haha2),40,[0 0 0],'filled');

% plot(timeTag(:,2), valueS(73,:));

% for i=1:length(valueS)
%     t = timeTag(:,2);
%     x =valueS(i,:);
%     xdft = fft(x);
%     xdft(1)=0;
%     plot(abs(xdft));
%     xlim([])
%     pause(0);
% end