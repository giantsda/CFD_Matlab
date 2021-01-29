%% this program read velocity field and store it as profile.

% path='C:\CFD_second_HHD\racewayOpenfoam\05102019\65\profiles\';
% files=dir([ path 'profile-*']);
% 
% profile=cell(1,length(files));
% 
% special_index=[];
% for i=1:length(files)   % sort the file name for reading and plot
%     name=files(i).name;
%     index=find(name(:)=='-'); % index is the position of the cha '-'
%     time=name(index+1:end);
%     timeTag(i,:)=[i str2num(time)];
% end
% [timeTag index]=sortrows(timeTag,2);
% files=files(index);
% 
% parfor_progress(length(files)); % Set the total number of iterations
% parfor i =1:length(files)%length(files)
%     delimiterIn = ','; %read txt file
%     headerlinesIn=1;
%     dataI = importdata([path files(i).name],delimiterIn,headerlinesIn);
%     dataI=single(dataI.data);
%     profile{i}=dataI;
%     parfor_progress;
% end
%  parfor_progress(0);
% 
% disp('writting all data to profile.............. \n');
% clearvars -except profile path timeTag;
% save([path 'profile.mat'], '-v7.3');
% disp('store all data to profile.............. \n');


