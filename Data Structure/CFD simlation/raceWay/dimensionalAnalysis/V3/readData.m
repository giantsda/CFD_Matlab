% %The length of the straight channel does not significantly change the critical velocity,
% %thus the critical vertical velocity is redefined as the 20 percent of the vertical velocity
% %in the box that is defined as a rectangle of radius and 2*radius.
% 
% oPath=pwd;
% MainPath='D:\CFD_second_HHD\02212020\130';
% % MainPath='/scratch/chenshen/chenshen/project/';
% cd (MainPath);
% 
% 
%     caseN=1
%     Data={};
%     cd (MainPath);
%     cd ("1");
%     %     fprintf(fid,"Case %s: ",num2str(i));
%  
% %     if mod(i,8)==1
%         %% Read mesh, do not need if only interested in data files.
%         filename='centeriod.txt';
%         fid1=fopen(filename,'r');
%         numberOfCells = fscanf(fid1, '%d',1);
%         dec2hex(fread(fid1,1,'*int8'))
%         meshStore=fread(fid1,numberOfCells*3,'*double');
%         meshStore=reshape(meshStore,3,[]).';
%         fclose(fid1);
% %     end
% %     if i<=45
% %         continue;
% %     end
%     files=dir('.');
%     times=[];
%     for i=4:length(files)
%         file=files(i).name;
%         if (~isempty(regexp(file(1:2) ,'[0-9][0-9]')) && isdir(file))
%             if (str2num(file)>78)
%                 times=[times convertCharsToStrings(file)];
%             end
%         end
%     end
%     N=length(times);
%     fprintf("total %d data files detected.\n",N);
%     % N=15; %debug
%     for n=1:N
%         %% reading U Field
%         U=[];
%         time=char(times(n));
%         fprintf("reading data %s of case %d\n",time,caseN);
%         fpid = fopen([time '/U'], 'r');
%         for i=1:20
%             fgetl(fpid);
%         end
%         numberOfPoints = fscanf(fpid, '%d',1);
%         dec2hex(fread(fpid,2,'*int8'));
%         U =fread(fpid,numberOfPoints*3,'*double');
%         U=reshape(U,3,[]).';
%         
%         fclose(fpid);
%         %% reading only the first VOF Field
%         first=1;
%         if (first)
%             fpid = fopen([time '/alpha.water'], 'r');
%             for i=1:20
%                 fgetl(fpid);
%             end
%             numberOfPoints = fscanf(fpid, '%d',1);
%             dec2hex(fread(fpid,2,'*int8'));
%             vof= fread(fpid,numberOfPoints,'*double');
%             fclose(fpid);
%             Data.vof=vof;
%             first=0;
%         end
%         
%         Data.time(n)=str2num(time);
%         Data.U{n}=single(U);
%         Data.vof=single(vof);
%     end
%     Data.mesh=(meshStore);
%      
% 
y_mesh=53.68-[5 10 15 20 25 30 35 40 45 48];  %% 53.68and 155
y_mesh=y_mesh/100;
% y_mesh=fliplr(y_mesh);
 
z_mesh=linspace(2,17,11)/100;

% y_mesh=linspace(-56,0,50);
% y_mesh=y_mesh/100;
% z_mesh=linspace(0,0.2,50);

[y1,z1]=meshgrid(y_mesh,fliplr(z_mesh));
value_s=y1*0;

index=find(abs(meshStore(:,1)--0.8485)<=0.002&(meshStore(:,2)>0));
sliceMesh=meshStore(index,:);
scatter3(sliceMesh(:,1),sliceMesh(:,2),sliceMesh(:,3))



for i=1:length(Data.U)

sliceI=double(Data.U{i}(index,:));
value_i=griddata(sliceMesh(:,2),sliceMesh(:,3),abs(sliceI(:,1)),y1,z1);

value_s=value_s+value_i;
    
%  pcolor(y1,z1,value_s)   
%  shading interp;
% axis equal
% colormap parula
% colorbar
% hold on;
% pause()
end 

meanVelocity=value_s/length(Data.U);
figure;
pcolor(y1,z1,meanVelocity)
shading interp;
axis equal
colormap parula
colorbar
caxis([0 0.6]);
hold on;
scatter(reshape(y1,1,[]),reshape(z1,1,[]),'*')

