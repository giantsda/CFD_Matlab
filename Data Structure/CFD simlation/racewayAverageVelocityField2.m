path='/home/chen/Desktop/project/20/';
files=dir([path 'export*']);
z_mesh=56-[5 10 15 20 25 30 35 40 45 48];
z_mesh=z_mesh/100;
y_mesh=[0.05 0.10 0.15];

z_mesh=56-linspace(0,56,50);
z_mesh=z_mesh/100;
y_mesh=linspace(0,0.2,50);

[z1,y1]=meshgrid(z_mesh,y_mesh);

value_s=z1*0;
parfor_progress(length(files)); % Set the total number of files
parfor i=1:length(files)
    file=[path files(i).name]
    delimiterIn = ','; %read txt file
    headerlinesIn=1;
    dataI = importdata(file,delimiterIn,headerlinesIn);
    dataI=dataI.data;
    % cellnumber, x-coordinate,y-coordinate, z-coordinate,x-velocity,y-velocity, z-velocity, w-vof
    sliceI=dataI(find(abs(dataI(:,2)--0.85)<=1e-5),:);
    value_i=griddata(sliceI(:,4),sliceI(:,3),abs(sliceI(:,5)),z1,y1);
    value_s=value_s+value_i;
    parfor_progress;
end
parfor_progress(0);


pcolor(z1,y1,value_s/length(files))
shading interp;
axis equal
colormap jet
colorbar




