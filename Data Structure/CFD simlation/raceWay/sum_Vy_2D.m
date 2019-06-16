 % c = parcluster
% parpool(c)
folder_path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\06252017\41\data\' ;
files = dir([folder_path '40*']);
N=400;
value_s=zeros(N,N);
x_mesh=linspace(-1.6,1.6,N);
y_mesh=linspace(-0.6,0.6,N);
[x1,y1]=meshgrid(x_mesh,y_mesh);
parfor i=1:5%length(files)
    file_name=files(i).name;
    data=[];
    filename1= [folder_path file_name ] ;
    disp(filename1);
    delimiterIn = ','; %read txt file
    headerlinesIn=1;
    data_m = importdata(filename1,delimiterIn,headerlinesIn);
    data=data_m.data;
    data=sortrows(data,3);
    x=data(:,2);
    y=data(:,4);
    value=data(:,5);
    value_i=griddata(x,y,value,x1,y1);
    value_i=abs(value_i);
    value_i=sum(value_i,3);
    filename=[folder_path 'save' num2str(i) '.mat']
    parsave(filename, value_i);
    value_s=value_s+value_i;
end
figure;
set(gcf,'outerposition',get(0,'screensize'));
load( 'empty')
value_s(bian)=nan;
pcolor(x1,y1,value_s);
shading interp;
axis equal
colormap jet
colorbar
view(180,-90)