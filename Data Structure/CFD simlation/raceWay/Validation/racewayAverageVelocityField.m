N=400;
x_mesh=linspace(-1.6,1.6,N);
y_mesh=linspace(-0.6,0.6,N);
[x1,y1]=meshgrid(x_mesh,y_mesh);
xValue_s=zeros(N,N);
yValue_s=zeros(N,N);
zValue_s=zeros(N,N);

path='C:\CFD_second_HHD\racewayOpenfoam\04152019\19\data\';
files=dir([path '*']);
files(1:2)=[]; %% remove . and ..
for j=1:length(files)
    try
        fileNameTime(j,1)=sscanf(files(j).name,'%f');
    end
end
[fileNameTime,index]=sort(fileNameTime);
files=files(index);

%% readFiles

parfor_progress(length(files)); % Set the total number of files
parfor i=1:length(files)
filename= [path files(i).name] ;
disp(filename);
delimiterIn = ','; %read txt file
headerlinesIn=1;
data_m = importdata(filename,delimiterIn,headerlinesIn);
data_m=data_m.data;
dx=0.0005;
sliceIndex=find(data_m(:,3)<=0.025+dx&data_m(:,3)>=0.025-dx) ;
dataI=data_m(sliceIndex,:);
x=dataI(:,2);
y=dataI(:,4);
xVelocity=dataI(:,7);
yVelocity=dataI(:,6);
zVelocity=dataI(:,5);
value_i=griddata(x,y,xVelocity,x1,y1);
xValue_s=xValue_s+value_i;
value_i=griddata(x,y,yVelocity,x1,y1);
yValue_s=yValue_s+value_i;
value_i=griddata(x,y,zVelocity,x1,y1);
zValue_s=zValue_s+value_i;
parfor_progress;
end
parfor_progress(0);
%% plot
pcolor(x1,y1,abs(xValue_s)/length(files));
i
shading interp;
axis equal
colormap jet
colorbar
 
 
 

