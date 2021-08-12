%The length of the straight channel does not significantly change the critical velocity,
%thus the critical vertical velocity is redefined as the 20 percent of the vertical velocity
%in the box that is defined as a rectangle of radius and 2*radius.
figure;
set(gcf,'outerposition',get(0,'screensize'));

MainPath='D:\CFD_second_HHD\02212020\130\Data';
cd (MainPath);
results={};

for i=9:16
    caseN=i
    Data={};
    cd (MainPath);
 
    load(['Data_' num2str(caseN) '.mat']);
    radius=(max(Data.mesh(:,2))-min(Data.mesh(:,2)));
    leftPoint=min(Data.mesh(:,1));
    fprintf("Done with reading data.\n");
    %% calculate critical length
    xmin=min(Data.mesh(:,1));
    xmax=max(Data.mesh(:,1));
    ymin=min(Data.mesh(:,2));
    ymax=max(Data.mesh(:,2));
 
    Ucritical=UcriticalStore{caseN}.percent3;
    
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
    yresolution=50;
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
        i/length(xMesh)*100
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
    
    imshow(rot90(1-E),[]);
    axis equal;
    hold on;
    criticalDistance=(xMesh(max(Boun{n,1}(:,1)))-min(Data.mesh(:,1)))/radius;
    plot(Boun{n}(:,1), size(D,2)-Boun{n}(:,2)+1, 'r', 'LineWidth', 1)
    hold off;
    title(['criticalDistance=' num2str(criticalDistance) '*Radius']);
    saveas(gcf,['C:\Users\chenshen.ETS01297\Desktop\temp\k\15S' num2str(caseN) '.png'])
    critical(caseN)=criticalDistance;
end
 