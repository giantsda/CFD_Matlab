%The length of the straight channel does not significantly change the critical velocity,
%thus the critical vertical velocity is redefined as the 20 percent of the vertical velocity
%in the box that is defined as a rectangle of radius and 2*radius.

oPath=pwd;
MainPath='/home/chen/Desktop/project';
% MainPath='/scratch/chenshen/chenshen/project/';
cd (MainPath);

for i= [204:216]
    caseN=i
    Data={};
    cd (MainPath);
    cd (num2str(i));
    %     fprintf(fid,"Case %s: ",num2str(i));
    if ismember(i,[207:212])
        ;
    else
        cd ('water')
    end
%     if mod(i,8)==1
        %% Read mesh, do not need if only interested in data files.
        filename='centeriod.txt';
        fid1=fopen(filename,'r');
        numberOfCells = fscanf(fid1, '%d',1);
        dec2hex(fread(fid1,1,'*int8'))
        meshStore=fread(fid1,numberOfCells*3,'*double');
        meshStore=reshape(meshStore,3,[]).';
        fclose(fid1);
%     end
%     if i<=45
%         continue;
%     end
    files=dir('.');
    times=[];
    for i=4:length(files)
        file=files(i).name;
        if (~isempty(regexp(file(1:2) ,'[0-9][0-9]')) && isdir(file))
            if (str2num(file)>78)
                times=[times convertCharsToStrings(file)];
            end
        end
    end
    N=length(times);
    fprintf("total %d data files detected.\n",N);
%     N=15; %debug
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
        Data.U{n}=single(U);
        Data.vof=single(vof);
    end
    Data.mesh=single(meshStore);
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
    if ismember(caseN,[213:218])
        i=find(Data.mesh(:,2)<0);
        Data.mesh(i,:)=[];
        Data.vof(i,:)=[];
        for n=1:N
            Data.U{n}(i,:)=[];
        end
    end 
    
    i=find(Data.mesh(:,3)>0.18); % remove the nodes that is adjcent to air. Data here will have close to 1 vof but huge velocity.
    if ismember(caseN,[207,208])
        i=find(Data.mesh(:,3)>0.13); % remove the nodes that is adjcent to air. Data here will have close to 1 vof but huge velocity.
    end
    if ismember(caseN,[209,210])
        i=find(Data.mesh(:,3)>0.08); % remove the nodes that is adjcent to air. Data here will have close to 1 vof but huge velocity.
    end
    if ismember(caseN,[211,212])
        i=find(Data.mesh(:,3)>0.23); % remove the nodes that is adjcent to air. Data here will have close to 1 vof but huge velocity.
    end    
    Data.mesh(i,:)=[];
    Data.vof(i,:)=[];
    for n=1:N
        Data.U{n}(i,:)=[];
    end
    
    
    fprintf("Done with reading data for case %d.\n",caseN);
    
    save([MainPath '/Data/Data_' num2str(caseN) '.mat'],'Data', '-v7.3');
    disp('store UcriticalStore to MainPath.............. \n');
end
cd(oPath);