% %The length of the straight channel does not significantly change the critical velocity,
% %thus the critical vertical velocity is redefined as the 20 percent of the vertical velocity
% %in the box that is defined as a rectangle of radius and 2*radius.
% 
% MainPath='/home/chen/Desktop/project/239/base';
% 
% 
% 
% Data={};
% cd (MainPath);
% 
% 
% %% Read mesh, do not need if only interested in data files.
% filename='centeriod.txt';
% fid1=fopen(filename,'r');
% numberOfCells = fscanf(fid1, '%d',1);
% dec2hex(fread(fid1,1,'*int8'))
% meshStore=fread(fid1,numberOfCells*3,'*double');
% meshStore=reshape(meshStore,3,[]).';
% fclose(fid1);
% 
% files=dir('.');
% times=[];
% for i=4:length(files)
%     file=files(i).name;
%     if (~isempty(regexp(file(1:2) ,'[0-9][0-9]')) && isdir(file))
%         if (str2num(file)>200)
%             times=[times convertCharsToStrings(file)];
%         end
%     end
% end
% N=length(times);
% %     fprintf(fid,"total %d data files detected.\n",N);
% %     N=2; %debug
% %     for n=1:N
% times=["203" "203.5"];
% %% reading U Field
% for n=1:length(times)
%     U=[];
%     time=char(times(n));
%     
%     
%     Data{n}.time=time;
%     fprintf("reading data %s of case  \n",time );
%     fpid = fopen([time '/U'], 'r');
%     for i=1:20
%         fgetl(fpid);
%     end
%     numberOfPoints = fscanf(fpid, '%d',1);
%     dec2hex(fread(fpid,2,'*int8'));
%     U =fread(fpid,numberOfPoints*3,'*double');
%     U=reshape(U,3,[]).';
%     
%     fclose(fpid);
%     %% reading only the first VOF Field
%     
%     fpid = fopen([time '/alpha.water'], 'r');
%     for i=1:20
%         fgetl(fpid);
%     end
%     numberOfPoints = fscanf(fpid, '%d',1);
%     dec2hex(fread(fpid,2,'*int8'));
%     vof= fread(fpid,numberOfPoints,'*double');
%     fclose(fpid);
%     Data{n}.vof=vof;
%     
%     
%     
%     fpid = fopen([time '/H'], 'r');
%     for i=1:20
%         fgetl(fpid);
%     end
%     numberOfPoints = fscanf(fpid, '%d',1);
%     dec2hex(fread(fpid,2,'*int8'));
%     H= fread(fpid,numberOfPoints,'*double');
%     fclose(fpid);
%     Data{n}.H=H;
%     
%     fpid = fopen([time '/HCO3'], 'r');
%     for i=1:20
%         fgetl(fpid);
%     end
%     numberOfPoints = fscanf(fpid, '%d',1);
%     dec2hex(fread(fpid,2,'*int8'));
%     HCO3= fread(fpid,numberOfPoints,'*double');
%     fclose(fpid);
%     Data{n}.HCO3=HCO3;
%     
%     fpid = fopen([time '/CO2'], 'r');
%     for i=1:20
%         fgetl(fpid);
%     end
%     numberOfPoints = fscanf(fpid, '%d',1);
%     dec2hex(fread(fpid,2,'*int8'));
%     CO2= fread(fpid,numberOfPoints,'*double');
%     fclose(fpid);
%     Data{n}.CO2=CO2;
%     
%     fpid = fopen([time '/CO32m'], 'r');
%     for i=1:20
%         fgetl(fpid);
%     end
%     numberOfPoints = fscanf(fpid, '%d',1);
%     dec2hex(fread(fpid,2,'*int8'));
%     CO32m= fread(fpid,numberOfPoints,'*double');
%     fclose(fpid);
%     Data{n}.CO32m=CO32m;
%     
%     fpid = fopen([time '/TIC'], 'r');
%     for i=1:20
%         fgetl(fpid);
%     end
%     numberOfPoints = fscanf(fpid, '%d',1);
%     dec2hex(fread(fpid,2,'*int8'));
%     TIC= fread(fpid,numberOfPoints,'*double');
%     fclose(fpid);
%     Data{n}.TIC=TIC;
%     
% end
%   


I=find(Data{2}.TIC<=Data{1}.TIC)
% TIC203=sum(Data{1}.TIC)
% TIC2035=sum(Data{2}.TIC)


