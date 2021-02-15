path='/home/chen/Desktop/project/172/3';
minTime=153;
MaxTime=inf;
numFolders=strings();
folders=dir([path '/*']);
folders={folders.name};
j=1;

for i=1:length(folders)
    if ~isempty(str2num(folders{i}))
        if str2num(folders{i})>=minTime && str2num(folders{i})<MaxTime
            numFolders(j)=folders{i};
            FolderTime(j)=str2num(folders{i});
            j=j+1;
        end
    end
end
[~,I] = sort(FolderTime); 
numFolders=numFolders(I); %% sort by time or 1000s is before 255s etc.

%% reading files
A=cell(1,length(numFolders));
for i=1:length(numFolders)
    file=[path '/' numFolders{i} '/lagrangian/kinematicCloud/' 'positions'];% read position.
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
    
    file=[path '/' numFolders{i} '/lagrangian/kinematicCloud/' 'origId'];% read originID;
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
    A{i}=Temp;    
    fclose(fid);
end

%% create particle
time=[]; % create time column
for i=1:length(numFolders)
    time(i,1)=str2num(numFolders(i));
end
particle=cell(1,N);
for i=1:N
    particle{i}(:,1)=time;
    for j=1:length(A)
        particle{i}(j,3:5)=A{j}(i,:);
    end
end

disp('writting all data to particle.............. \n');
clearvars -except particle   path
save([path '/particle.mat'], '-v7.3');
disp('store all data to particle.............. \n');

% %% plot
% for i=1:20
%     e=randi(length(particle));
%     p=particle{e};
%     plot3(p(:,3),p(:,5),p(:,4));
%     hold on;
%     pause(1);
%     axis equal;
% end
% axis equal;








