path='/lustre/eaglefs/projects/co2cfd/running/130/242/';

for caseI=1
    cd (path)
    cd (num2str(caseI))
    minTime=200;
    MaxTime=Inf;
    numFolders=strings();
    folders=dir([path num2str(caseI) '/*']);
    folders={folders.name};
    j=1
    for i=1:length(folders)
        if ~isempty(str2num(folders{i}))
            if str2num(folders{i})>=minTime+0.2 && str2num(folders{i})<MaxTime
                numFolders(j)=folders{i};
                j=j+1;
            end
        end
    end
    
    %% reading files
    A=cell(1,length(numFolders));
    for i=1:length(numFolders)
        file=['./' numFolders{i} '/lagrangian/kinematicCloud/' 'positions'];% read position.
        fprintf('reading %s\n',file);
        fid=fopen(file);
        if fid==-1
            continue;
        end
        for j=1:17
            fgets(fid);
        end
        t=fgets(fid);
        N=str2num(t);
        Temp=zeros(N,3);
        fgets(fid); % jump 1 line
        a=fread(fid,1,'uchar');
        for j=1:N
            Temp(j,:)=fread(fid,3,'double');
            fread(fid,7,'uchar');
        end
        %     A{i}=Temp;
        fclose(fid);
        
        file=['./' numFolders{i} '/lagrangian/kinematicCloud/' 'origId'];% read originID;
        fprintf('reading %s\n',file);
        fid=fopen(file);
        if fid==-1
            continue;
        end
        for j=1:18
            fgets(fid);
        end
        t=fgets(fid);
        N=str2num(t);
        c=fread(fid,1,'uchar'); % jump 1 chars (28);
        ID=fread(fid,N,'int32');
        % reconstruct the position based on the index.
        [~,inDex]=sort(ID);
        Temp=Temp(inDex,:);
        A{i}=single(Temp);
        fclose(fid);
    end
    
    %% create particle
    time=[]; % create time column
    for i=1:length(numFolders)
        time(i,1)=str2num(numFolders(i));
    end
    
    if N>20000
        N=20000;
    end
    
    particle=cell(1,N);
    for i=1:N
        particle{i}(:,1)=time;
        for j=1:length(A)
            particle{i}(j,3:5)=A{j}(i,:);
        end
    end
    
    clearvars -except particle number path caseI
    
    number=length(particle);  % change double to single to save space and load time
    for i=1:number
        particle{i}=single(particle{i});
    end
    
    %% get maxY for liquid depth
    p = randi([1,number],50,1);
    posZ=[];
    for i=1:length(p)
        posZ=[posZ;particle{i}(:,5)];
    end
    [counts,centers] = hist(posZ,200);
    counts=counts/sum(counts);
    waterDepth=centers(max(find(counts>=mean(counts))));
    
    Data.particle=particle;
    Data.number=number;
    Data.waterDepth=waterDepth;
    
    save(['../particle_' num2str(caseI) '.mat'],'Data','-v7.3');
end

