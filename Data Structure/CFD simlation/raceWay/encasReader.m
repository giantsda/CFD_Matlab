%% Read geometry
% N=[];
% fID = fopen('E:\desktop\temp\re\ascii.geo');
% while ~feof(fID)
%     s=fgetl(fID);
%     if s(1:2)=='co'
%         s=fgetl(fID);
%         n=sscanf(s,'%d');
%         N=[N n]
%     end
% end
%  fclose(fID);

% N =[  436132     2656239      129220       36180       56995       10241       17160]

%% read file combined BINARY
path='C:\CFD_second_HHD\racewayOpenfoam\06102019\78\Test\';
baseName='Binary.case';
fID = fopen([path baseName]);
while ~feof(fID)
    s=fgetl(fID);
end
timeStep=sscanf(s,'number of steps:%d');
fclose(fID);
fprintf('%s shows there are %d time steps .\n',baseName,timeStep);
filename='Binary.scl5';
Data=[];
% timeStep=5;
fID = fopen([path filename]);
fprintf('reading %s ... \n',filename);
fread(fID,162,'uint16');% fixed length head
for t=1:timeStep
    for i=1:length(N)
        Data{i,t}= fread(fID,N(i),'*single');
        if i~=length(N)
            fread(fID,82,'uint16');% fixed length divider
        end
    end
    fread(fID,202,'uint16');% fixed length divider 835649
end
fclose(fID);
fprintf('reading Done ... \n');

%% read file separate ASCII
% Data=[];
% path='E:\desktop\temp\re\';
% files=dir([path '78*.scl1']);
% for f=1:length(files)
%     fID = fopen([path files(f).name]);
%     fprintf('reading %s ... \n',files(f).name);
%     for i=1:4
%         fgetl(fID);
%     end
%     for i=1:length(N)
%         Data{i,f}= fscanf(fID,'%e',N(i));
%         fgetl(fID);
%         fgetl(fID);
%         fgetl(fID);
%         fgetl(fID);
%     end
%     fclose(fID);
% end
% fprintf('reading Done ... \n',f);

%% read file separate BINARY
% Data=[];
% path='E:\desktop\temp\re\';
% files=dir([path 'b*.scl1']);
% for f=1:length(files)
%     fID = fopen([path files(f).name]);
%     fprintf('reading %s ... \n',files(f).name);
%     A = fread(fID,122,'uint16');% fixed length head
%     for i=1:length(N)
%         Data{i,f}= fread(fID,N(i),'*single');
%         fread(fID,82,'uint16');% fixed length divider
%     end
%     fclose(fID);
% end 
% fprintf('reading Done ... \n',f);




