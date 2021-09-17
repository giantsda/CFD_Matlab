% the criticalU4 is define as the critical vertical velocity so that the
% critical length is 4*R

oPath=pwd();
MainPath='D:\CFD_second_HHD\02212020\130\Data';
cd (MainPath);

criticalU3=[];
for i=[119:134 143:174]
    caseN=i
    Data={};
    cd (MainPath);
    load(['Data_' num2str(caseN) '.mat']);
    fprintf("Done with reading data.\n");
    
    %% determin critical distance between mesh points
    [A, index] = sortrows(Data.mesh(:,1:2),[1 2]); % removing overlapping points
    B=A(1,:);
    for i=2:length(A)
        if  A(i,1)-A(i-1,1)<=0.001&&A(i,2)-A(i-1,2)<=0.001
            
        else
            B=[B;A(i,:)];
        end
    end
    
    B=sortrows(B,[1 2]);
    C=B(1:200,:);% exaime a the first 100 poins.since they are sorted, they are at close region.
    D=[];
    E=[];
    for i=1:200
        for j=1:200
            D(j)=norm(B(i,1:2)-B(j,1:2));
        end
        D(find(D==0))=[];
        E(i)=min(D);
    end
    meanMeshDistance=mean(E);
    critcal=meanMeshDistance*1.5;
    
    criticalDistance = bisection2(@getcriticalLength,0,0.5,0.00025,Data,critcal);
    
    criticalU3(caseN)=criticalDistance
    saveas(gcf,['D:\CFD_second_HHD\02212020\130\Data\CriticalU3_' num2str(caseN) '.png'])
end
 
cd(oPath);

load handel.mat;
soundsc(y, 2*Fs);

% clearvars -except UcriticalStore MainPath
% save([MainPath '/UcriticalStore.mat'], '-v7.3');
% disp('store UcriticalStore to MainPath.............. \n');





function difference=getcriticalLength(Ucritical,Data,critcal)

radius=(max(Data.mesh(:,2))-min(Data.mesh(:,2)));
leftPoint=min(Data.mesh(:,1));
%% get Data.count

Data.count=zeros(length(Data.vof),1);
for c=1:length(Data.U)
    Data.count(abs(Data.U{c}(:,3))>Ucritical)=1;
end

if size(Data.mesh,2)==3
    Data.mesh(:,3)=[]; % project to XY plane
end

i=find(Data.count==1);
Data.mesh(:,3)=Data.count;

[A, index] = sortrows(Data.mesh(i,:),[1 2]); % removing overlapping points
if (size(A,1)<10)
    difference=4;
    fprintf("Tried %0.8f and got %0.8f\n",Ucritical,difference);
    return;
end
B=A(1,:);
for i=2:length(A)
    if  A(i,1)-A(i-1,1)<=0.001&&A(i,2)-A(i-1,2)<=0.001
        B(end,3)=B(end,3)+A(i,3);
    else
        B=[B;A(i,:)];
    end
end
%% calculate critical length

xmin=min(Data.mesh(:,1));
xmax=max(Data.mesh(:,1));
ymin=min(Data.mesh(:,2));
ymax=max(Data.mesh(:,2));
yresolution=50;
yMesh=linspace(ymin,ymax,yresolution);
dy=(ymax-ymin)/yresolution;
xMesh= xmin:dy:xmax;

%% convert scatter plot to grid plot
D=[];
originX=leftPoint+radius;
E=[];
for i=1:length(xMesh)
    %     i/length(xMesh)*100
    xx=xMesh(i);
    for j=1:length(yMesh)
        yy=yMesh(j);
        C=abs(B(:,1:2)-[xx yy]);
        C(:,3)=sqrt(C(:,1).^2+C(:,2).^2);
        minDistance=min(C(:,3));
        if minDistance<=critcal
            D(i,j)=255;
            E(i,j)=255;
        end
        if ((xx-originX)^2+yy^2>=radius^2 && xx<=originX)
            E(i,j)=100;
            E(length(xMesh)-i+1,j)=100;
        end
    end
end

[Boun,L,N] = bwboundaries(D);
stats=  regionprops(L, 'Centroid', 'Area', 'Perimeter');
Area = cat(1,stats.Area);
Centroid = cat(1, stats.Centroid);
Perimeter = cat(1,stats.Perimeter);
[~, n]=max(Area);

imshow(rot90(1-E),[]);
axis equal;
hold on;
Boun=[Boun{n}(:,1), size(D,2)-Boun{n}(:,2)+1];
plot(Boun(:,1),Boun(:,2), 'r', 'LineWidth', 1)

A=zeros(size(rot90(1-E)));
[row,col] =find(A==0);
in=inpolygon(col,row,Boun(:,1),Boun(:,2)); % determine if points in boundry
A=rot90(1-E);
A(A~=-254)=0;
A(A==-254)=-1;
A((in==0))=0; % remove points not in boundry
 
r=size(A,1);
percentageS=zeros(1,size(A,2));
for i=r:size(A,2)
    percentage=length(find(A(:,i)==-1))/r;
    percentageS(i)=percentage;
%     if percentage<0.4
%         break;
%     end 
end
above=find(percentageS>=0.4);
if isempty(above)
    i=1;
else
    i=above(end);
end
 
plot([0; i] ,[floor(r/2); floor(r/2)],'b','LineWidth',2);
plot([5*r;5*r],[0;r],'b','LineWidth',2);
criticalDistance=(xMesh(i)-min(Data.mesh(:,1)))/radius;
hold off;
title(['criticalDistance=' num2str(criticalDistance,'%10.2f') '*Radius']);
difference=(3-criticalDistance);

saveas(gcf,['C:\Users\chenshen.ETS01297\Desktop\temp\k\k\case18_' num2str(Ucritical) '.png'])

fprintf("Tried %0.8f and got %0.8f\n",Ucritical,difference);
end


function p = bisection(f,a,b,tol,varargin)
% provide the equation you want to solve with R.H.S = 0 form.
% Write the L.H.S by using inline function
% Give initial guesses.
% Solves it by method of bisection.
% A very simple code. But may come handy
if f(a,varargin{1},varargin{2})*f(b,varargin{1},varargin{2})>0
    disp('Wrong choice bro')
else
    p = (a + b)/2;
    err = abs(a-b);
    while err > tol
        if f(a,varargin{1},varargin{2})*f(p,varargin{1},varargin{2})<0
            b = p;
        else
            a = p;
        end
        p = (a + b)/2;
        err = abs(a-b);
    end
end
end

function p = bisection2(f,a,b,tol,varargin)
p = (a + b)/2;
fa=f(a,varargin{1},varargin{2});
fb=f(b,varargin{1},varargin{2});
fp=f(p,varargin{1},varargin{2});
if fa*fb>0
    disp('Wrong choice bro')
end
err = abs(a-b);
while err > tol
    if fa*fp<0
        b = p;
    else
        a = p;
        fa=fp;
    end
    p = (a + b)/2;
    fp=f(p,varargin{1},varargin{2});
    err = abs(a-b);
end

end
