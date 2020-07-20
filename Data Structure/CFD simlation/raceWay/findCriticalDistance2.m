close all;
clear all;

MainPath='D:\CFD_second_HHD\02212020\130';
cd (MainPath);
UcriticalArray=[0.0854100000000000,0.0191800000000000,0.0236200000000000,0.0396600000000000,0.0570000000000000,0.0701000000000000,0.0963000000000000,0.118750000000000,0.208190000000000,0.0315500000000000,0.0417500000000000,0.0762900000000000,0.101390000000000,0.141390000000000,0.335440000000000,0.454500000000000,0.196760000000000,0.0374100000000000,0.0465000000000000,0.0816000000000000,0.116590000000000,0.152560000000000,0.215920000000000,0.272490000000000,0.105990000000000,0.0600000000000000,0.0314000000000000,0.0498100000000000,0.0711900000000000,0.0880500000000000,0.123250000000000,0.151140000000000,0.104370000000000,0.0165200000000000,0.0275200000000000,0.0453400000000000,0.0634700000000000,0.0842700000000000,0.118440000000000,0.136900000000000,0.0846700000000000,0.0600000000000000,0.0186300000000000,0.0340900000000000,0.0528900000000000,0.0650400000000000,0.0963800000000000,0.0116400000000000,0.0761500000000000,0.0105600000000000,0.0148500000000000,0.0337300000000000,0.0488000000000000,0.0649400000000000,0.0960500000000000,0.130910000000000];
first=1;
fid1=fopen([MainPath '\criticalDistanceResults.txt'],'w');
fprintf(fid1,"Note: You need to use criticalDistanceResults minus the radius to get true  criticalDistance, This files stores criticalDistance using Ucritical:");
fprintf(fid1,"%s, ",UcriticalArray);
fprintf(fid1,"\n");

h = figure;
for c=15:15
    Data=[];
    cd(num2str(c))
    fprintf(fid1,"case %d:",c);
    Ucritical=UcriticalArray(c);
    distanceArray=[];
%     if mod(c,8)==1
        %% Read mesh, do not need if only interested in data files.
        filename='centeriod.txt';
        fid=fopen(filename,'r');
        numberOfCells = fscanf(fid, '%d',1);
        dec2hex(fread(fid,1,'*int8'))
        meshStore=fread(fid,numberOfCells*3,'*double');
        meshStore=reshape(meshStore,3,[]).';
        fclose(fid);

%     end
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
    first=1;
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
    
    
    i=find(Data.mesh(:,3)>0.17); % remove the nodes that is adjcent to air. Data here will have close to 1 vof but hugh velocity.
    Data.mesh(i,:)=[];
    Data.vof(i,:)=[];
    for n=1:N
        Data.U{n}(i,:)=[];
    end
    
    Data.count=zeros(length(Data.vof),1);
    for n=1:N
        Data.count=Data.count+double(Data.U{n}>Ucritical);
    end
    
    criticalPercentage=0.2;
    
    i=find(Data.count>criticalPercentage*N);
    Data.mesh(:,3)=[]; % project to XY plane
    % scatter(Data.mesh(i,1),Data.mesh(i,2),2,'b','filled')
    % axis equal;
    A = sortrows(Data.mesh(i,:),[1 2]); % removing overlapping points
    B=A(1,:);
    for i=2:length(A)
        if  A(i,1)-A(i-1,1)<=0.001&&A(i,2)-A(i-1,2)<=0.001
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
            D(j)=norm(B(i,:)-B(j,:));
        end
        D(find(D==0))=[];
        E(i)=min(D);
    end
    meanMeshDistance=mean(E);
    critcal=meanMeshDistance*1.5;
    % convert scatter plot to grid plot
    D=[];
    for i=1:length(xMesh)
        i/length(xMesh)*100
        x=xMesh(i);
        for j=1:length(yMesh)
            y=yMesh(j);
            C=abs(B-[x y]);
            C(:,3)=sqrt(C(:,1).^2+C(:,2).^2);
            minDistance=min(C(:,3));
            if minDistance<=critcal
                D(i,j)=1;
            end
        end
    end
    
    [Boun,L,N] = bwboundaries(D);
    stats=  regionprops(L, 'Centroid', 'Area', 'Perimeter');
    Area = cat(1,stats.Area);
    Centroid = cat(1, stats.Centroid);
    Perimeter = cat(1,stats.Perimeter);
    [~, n]=max(Area);
    
    imshow(rot90(1-D))
    hold on;
    criticalDistance=xMesh(max(Boun{n,1}(:,1)))-xmin;
    plot(Boun{n}(:,1), size(D,2)-Boun{n}(:,2)+1, 'r', 'LineWidth', 1)
    hold off;
    title(['criticalDistance=' num2str(criticalDistance)]);
    saveas(gcf,['../criticalDistance-' num2str(c) '.png']);
    fprintf(fid1,"criticaldistance=%f\n----------------------\n",criticalDistance);
    
    cd (MainPath);
end
fclose(fid1);


