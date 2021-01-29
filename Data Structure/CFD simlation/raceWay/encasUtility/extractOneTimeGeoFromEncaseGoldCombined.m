%% this file uses ensightGold combined Geo file and extract the first time step geometry from it
%% for plotting or making video, I will still need all geos since rotate rotating
path='D:\CFD_second_HHD\06082020\147\data\data\';
filename1='146.geo';
filename2='oneTime.geo';

beginTimeStep=double('BEGIN TIME STEP').';
beginTimeStep=[beginTimeStep; zeros(4*8*2+1,1)]; 
endTimeStep=double('END TIME STEP').';
endTimeStep=[endTimeStep; zeros(4*8*2+1,1)];  
beginInsertLocation=5*8*2;

fid1=fopen([path filename1],'r');
fid2=fopen([path filename2],'w');
fseek(fid1,0, 1); % go to end
position = ftell( fid1)/20; % total byte
fseek(fid1,0, -1); % go to start
fprintf('reading   %s     ',filename1);
t=fread(fid1,position,'*uint8'); % read all byte to t
fprintf('Done.\n',filename1);
usefulStart=(45*8+4)*2+1;
usefulEnd=strfind(t.',double('END TIME STEP'));
usefulEnd=usefulEnd(1)-1;
geo=t(usefulStart:usefulEnd);
t=[t(1:usefulEnd) ; endTimeStep];   %insert beginTimeStep and endTimeStep
fprintf('writing   %s  size:%d     ',filename2,length(t));
fwrite(fid2,t,'uint8');
fprintf('Done.\n');
fclose(fid1);
fclose(fid2);

% haha=t(1:500);
% c=cellstr(char(haha));
% strjoin(cellstr(char(haha)))

 