% c = parcluster
% parpool(c)
folder_path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\06252017\42\data\' ;
files = dir([folder_path 'y*']);
N=400;
value_s=zeros(N,N);
x_mesh=linspace(-1.6,1.6,N);
y_mesh=linspace(-0.6,0.6,N);
lim=[0.03 0.06 0.09 0.12 0.15 0.18];
value_s=zeros(N,N);
[x1,y1]=meshgrid(x_mesh,y_mesh);
fprintf('total %d files detected \n', length(files))
parfor i=1:length(files)
    file_name=files(i).name;
    data=[];
    filename1= [folder_path file_name ] ;
    disp(filename1);
    delimiterIn = ','; %read txt file
    headerlinesIn=1;
    data_m = importdata(filename1,delimiterIn,headerlinesIn);
    data=data_m.data;
    data=sortrows(data,3);
    num=[];
    for j=1:length(lim)
        for k=1:length(data);
            if (j==5 && k==280880)
                j
            end
            if data(k,3)>=lim(j)*1.1
                break
            end
        end
        num(j)=k;
    end
    num=[1 num];
  
    value_m=zeros(N,N);
    for  j=1:length(lim)
        data_m=data(num(j):num(j+1)-1,:);
        x=data_m(:,2);
        y=data_m(:,4);
        value=data_m(:,5);       
        value_i=griddata(x,y,value,x1,y1);
        value_i=abs(value_i);
        value_i=sum(value_i,3);
        value_m=value_m+value_i;
    end
    filename=[folder_path 'save' num2str(i) '.mat'];
    parsave(filename, value_m);
    value_s=value_s+value_m;
end

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
value_s(empty)=nan;
pcolor(x1,y1,value_s);
shading interp;
axis equal
colormap jet
colorbar
view(180,-90)