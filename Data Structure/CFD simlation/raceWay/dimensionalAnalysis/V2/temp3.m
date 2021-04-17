% %The length of the straight channel does not significantly change the critical velocity,
% %thus the critical vertical velocity is redefined as the 20 percent of the vertical velocity
% %in the box that is defined as a rectangle of radius and 2*radius.
% clear all;
% MainPath='D:\CFD_second_HHD\02212020\130';
% cd (MainPath);
% inspectLocationRaduis=0.05;
% UcriticalPercentage=0.15;
% 
% % MeanmagU=[];
% % MeanUx=[];
% cd (MainPath);
% cd (num2str(12))
% load('Data.mat');
% Data12=Data;
% 
% cd (MainPath);
% cd (num2str(13))
% load('Data.mat');
% Data13=Data;
%  
% Data={};
% cd (MainPath);
% cd (num2str(14))
% load('Data.mat');
% Data14=Data;
 
  
% close all;
% CS=find(Data12.mesh(:,3)>0.09 & Data12.mesh(:,3)<0.092);
% U=sqrt(Data12.U{end}(CS,1).^2+Data12.U{end}(CS,2).^2+Data12.U{end}(CS,3).^2);
% scatter3(Data12.mesh(CS,1),Data12.mesh(CS,2),Data12.mesh(CS,3),8,U,'filled')
% axis equal;
% colormap(jet);
% colorbar;
% view(0,90)
% caxis([0  0.55])
% 
% 
% figure;
% CS=find(Data13.mesh(:,3)>0.09 & Data13.mesh(:,3)<0.092);
% U=sqrt(Data13.U{end}(CS,1).^2+Data13.U{end}(CS,2).^2+Data13.U{end}(CS,3).^2);
% scatter3(Data13.mesh(CS,1),Data13.mesh(CS,2),Data13.mesh(CS,3),8,U,'filled')
% axis equal;
% colormap(jet);
% colorbar;
% view(0,90)
% caxis([0  0.55])
% 
% 
% figure;
% CS=find(Data14.mesh(:,3)>0.09 & Data14.mesh(:,3)<0.092);
% U=sqrt(Data14.U{end}(CS,1).^2+Data14.U{end}(CS,2).^2+Data14.U{end}(CS,3).^2);
% scatter3(Data14.mesh(CS,1),Data14.mesh(CS,2),Data14.mesh(CS,3),8,U,'filled')
% axis equal;
% colormap(jet);
% colorbar;
% view(0,90)
% caxis([0  0.55])
% 