%The length of the straight channel does not significantly change the critical velocity,
%thus the critical vertical velocity is redefined as the 20 percent of the vertical velocity
%in the box that is defined as a rectangle of radius and 2*radius.UcriticalStore{1, 48}.percent6
% find low critical velocity by percentage
MainPath='D:\CFD_second_HHD\02212020\130';
cd (MainPath);
lowCriticalVelocityS=[];
UcriticalStore{2}.percent3=0.08;
f = waitbar(0,'Please wait...');
for i=48:48
    fprintf('case=%d \n',i);
    caseN=i
    Data={};
    cd (MainPath);
    cd (num2str(i));
    load('Data.mat');
    Data.f=f;
    
    
    for n=1:length(Data.U)
        Data.U{n}=Data.U{n}(:,3);
    end
    
    Ucritical=UcriticalStore{caseN}.percent3;
    
    tol=1e-2;
    Solution = bisection2(@getdifference,0,Ucritical,tol,Data)
    lowCriticalVelocityS(caseN)=Solution;
    
    
end

function difference=getdifference(Ucritical,Data)
fprintf('exime Ucritical=%f  ',Ucritical);
%% calculate critical length
radius=(max(Data.mesh(:,2))-min(Data.mesh(:,2)));
leftPoint=min(Data.mesh(:,1));
totalLength=max(Data.mesh(:,1))-min(Data.mesh(:,1));

if Ucritical==0
    difference=1;
    fprintf('difference=%d  \n',difference);
    return;
end

Data.count=zeros(length(Data.vof),1);
for c=1:length(Data.U)
    Data.count(abs(Data.U{c})>Ucritical)=1;
end

if size(Data.mesh,2)==3
    Data.mesh(:,3)=[]; % project to XY plane
end

i=find(Data.count==1);
Data.mesh(:,3)=Data.count;
[A, index] = sortrows(Data.mesh(i,:),[1 2]); % removing overlapping points
B=A(1,:);
for i=2:length(A)
    if  A(i,1)-A(i-1,1)<=0.001&&A(i,2)-A(i-1,2)<=0.001
        B(end,3)=B(end,3)+A(i,3);
    else
        B=[B;A(i,:)];
    end
end

xmin=min(Data.mesh(:,1));
xmax=max(Data.mesh(:,1));
ymin=min(Data.mesh(:,2));
ymax=max(Data.mesh(:,2));
yresolution=20;
yMesh=linspace(ymin,ymax,yresolution);
dy=(ymax-ymin)/yresolution;
xMesh= xmin:dy:xmax;
[x,y]=meshgrid(xMesh,yMesh);


%% determin  critical distance
C=B(1:100,:);% exaime a the first 100 poins.since they are sorted, they are at close region.
D=[];
E=[];
for i=1:100
    for j=1:100
        D(j)=norm(B(i,1:2)-B(j,1:2));
    end
    D(find(D==0))=[];
    E(i)=min(D);
end
meanMeshDistance=mean(E);
critcal=meanMeshDistance*1.5;
%% convert scatter plot to grid plot
D=[];
originX=leftPoint+radius;
E=[];

for i=1:length(xMesh)
    waitbar(i/length(xMesh),Data.f,'calculating');
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


%     radius=(max(Data.mesh(:,2))-min(Data.mesh(:,2)))/2;
%     leftPoint=min(Data.mesh(:,1));

[Boun,L,N] = bwboundaries(D);
stats=  regionprops(L, 'Centroid', 'Area', 'Perimeter');
Area = cat(1,stats.Area);
Centroid = cat(1, stats.Centroid);
Perimeter = cat(1,stats.Perimeter);
[~, n]=max(Area);

imshow(rot90(1-D),[]);
axis equal;
hold on;
criticalDistance=(xMesh(max(Boun{n,1}(:,1)))-min(Data.mesh(:,1)));
plot(Boun{n}(:,1), size(D,2)-Boun{n}(:,2)+1, 'r', 'LineWidth', 1)
hold off;
title(['criticalDistance=' num2str(criticalDistance)  ]);

percentage=length(find(E==255))/(size(E,1)*size(E,2)-length(find(E==100)));
difference=percentage-0.80;
% pause();
% if criticalDistance>totalLength*0.95
%     difference=1;
% else
%     difference=-1;
% end
fprintf('difference=%0.2f %%  \n',difference*100);
% fprintf("Tried %0.8f and got %0.8f\n",Ucritical,Percentage);
end


function p = bisection(f,a,b,tol,varargin)
% provide the equation you want to solve with R.H.S = 0 form.
% Write the L.H.S by using inline function
% Give initial guesses.
% Solves it by method of bisection.
% A very simple code. But may come handy
if f(a,varargin{1})*f(b,varargin{1})>0
    disp('Wrong choice bro')
else
    p = (a + b)/2;
    err = abs(a-b);
    while err > tol
        if f(a,varargin{1})*f(p,varargin{1})<0
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
fa=f(a,varargin{1});
fp=f(p,varargin{1});
err = abs(a-b);
while err > tol
    if fa*fp<0
        b = p;
    else
        a = p;
        fa=fp;
    end
    p = (a + b)/2;
    fp=f(p,varargin{1});
    err = abs(a-b);
end

end