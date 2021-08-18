%The length of the straight channel does not significantly change the critical velocity,
%thus the critical vertical velocity is redefined as the 20 percent of the vertical velocity
%in the box that is defined as a rectangle of radius and 2*radius.
figure;
set(gcf,'outerposition',get(0,'screensize'));

criticalDistanceS=[];
MainPath='D:\CFD_second_HHD\02212020\130';
cd (MainPath);

UcriticalS=0.06:0.01:0.28;
results={};
for i=1:56
    % i=49
    caseN=i;
    Data={};
    cd (MainPath);
    cd (num2str(caseN));
    
    
    if mod(i,8)==1
        %% Read mesh, do not need if only interested in data files.
        filename='centeriod.txt';
        fid1=fopen(filename,'r');
        numberOfCells = fscanf(fid1, '%d',1);
        dec2hex(fread(fid1,1,'*int8'));
        meshStore=fread(fid1,numberOfCells*3,'*double');
        meshStore=reshape(meshStore,3,[]).';
        fclose(fid1);
    end
    % if i<5
    %     continue;
    % end
    files=dir('.');
    times=[];
    for i=4:length(files)
        file=files(i).name;
        if (~isempty(regexp(file(1:2) ,'[0-9][0-9]')) && isdir(file))
            if (str2num(file)>99)
                times=[times convertCharsToStrings(file)];
            end
        end
    end
    N=length(times);
    for n=1:N
        %% reading U Field
        U=[];
        time=char(times(n));
        fprintf("reading data %s of case %d\n",time,caseN);
        fpid = fopen([time '/U'], 'r');
        for i=1:20
            fgetl(fpid);
        end
        numberOfPoints = fscanf(fpid, '%d',1);
        dec2hex(fread(fpid,2,'*int8'));
        U =fread(fpid,numberOfPoints*3,'*double');
        U=reshape(U,3,[]).';
        U=U(:,3);
        %         U=abs(U(:,3));
        fclose(fpid);
        %% reading only the first VOF Field
        first=1;
        if (first)
            fpid = fopen([time '/alpha.water'], 'r');
            for i=1:20
                fgetl(fpid);
            end
            numberOfPoints = fscanf(fpid, '%d',1);
            dec2hex(fread(fpid,2,'*int8'));
            vof= fread(fpid,numberOfPoints,'*double');
            fclose(fpid);
            Data.vof=vof;
            first=0;
        end
        
        Data.time(n)=str2num(time);
        Data.U{n}=U;
        Data.vof=vof;
    end
    Data.mesh=meshStore;
    %% filter air, and find exame box defined as radius* 2radius.
    i=find(Data.vof<0.7);
    Data.mesh(i,:)=[];
    Data.vof(i,:)=[];
    for n=1:N
        Data.U{n}(i,:)=[];
    end
    radius=(max(Data.mesh(:,2))-min(Data.mesh(:,2)))/2;
    leftPoint=min(Data.mesh(:,1));
    
    %% filter first straight channel because of the impact of the paddle wheel.
    i=find(Data.mesh(:,2)<0);
    Data.mesh(i,:)=[];
    Data.vof(i,:)=[];
    for n=1:N
        Data.U{n}(i,:)=[];
    end
    
    i=find(Data.mesh(:,3)>0.18); % remove the nodes that is adjcent to air. Data here will have close to 1 vof but huge velocity.
    if caseN>=9&&caseN<=24
        i=find(Data.mesh(:,3)>0.15);
    end
    Data.mesh(i,:)=[];
    Data.vof(i,:)=[];
    for n=1:N
        Data.U{n}(i,:)=[];
    end
    
    %% calculate critical length
    xmin=min(Data.mesh(:,1));
    xmax=max(Data.mesh(:,1));
    ymin=min(Data.mesh(:,2));
    ymax=max(Data.mesh(:,2));
    
    
    
    
    
    for i=1:length(UcriticalS)
        Ui=i;
        Ucritical=UcriticalS(i);
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
        if  length(A)<10
            continue;
        end
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
        if length(B)<=100
            continue;
        end
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
%             i/length(xMesh)*100
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
        percentage=length(find(E==255))/(size(E,1)*size(E,2)-length(find(E==100)));
        
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
        title(['criticalDistance=' num2str(criticalDistance) '*Radius Ucritical=' num2str(Ucritical)]);
        %         saveas(gcf,['C:\Users\chenshen.ETS01297\Desktop\temp\k\case' num2str(caseN) '_' num2str(Ucritical) '.png'])
        %         criticalDistanceS(Ui)=criticalDistance;
        results{caseN}.UcriticalS(Ui)=UcriticalS(Ui);
        results{caseN}.percentage(Ui)=percentage;

        
    end
        load handel
        sound(y,Fs)
    %     plot(UcriticalS,criticalDistanceS,'*-');
    %     saveas(gcf,['C:\Users\chenshen.ETS01297\Desktop\temp\k\case' num2str(caseN) '_criticalDistanceSVsUcriticalS.png']);
end

% clearvars -except results MainPath
% save([MainPath '/results.mat'], '-v7.3');
% disp('store UcriticalStore to MainPath.............. \n');

%     Ucritical=UcriticalStore{caseN}.percent3;
%     index=zeros(size(Data.vof));
%     for j=1:length(Data.U)
%         index(abs(Data.U{j})>Ucritical)=1;
%     end
%     ii=find(index==1);
%     scatter3(Data.mesh(ii,1),Data.mesh(ii,2),Data.mesh(ii,3),6,'b','filled')
%     axis equal;
%     view(0,90);
%     title(['case=' num2str(caseN) '  Ucritical=' num2str(Ucritical)])
%     pause(1);
%     saveas(gcf,['C:\Users\chenshen.ETS01297\Desktop\temp\k\' num2str(caseN) '.png'])

