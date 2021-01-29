% This one calculates the times that the cell Uz>U* and then projected
% to a 2D plane.
close all;
clear all;

MainPath='D:\CFD_second_HHD\02212020\130';
cd (MainPath);
 
first=1;
fid1=fopen([MainPath '\criticalDistanceResults.txt'],'w');
fprintf(fid1,"Note: You need to use criticalDistanceResults minus the radius to get true  criticalDistance, This files stores criticalDistance using Ucritical:");
 
fprintf(fid1,"\n");

h = figure;
percentFolder='97Percents';
mkdir([MainPath  '\' percentFolder] );
    
for cc=1:56
    mkdir([MainPath  '\' percentFolder '\' num2str(cc)]);
    Data=[];
    cd(num2str(cc))
    fprintf(fid1,"case %d:",cc);
    
    distanceArray=[];
    if mod(cc,8)==1
        %% Read mesh, do not need if only interested in data files.
        filename='centeriod.txt';
        fid=fopen(filename,'r');
        numberOfCells = fscanf(fid, '%d',1);
        dec2hex(fread(fid,1,'*int8'))
        meshStore=fread(fid,numberOfCells*3,'*double');
        meshStore=reshape(meshStore,3,[]).';
        fclose(fid);
    end
    Data.mesh=meshStore;
    % readDataFiles
    files=dir(".");
    times=[];
    for i=4:length(files)
        file=files(i).name;
        if (~isempty(regexp(file(1:2) ,'[0-9][0-9]')) && isdir(file))
            if (str2num(file)>38)
                times=[times convertCharsToStrings(file)];
            end
        end
    end
    
    N=length(times);
    %     N=3; % debug
    first=1;
    criticaldistanceArray=[];
    for n=1:N
        time=char(times(n));
        cd(times(n));
        %% reading U Field
        U=[];
        fprintf("reading data %s\n",time);
        fpid = fopen([time '/U'], 'r');
        for i=1:20
            fgetl(fpid);
        end
        numberOfPoints = fscanf(fpid, '%d',1);
        dec2hex(fread(fpid,2,'*int8'));
        U =fread(fpid,numberOfPoints*3,'*double');
        U=reshape(U,3,[]).';
        U=abs(U(:,3)); % get vertical component, in this case, it is the 3rd element.
        fclose(fpid);
        Data.U{n}=U;
        %% reading VOF Field
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
        cd("../")
    end
    %% filter first straight channel,air,small vertical U region
    i=find(Data.vof<0.7);
    Data.mesh(i,:)=[];
    Data.vof(i,:)=[];
    for n=1:N
        Data.U{n}(i,:)=[];
    end
    
    i=find(Data.mesh(:,2)<0);
    Data.mesh(i,:)=[];
    Data.vof(i,:)=[];
    for n=1:N
        Data.U{n}(i,:)=[];
    end
    
    
    i=find(Data.mesh(:,3)>0.17); % remove the nodes that is adjcent to air. Data here will have close to 1 vof but high velocity.
    Data.mesh(i,:)=[];
    Data.vof(i,:)=[];
    for n=1:N
        Data.U{n}(i,:)=[];
    end
    
    xmin=min(Data.mesh(:,1));
    xmax=max(Data.mesh(:,1));
    ymin=min(Data.mesh(:,2));
    ymax=max(Data.mesh(:,2));
    
    
    USample=sort(Data.U{1});
    index=length(Data.U{1})*0.97;

 
    Ucritical=USample(round(index))
    fprintf(fid1,"Ucritical: %f:",Ucritical);
    
    for c=1:N
        Data.count=zeros(length(Data.vof),1);
        Data.count=double(Data.U{c}>Ucritical);
        
        i=find(Data.count>0);
        if size(Data.mesh,2)==3
            Data.mesh(:,3)=[]; % project to XY plane
        end
%         scatter(Data.mesh(i,1),Data.mesh(i,2),2,'b','filled')
%         xlim([xmin xmax]);
%         ylim([ymin ymax]);
%         axis equal;
%         
%         saveas(gcf,[num2str(times(n)) '.png']);
% %         cd (MainPath);
%     end
%     
%     continue;
    
    
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
    
    %         scatter(B(:,1),B(:,2),3,'filled');
    %         axis equal;
    %         hold off;
    
    xmin=min(B(:,1));
    xmax=max(B(:,1));
    ymin=min(B(:,2));
    ymax=max(B(:,2));
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
    %     %% make unoverlaped mesh to plot background boundary
    %     [A, index] = sortrows(Data.mesh(:,1:2),[1 2]); % removing overlapping points
    %     Data.unoverlapedMesh=A(1,:);
    %     for i=2:length(A)
    %         if  A(i,1)-A(i-1,1)<=0.001&&A(i,2)-A(i-1,2)<=meanMeshDistance
    %             ;
    %         else
    %             Data.unoverlapedMesh=[Data.unoverlapedMesh;A(i,:)];
    %         end
    %     end
    %% convert scatter plot to grid plot
    D=[];
    for i=1:length(xMesh)
        i/length(xMesh)*100
        xx=xMesh(i);
        for j=1:length(yMesh)
            yy=yMesh(j);
            %             E=Data.mesh(:,1:2);
            %             C=abs(Data.unoverlapedMesh-[xx yy]);
            %             C(:,3)=sqrt(C(:,1).^2+C(:,2).^2);
            %             [index]=find(C(:,3)<critcal);
            %             D(i,j)=100;
            C=abs(B(:,1:2)-[xx yy]);
            C(:,3)=sqrt(C(:,1).^2+C(:,2).^2);
            minDistance=min(C(:,3));
            if minDistance<=critcal
                D(i,j)=255;
            end
        end
    end
    
    [Boun,L,N] = bwboundaries(D);
    stats=  regionprops(L, 'Centroid', 'Area', 'Perimeter');
    Area = cat(1,stats.Area);
    Centroid = cat(1, stats.Centroid);
    Perimeter = cat(1,stats.Perimeter);
    [~, n]=max(Area);
    
%     surf(x,y,rot90(D)/max(max(D)),'edgecolor','none');
%     axis equal;
%     colorbar;
%     view(0,-90);
%         caxis([0 0.3]);
         imshow(rot90(1-D))
    hold on;
    criticalDistance=xMesh(max(Boun{n,1}(:,1)))-xMesh(min(Boun{n,1}(:,1)));
    plot(Boun{n}(:,1), size(D,2)-Boun{n}(:,2)+1, 'r', 'LineWidth', 1)
    hold off;
    title(['criticalDistance=' num2str(criticalDistance)]);
    criticaldistanceArray(c)=criticalDistance;
    saveas(gcf,[MainPath  '\' percentFolder '\' num2str(cc) '\' num2str(times(c)) '.png']);

    end
    fprintf(fid1,"criticaldistance=%f\n----------------------\n",mean(criticaldistanceArray));

    cd (MainPath);
end
% fclose(fid1);


