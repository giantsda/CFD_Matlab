%% This file reads fluent case and dat files and export its internal data
path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10212016\29\data';
folderList=[];
journalFileName='29Journal';
nP=1;  % pesuo-parallel processors

jobQueue=[];
k=1;

searchPath=path;
datFiles=dir(fullfile(searchPath,'*.dat'));
casFiles=dir(fullfile(searchPath,'*.cas'));

%% if mismatch, find out where
% for i=1:length(casFiles)
%     if ~strcmp(datFiles(i).name(1:end-4),casFiles(i).name(1:end-4))
%         i
%        error('mismatch');
%     end
% end

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

datFiles=datFiles(1:30);
casFiles=casFiles(1:30);



for j=1:length(datFiles)
    jobQueue(k).readCasPath=['E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10212016\29\data\' casFiles(j).name];
    jobQueue(k).readDatPath=['E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10212016\29\data\' datFiles(j).name];
    jobQueue(k).datTime=num2str(datTime(j),'%5.2f');
    k=k+1;
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
    fileName=['E:\desktop\temp\' journalFileName '-' num2str(i) '.txt'];
    fileID = fopen(fileName,'w');
    fprintf('%s \n',['Writting to  ' fileName]);
    for j=jobAssignmentMap(i,1):jobAssignmentMap(i,2)
        fprintf( fileID,'/file/read-case\n');
        % 1 if run it on cluster
        fprintf( fileID,'"%s"\n',jobQueue(j).readCasPath);
        fprintf( fileID,'ok\n');
        fprintf( fileID,'/file/read-data\n');
        fprintf( fileID,'"%s"\n',jobQueue(j).readDatPath);
        fprintf( fileID,'ok\n');
        fprintf( fileID,'/file/export/ascii\n');
        fprintf( fileID,'%s\n\n',jobQueue(j).datTime);
        fprintf( fileID,'yes\nx-velocity\ny-velocity\nz-velocity\n""\nyes\n\n');
    end
    fclose(fileID);
end









