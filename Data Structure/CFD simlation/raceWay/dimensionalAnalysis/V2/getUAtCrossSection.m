% the criticalU4 is define as the critical vertical velocity so that the
% critical length is 4*R
close all;

MainPath='D:\CFD_second_HHD\02212020\130\Data';
cd (MainPath);
figure;
set(gcf, 'Position', get(0, 'Screensize'));
criticalU4=[];
Upoint=[];
for i=[1:56]
    caseN=i
    Data={};
    cd (MainPath);
    load(['Data_' num2str(caseN) '.mat']);
    fprintf("Done with reading data.\n");
    radius=(max(Data.mesh(:,2))-min(Data.mesh(:,2)));
    leftPoint=min(Data.mesh(:,1));
    crossSectionX=double(leftPoint+radius);
    crossSectionIndex=find(Data.mesh(:,1)>=crossSectionX-0.01 &Data.mesh(:,1)<=crossSectionX+0.01)
    mesh=double(Data.mesh(crossSectionIndex,:));
    
    y=linspace(0,max(mesh(:,3)),35);
    dy=y(2);
    x=0:dy:max(mesh(:,2));
    [xq,yq] = meshgrid(x,y);
    Us=zeros(size(xq));
    for i=1:length(Data.U)
        i
        magU=double(sqrt(Data.U{i}(crossSectionIndex,1).^2+Data.U{i}(crossSectionIndex,2).^2+Data.U{i}(crossSectionIndex,3).^2));
        Us=Us+griddata(mesh(:,1),mesh(:,2),mesh(:,3),magU,crossSectionX*ones(size(xq)),xq,yq);
    end
    Us=Us/length(Data.U);
    pcolor(x,y,Us)
    shading interp;
    axis equal
    colormap parula
    colorbar;
    Us = Us(:);
    Us(isnan(Us)) = [];
    Us=sort(Us);
    
%     Upoint(caseN)=Us(3,floor(size(Us,2)/2));
    
    Upoint(caseN)=Us(floor(length(Us)*(1-0.005)));
    saveas(gcf,['C:\Users\chenshen.ETS01297\Desktop\temp\k\CrossSectionAtR_' num2str(caseN) '.png'])
end


