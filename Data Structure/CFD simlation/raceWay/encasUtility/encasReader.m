% clear all;
path='D:\CFD_second_HHD\06102019\78\timeAccumulated\';

%% Read binary geometry
geofile='oneTime.geo';
fprintf('reading Geometry file ...      ');
N=[];
fid = fopen([path geofile]);
fseek(fid,0, 1); % go to end
position = ftell( fid); % total byte
fseek(fid,0, -1); % go to start
t=fread(fid,position,'*uint8'); % read all byte to t
coordinates=strfind(t.',double('coordinates'));
for i=1:length(coordinates)
    number=t(coordinates(i)+80:coordinates(i)+83);
    N(i)=hex2dec(strjoin(flipud(cellstr(char(dec2hex(number)))),''));
end
fclose(fid);
fprintf('Done. \n');
fprintf('N= ');
fprintf('%d  ',N);
fprintf('\n');

%  N =[  436132     2656239      129220       36180       56995       10241       17160]

%% read file combined BINARY
filename='binary.scl5';
baseName='binary.case';
fid = fopen([path baseName]);
while ~feof(fid)
    s=fgetl(fid);
end
timeStep=sscanf(s,'number of steps:%d');
% timeStep=250;
fclose(fid);
fprintf('%s shows there are %d time steps.\n',baseName,timeStep);
% Data=[];
% timeStep=5;
fid = fopen([path filename]);
fread(fid,162,'uint16');% fixed length head
for t=1:timeStep
    fprintf('reading %s timeStep: %d of %d ...        ',filename,t,timeStep);
    e=1;
    for i=1:length(N)
%         Data{t}(e:e+N(i)-1, 2)= fread(fid,N(i),'*single');
        Data{t}(e:e+N(i)-1, 1)= fread(fid,N(i),'*single');
        e=e+N(i);
        if i~=length(N)
            fread(fid,82,'uint16');% fixed length dividerw
        end
    end
    fread(fid,202,'uint16');% fixed length divider 835649
    fprintf('Done.\n');
end
fclose(fid);

%% read file separate ASCII
% Data=[];
% path='E:\desktop\temp\re\';
% files=dir([path '78*.scl1']);
% for f=1:length(files)
%     fid = fopen([path files(f).name]);
%     fprintf('reading %s ... \n',files(f).name);
%     for i=1:4
%         fgetl(fid);
%     end
%     for i=1:length(N)
%         Data{i,f}= fscanf(fid,'%e',N(i));
%         fgetl(fid);
%         fgetl(fid);
%         fgetl(fid);
%         fgetl(fid);
%     end
%     fclose(fid);
% end
% fprintf('reading Done ... \n',f);

%% read file separate BINARY
% Data=[];
% path='E:\desktop\temp\re\';
% files=dir([path 'b*.scl1']);
% for f=1:length(files)
%     fid = fopen([path files(f).name]);
%     fprintf('reading %s ... \n',files(f).name);
%     A = fread(fid,122,'uint16');% fixed length head
%     for i=1:length(N)
%         Data{i,f}= fread(fid,N(i),'*single');
%         fread(fid,82,'uint16');% fixed length divider
%     end
%     fclose(fid);
% end
% fprintf('reading Done ... \n',f);




