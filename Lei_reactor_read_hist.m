% folder_path='E:\desktop\temp' 
% file_name='file';
% data=[];
% % rename_file (folder_path, file_name,4);
% for haha=1:1
% filename1 = [folder_path '\' file_name '.his'] ;
% % file.his
% % filename1 = [folder_path '\' file_name '_' num2str(haha) '.csv'] ;
% disp(filename1);
% delimiterIn = '\t'; %read txt file
% if haha==1
% headerlinesIn = 13;
% else
%     headerlinesIn=1;
% end
% data_m = importdata(filename1,delimiterIn,headerlinesIn);
% data_m.data(end,:)=[];  
% data=[data; data_m.data];
% data=single(data);
% end
% xposition=data(:, 3); %store data into column vecter;
% yposition=data(:, 4);
% particleid=data(:, 2);
% particletime=data(:, 1);
% ber=size(particleid);%find how manys rows do I have ; ber is a vecter
% rownumber=ber(1);
% number=1; %number of different particle
% for i=1:1:rownumber-1
%     if particleid(i) ~= particleid(i+1)
%         number=number+1;
%     end
% end  
% particle=cell(1,number);  %create number matrixs to store my data,called particle{1}, particle{2}...particle{number}
% j=1; %calculate times of jth particle repeating
% repeat=ones(1,number); %k is a 1*number vector used to record repeat times 
% for i=1:1:rownumber-1   
%     if particleid(i)== particleid(i+1)
%         repeat(j)=repeat(j)+1;
%     else
%         j=j+1;
%     end
% end
% c=1;
% for a=1:1:number  %for ath partocle
%         particle{a}(:,1)=particletime(c : c-1+repeat(a));
%         particle{a}(:,2)=particleid(c : c-1+repeat(a));
%         particle{a}(:,3)=xposition(c : c-1+repeat(a));
%         particle{a}(:,4)=yposition(c : c-1+repeat(a));
%         c=c+repeat(a);  
% end
% clearvars -except particle number folder_path
% save([folder_path '\particle.mat']);
% fprintf('store all data to particle.............. \n');
%%
ypos_store=[];
for i=1:number
    time= particle{i}(:,1);
    particleid= particle{i}(:,2);
    xp= particle{i}(:,3)*1000000;
    yp= particle{i}(:,4)*1000000;        
    j=find(xp>4264.4 & xp<4267);
    if isempty(j)~=1
    ypos=yp(j(1));
    ypos_store=[ypos_store ypos];
    end
end
ypos_store=ypos_store+45.14;
ypos_store=20-ypos_store;
ypos_store=ypos_store.';
hist(ypos_store,1000)
% xlim([-45.14 -25.14])
xlim([0 20])