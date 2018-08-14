%% this function require the desired particle number, 
%the spatial limit position. generate the frame, ainj file to initial Fluent DPM.
%read the dpm file in order to use the first 2 lines
%% define the particle number, spatial limits
particle_number=3000; % define the particle number
x_up=0.08e-3;  %define spatial position in meter
x_low=0e-3;
y_up=-0.0624e-3;
y_low=-0.086e-3;
%% for the given vertex position, plot the frame of a cubic;
% p1=[x_up y_low z_low];
% p2=[x_up y_up z_low];
% p3=[x_low y_up z_low];
% p4=[x_low y_low z_low];
% p5=[x_up y_low z_up];
% p6=[x_up y_up z_up];
% p7=[x_low y_up z_up];
% p8=[x_low y_low z_up];
% x=[p1(1) p2(1) p1(1) p1(1) p5(1) p3(1);
%       p2(1) p3(1) p2(1) p4(1) p6(1) p7(1);
%       p3(1) p7(1) p6(1) p8(1) p7(1) p8(1);
%       p4(1) p6(1) p5(1) p5(1) p8(1) p4(1)];
% y=[p1(2) p2(2) p1(2) p1(2) p5(2) p3(2);
%       p2(2) p3(2) p2(2) p4(2) p6(2) p7(2);
%       p3(2) p7(2) p6(2) p8(2) p7(2) p8(2);
%       p4(2) p6(2) p5(2) p5(2) p8(2) p4(2)];
% z=[p1(3) p2(3) p1(3) p1(3) p5(3) p3(3);
%       p2(3) p3(3) p2(3) p4(3) p6(3) p7(3);
%       p3(3) p7(3) p6(3) p8(3) p7(3) p8(3);
%       p4(3) p6(3) p5(3) p5(3) p8(3) p4(3)];
% fill3(x,y,z, 'b','facealpha',0.1)
% hold on;
%% calculate the node position
xlengh=x_up-x_low;
ylengh=y_up-y_low;
elememt_len=(xlengh*ylengh/particle_number)^(1/2 );
elen_x=xlengh/elememt_len;
elen_y=ylengh/elememt_len;
elen_x=ceil(elen_x); % get element nember to generate the location of desired number particles
elen_y=ceil(elen_y);
% i denotes x  j denotes y  k denotes z
% generate node postion
for i=1:elen_x+1   
nodepos_x(i)=xlengh/elen_x*(i-1)+x_low;
end
for i=1:elen_y+1
nodepos_y(i)=ylengh/elen_y*(i-1)+y_low;
end
%% generate element position
d=1;
ele_location=zeros(2,elen_x*elen_y);
    for j=1:  elen_y    
        for i=1:elen_x         
            cell_x=(nodepos_x(i)+nodepos_x(i+1))/2;
            cell_y=(nodepos_y(j)+nodepos_y(j+1))/2;            
            ele_location(1,d)=cell_x;
            ele_location(2,d)=cell_y;
            ele_location(3,d)=0;
            d=d+1;
        end
    end
%% 
% plot(ele_location(1,:),ele_location(2,:),'b.','MarkerSize',7);
% axis equal
% xlim([x_low  x_up])
% ylim([y_low  y_up])
% xlabel('x')
% ylabel('y')
% title(['initial # is  ' num2str(elen_x*elen_y)])  
% hold off;
%% read .dpm file to use the first two lines
filename1='sample.dpm';
data = importdata(filename1);
% com=data;
siz=size(data);
siz=siz(1);
for i=3:1:siz
data{i}(1)=[];
data{i}(1)=[];
    for j=1:1:16
        data{i}(155)=[];
    end  
data{i}=str2num(data{i});    
end
%% generate writeinfo
numberpart=zeros(elen_x*elen_y+2,12);
% d=2e-6; %8e-5;
% mass=4/3*pi*(d/2)^3*1000; % calculate the mass
% numberpart(:,7)=2e-6 ;%8e-5;  %define the diameter
numberpart(:,8)=300; %define Temperature
numberpart(:,9)=2.1368e-23; %define mass-flow
% numberpart(:,10)=mass;%4.189e-15;%2.68e-10; %define the mass
numberpart(:,11)=7.9705e-14; % define  frequency
%% diameter distribution
a=normrnd(2,0.1,1000000,1);
%%
for i=1:elen_x*elen_y %assign xyz postion to numberpart
numberpart(i+2,1:3)=ele_location(:,i);  
d=a(randi([1 1000000]))*1e-6;
mass=4/3*pi*(d/2)^3*1000;
numberpart(i+2,7)=d;
numberpart(i+2,10)=mass;
writeinfo{i+2,1}=num2str(numberpart(i+2,:));
writeinfo{i+2,1}=['(( ' writeinfo{i+2,1} ') )'];
end
writeinfo{1}=data{1};
writeinfo{2}=data{2}; 
filename1=num2str(elen_x*elen_y);
%% generate .inj file
fid=fopen(['E:\desktop\temp\' filename1 '_Lei.inj'],'wt');
report=['generating E:\desktop\temp\' filename1 '.inj....']
for i=1:elen_x*elen_y+2
writ=writeinfo{i};
fprintf(fid,'%s\n',writ);
end
fclose(fid);
