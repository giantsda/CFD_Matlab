path='C:\CFD_second_HHD\racewayOpenfoam\04192019\24\data\';
filesTotal=dir([path 'export*']);
y_mesh=56-[5 10 15 20 25 30 35 40 45 48];  %% 56 and 155
y_mesh=y_mesh/100;
z_mesh=[0.05 0.10 0.15];

% y_mesh=linspace(-56,56,50);
% y_mesh=y_mesh/100;
% z_mesh=linspace(0,0.2,50);

[y1,z1]=meshgrid(y_mesh,z_mesh);
value_s=y1*0;

files=[];  % too much data, read every 15
for i=1:10:length(filesTotal)
    files=[files filesTotal(i)];
end

parfor_progress(length(files)); % Set the total number of files
parfor i=1:length(files)
    file=[path files(i).name]
    delimiterIn = ','; %read txt file
    headerlinesIn=1;
    dataI = importdata(file,delimiterIn,headerlinesIn);
    dataI=dataI.data;
    % cellnumber, x-coordinate,y-coordinate, z-coordinate,x-velocity,y-velocity, z-velocity, w-vof
    sliceI=dataI(find(abs(dataI(:,2)-0.85)<=1e-5),:);
    value_i=griddata(sliceI(:,3),sliceI(:,4),abs(sliceI(:,5)),y1,z1);
    value_s=value_s+value_i;
    parfor_progress;
%% test plot
%     pcolor(y1,z1,value_i);
%     shading interp;
%     axis equal
%     colormap jet
%     colorbar
%     pause();
end
parfor_progress(0);

meanVelocity=value_s/length(files);
figure;
pcolor(y1,z1,meanVelocity)
shading interp;
axis equal
colormap jet
colorbar




