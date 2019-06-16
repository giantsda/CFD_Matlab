%% this file uses ensightGold combined Geo file and extract the first time step geometry from it
%% for plotting or making video, I wills still need all geos since rotate rotating
path='C:\CFD_second_HHD\racewayOpenfoam\06102019\78\Test\';
filename1='Binary.geo';
filename2='oneTime.geo';

beginTimeStep=double('BEGIN TIME STEP').';
beginTimeStep=[beginTimeStep; zeros(4*8*2+1,1)]; 
endTimeStep=double('END TIME STEP').';
endTimeStep=[endTimeStep; zeros(4*8*2+1,1)];  
beginInsertLocation=5*8*2;

fID1=fopen([path filename1],'r');
fID2=fopen([path filename2],'w');
fseek(fID1,0, 1); % go to end
position = ftell( fID1) % total byte
fseek(fID1,0, -1) % go to start
t=fread(fID1,position,'*uint8'); % read all byte to t
usefulStart=(45*8+4)*2+1;
usefulEnd=strfind(t.',double('END TIME STEP'));
usefulEnd=usefulEnd(1)-1;
geo=t(usefulStart:usefulEnd);
t=[t(1:usefulEnd) ; endTimeStep];   %insert beginTimeStep and endTimeStep
fwrite(fID2,t,'uint8');
fclose(fID1);
fclose(fID2);

% haha=t(1:500);
% c=cellstr(char(haha));
% strjoin(cellstr(char(haha)))

 