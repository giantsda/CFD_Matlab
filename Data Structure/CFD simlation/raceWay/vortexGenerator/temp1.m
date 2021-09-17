% the criticalU4 is define as the critical vertical velocity so that the
% critical length is 4*R

MainPath='D:\CFD_second_HHD\06232021\204\Data';
opath=pwd();
cd (MainPath);
criticalU4=[];

for i=[214]
    ii=1;
    caseN=i
    Data={};
    cd (MainPath);
    load(['Data_' num2str(caseN) '.mat']);
    fprintf("Done with reading data.\n");
    
    %% determin critical distance between mesh points
    %     [A, index] = sortrows(Data.mesh(:,1:2),[1 2]); % removing overlapping points
    %     B=A(1,:);
    %     for i=2:length(A)
    %         if  A(i,1)-A(i-1,1)<=0.001&&A(i,2)-A(i-1,2)<=0.001
    %
    %         else
    %             B=[B;A(i,:)];
    %         end
    %     end
    %
    %     B=sortrows(B,[1 2]);
    %     C=B(1:200,:);% exaime a the first 100 poins.since they are sorted, they are at close region.
    %     D=[];
    %     E=[];
    %     for i=1:200
    %         for j=1:200
    %             D(j)=norm(B(i,1:2)-B(j,1:2));
    %         end
    %         D(find(D==0))=[];
    %         E(i)=min(D);
    %     end
    %     meanMeshDistance=mean(E);
    %     critcal=meanMeshDistance*1.5;
    
    critcal=0.01074674;
    radius=(max(Data.mesh(:,2))-min(Data.mesh(:,2)));
    leftPoint=min(Data.mesh(:,1));
    %% get Data.count
    if ismember(caseN,[214])
        %         UcriticalS= 0.18:-0.02:0.10;
        UcriticalS= [0.12 0.16 0.18];
    else
        UcriticalS= 0.15;
    end
    
    for Ucritical= UcriticalS
        cd (MainPath);
        Ucritical
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
        yresolution=100;
        yMesh=linspace(ymin,ymax,yresolution);
        dy=(ymax-ymin)/yresolution;
        xMesh= xmin:dy:xmax;
        
        %% convert scatter plot to grid plot
        D=[];
        originX=leftPoint+radius;
        E=zeros(length(xMesh),length(yMesh));
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
                %                 if ((xx-originX)^2+yy^2>=radius^2 && xx<=originX)
                %                     E(i,j)=255;
                %                     E(length(xMesh)-i+1,j)=255;
                %                 end
            end
        end
        
        [Boun,L,N] = bwboundaries(D);
        stats=  regionprops(L, 'Centroid', 'Area', 'Perimeter');
        Area = cat(1,stats.Area);
        Centroid = cat(1, stats.Centroid);
        Perimeter = cat(1,stats.Perimeter);

        if ismember(caseN,[213:226])
            for i=1:length(Area)
                if Centroid(i,2)<10
                    Area(i)=0;
                    [~, i]=max(Area);
                end
            end
        end
        [~, n]=max(Area);
        E([1 end],:)=255;
        E(:,[1 end])=255;
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
        above=find(percentageS>=0.2);
        if isempty(above)
            i=1;
        else
            i=above(end);
        end
        switch caseN
            case 213
                turnerEnd=2.35; %location of the outlet
            case 214
                turnerEnd=2.45;
            case 215
                turnerEnd=2.23; %location of the outlet
            case 216
                turnerEnd=2.28;
            case 217
                turnerEnd=2.33; %location of the outlet
            case 218
                turnerEnd=2.38;
            otherwise
                turnerEnd=0.16;
        end
        
        [~,index]=min(abs(xMesh-turnerEnd));
        plot([index; i] ,[floor(r/2); floor(r/2)],'b','LineWidth',2);
        plot([index;index],[0;r],'b','LineWidth',2);
        criticalDistance=(xMesh(i)-xMesh(index))/radius;
        hold off;
        title(['Ucritical=' num2str(Ucritical) 'criticalDistance=' num2str(criticalDistance,'%10.2f') '*Radius']);
        
        criticalLength{caseN}(ii,1)=Ucritical;
        criticalLength{caseN}(ii,2)=criticalDistance;
        print(gcf,['D:\CFD_second_HHD\06232021\204\Data\Case_' num2str(caseN) '_Ucritical=' num2str(Ucritical) '.png'],'-dpng','-r800');
        %         saveas(gcf,['D:\CFD_second_HHD\06232021\204\Data\Case_' num2str(caseN) '_Ucritical=' num2str(Ucritical) '.png'])
        ii=ii+1;
    end
    
end
cd (opath)


