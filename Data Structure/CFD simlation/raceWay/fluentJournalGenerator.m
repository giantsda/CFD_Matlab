%% This file reads fluent case and dat files and export its internal data
path='C:\CFD_second_HHD\racewayOpenfoam\01232019\16';
folder=dir(path);
folderList=[];
journalFileName='16Journal';
nP=5;  % pesuo-parallel processors

for i=1:length(folder)
    % if it is not . or .. and it is a floder
    if ~any(strcmp(folder(i).name, {'.', '..'}))&&folder(i).isdir==1
        folderList=[folderList;i];
    end
end
folder=folder(folderList);

jobQueue=[];
k=1;
for i=1:length(folder)
    searchPath=fullfile(path,folder(i).name);
    datFiles=dir(fullfile(searchPath,'*.dat'));
    casFiles=dir(fullfile(searchPath,'*.cas'));
    if length(datFiles)~=length(casFiles)
        error('length(datFiles)~length(casFiles) something is wrong\n');
    end
    % sort files based on time
    datTime=[];
    for j=1:length(datFiles)
        try
            datTime(j,1)=sscanf(datFiles(j).name,'%*d-%*d-%f*s');
        end
    end
    [datTime,index]=sort(datTime);
    datFiles=datFiles(index);
    casFiles=casFiles(index);
    
    for j=1:length(datFiles)
        jobQueue(k).folderName=folder(i).name;
        jobQueue(k).readPath=['/home/students/chenshen/running/16/' folder(i).name  '/' casFiles(j).name];
        jobQueue(k).datTime=num2str(datTime(j),'%5.2f');
        k=k+1;
    end
end

%% assign jobs
nJobs=length(jobQueue);
jobPerProcessor=floor(nJobs/nP);
jobAssignmentMap=zeros(nP,2);
for i=1:nP
    % processor i is doing jobs jobAssignmentMap(i,1) to jobAssignmentMap(i,2)
    jobAssignmentMap(i,1)=(i-1)*jobPerProcessor+1;
    jobAssignmentMap(i,2)=(i)*jobPerProcessor;
end
jobAssignmentMap(nP,2)=nJobs;

%% write jounalFile

for i=1:nP
    fileName=[path '\' journalFileName '-' num2str(i) '.txt'];
    fileID = fopen(fileName,'w');
    fprintf('%s \n',['Writting to  ' fileName]);
    for j=jobAssignmentMap(i,1):jobAssignmentMap(i,2)
        fprintf( fileID,'/file/read-case-data\n');
        % 1 if run it on cluster
        fprintf( fileID,'"%s"\n',jobQueue(j).readPath);
        fprintf( fileID,'ok\n');
        fprintf( fileID,'/file/export/ascii\n');
        fprintf( fileID,'case%s-%s\n\n',jobQueue(j).folderName, jobQueue(j).datTime);
        fprintf( fileID,'yes\nw-vof\nw-nahco3\ncell-volume\n""\nyes\n\n');
    end
    fclose(fileID);
end