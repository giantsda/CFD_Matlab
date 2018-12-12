% c = parcluster
% parpool(c)
folder_path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\06252017\40\data\' ;
files = dir([folder_path 'y*']);
N=400;
value_s=zeros(N,N);
x_mesh=linspace(-1.6,1.6,N);
y_mesh=linspace(-0.6,0.6,N);
z_mesh=linspace(0.03,0.17,5);
[x1,y1,z1]=meshgrid(x_mesh,y_mesh,z_mesh);
parfor i=1:3%length(files)
    file_name=files(i).name;
    data=[];
    filename1= [folder_path file_name ] ;
    disp(filename1);
    delimiterIn = ','; %read txt file
    headerlinesIn=1;
    data_m = importdata(filename1,delimiterIn,headerlinesIn);
    data=data_m.data;
    data=sortrows(data,3);
    for j=1:length(data)
        if data(j,3)>0.18
            break;
        end
    end
    data(j:end,:)=[];
    x=data(:,2);
    y=data(:,4);
    z=data(:,3);
    value=data(:,5);
    value_i=griddata(x,y,z,value,x1,y1,z1);
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
pcolor(x_mesh,y_mesh,value_s);
shading interp;
axis equal
colormap jet
colorbar
view(180,-90)