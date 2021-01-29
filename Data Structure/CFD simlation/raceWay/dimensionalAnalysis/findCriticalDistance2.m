% This one finds the cells where Uz>U* larger than criticalPercentage and
% plot it on a 2D plane.
close all;
clear all;

MainPath='D:\CFD_second_HHD\02212020\130';
cd (MainPath);
 
UcriticalArray=[0.0634900000000000,0.0150100000000000,0.0206100000000000,0.0309300000000000,0.0487600000000000,0.0560900000000000,0.0778500000000000,0.0862400000000000,0.0789300000000000,0.0182100000000000,0.0305800000000000,0.0554200000000000,0.0658200000000000,0.0690500000000000,0.0912500000000000,0.0812000000000000,0.0865900000000000,0.0295800000000000,0.0326700000000000,0.0539000000000000,0.0798700000000000,0.0944400000000000,0.102830000000000,0.0877000000000000,0.0933400000000000,0.0127800000000000,0.0242900000000000,0.0381400000000000,0.0543300000000000,0.0733400000000000,0.0922800000000000,0.0847900000000000,0.0876600000000000,0.0140300000000000,0.0210700000000000,0.0374900000000000,0.0561000000000000,0.0721600000000000,0.111700000000000,0.111810000000000,0.0736800000000000,0.00602000000000000,0.0115500000000000,0.0285800000000000,0.0460200000000000,0.0552500000000000,0.0782700000000000,0.00568000000000000,0.0579700000000000,0.00223000000000000,0.00715000000000000,0.0243600000000000,0.0377100000000000,0.0485800000000000,0.0646600000000000,0.0653700000000000];

first=1;
fid1=fopen([MainPath '\criticalDistanceResults.txt'],'w');
fprintf(fid1,"Note: You need to use criticalDistanceResults minus the radius to get true  criticalDistance, This files stores criticalDistance using Ucritical:");
fprintf(fid1,"%s, ",UcriticalArray);
fprintf(fid1,"\n");

h = figure;
for c=49:56
    Data=[];
    cd(num2str(c))
    fprintf(fid1,"case %d:",c);
    Ucritical=UcriticalArray(c);
    distanceArray=[];
    if mod(c,8)==1
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


