folder_path='E:\desktop\temp\' ;
name='water';
N=400;
x_mesh=linspace(-1.6,1.6,N);
y_mesh=linspace(-0.6,0.6,N);
data=[];
filename1= [folder_path name ] ;
disp(filename1);
delimiterIn = ','; %read txt file
headerlinesIn=1;
data_m = importdata(filename1,delimiterIn,headerlinesIn);
data=data_m.data;
data=sortrows(data,5);
for i=1:length(data)
    if data(i,5)>0.4
        break;
    end
end
data(1:i,:)=[];
for i=1:length(data)
    if data(i,5)>0.6
        break;
    end
end
data(i:end,:)=[];
x=data(:,2);
y=data(:,4);
z=data(:,3);
[x1,y1]=meshgrid(x_mesh,y_mesh);
z1=griddata(x,y,z,x1,y1);
% zuoyou=find(x1(1,:)>=-0.3168 & x1(1,:)<=0.3168);
% zuo=zuoyou(1);
% you=zuoyou(end);
% zuoyou=find(x1(1,:)>=-0.3168 & x1(1,:)<=0.3168);
% shangxia=find(y1(:,1)>=-0.02255 & y1(:,1)<=0.02255);
% shang=shangxia(1);
% xia=shangxia(end);
figure;
set(gcf,'outerposition',get(0,'screensize'));
load( 'empty')
z1(empty)=nan;
surf(x1,y1,z1);
shading interp;
axis equal
colormap jet
colorbar
view(180,-90)
% Vq = interp2(x1,y1,z1,0,0.3)
 
 