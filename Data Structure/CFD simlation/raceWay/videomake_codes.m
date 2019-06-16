
% folder_path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\57mm\video\bar_resize\';
% files = dir([folder_path '*.jpg']);
% j=121;
% for jj=1:30
% for i=1:120   % sort the file name for reading and plot
%     real=[folder_path num2str(i) '.jpg'];
%     from=real;
%     to=[folder_path num2str(j) '.jpg'];
%     copyfile(from,to);
%     j=j+1;
% end
% end



% folder_path='F:\simu\';
% files = dir([folder_path '*.jpg']);
% j=1;
% for i=1:length(files)   % sort the file name for reading and plot
%     real=[folder_path num2str(i) '.jpg'];
%     real=imread(real);
%     real(:,end-70:end,:)=real(:,570:640,:);
%         real(:,1:201,:)=real(:,end-200:end,:);
% %     real = imresize(real, [1280 720]);
% %     imshow(real);
%         imwrite(real,['E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\57mm\video\simu_resize\' num2str(j) '.jpg'])
%     j=j+1
% end

% folder_path='F:\bar\';
% files = dir([folder_path '*.jpg']);
% j=1;
% for i=1:length(files)   % sort the file name for reading and plot
%         real=[folder_path num2str(i) '.jpg'];
%         real=imread(real);
%         real(:,end-70:end,:)=real(:,570:640,:);
%         real(:,1:201,:)=real(:,end-200:end,:);
% %     real = imresize(real, [1280 720]);
% %     imshow(real);
%         imwrite(real,['E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\57mm\video\bar_resize\' num2str(j) '.jpg'])
%     j=j+1
% end

% folder_path1='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\57mm\video\simu_resize\';
% folder_path2='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\57mm\video\bar_resize\';
%  j=1;
% for i=1:1000   % sort the file name for reading and plot
%     i=2*i;
%     simu=    [folder_path1 num2str(i) '.jpg'];
%     bar=    [folder_path2 num2str(i) '.jpg'];
%     simu=imread(simu);
%     bar=imread(bar);
%     simu(1111:1280,280:515,:)=  bar(1111:1280,280:515,:)  ;
% %     real = imresize(real, [1280 720]);
% %     imshow(real);
%  imwrite(simu,['E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\57mm\video\simu_change\' num2str(j) '.jpg'])
%     j=j+1
% end


% real_path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\24\animation\redo\redodo\real_time\';
% change_path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\57mm\video\simu_change\';
%  PT_path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\24\animation\PT_re\';
% j=1;
% for i=1:1000%length(files)   % sort the file name for reading and plot
%     real=imread([real_path num2str(i) '.jpg']);
%     change=imread([change_path num2str(i) '.jpg']);
%     PT=imread([PT_path num2str(i) '.jpg']);
%     PT(:,end-149:end,:)=PT(:,1:150,:);
%     combine=[real change PT];
% %     imshow(combine)
%     imwrite(combine,['E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\57mm\video\combine\' num2str(i) '.jpg'])
%     i
% end



% folder_path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\24\animation\redo\redodo\simulation_half\';
% files = dir([folder_path '*.jpg']);
% j=1;
% for i=1:length(files)   % sort the file name for reading and plot
%     real=[folder_path num2str(i) '.jpg'];
%   if mod(i,2)==1
%       delete(real);
%
%   end
%
%     j=j+1
% end



% folder_path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\24\animation\redo\redodo\simulation_half\';
% files = dir([folder_path '*.jpg']);
% j=1;
% for i=2:2:660%length(files)   % sort the file name for reading and plot
%     from=[folder_path num2str(i) '.jpg'];
%     for ii=1:3
%         to =['E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\24\animation\redo\redodo\simulation_change\' num2str(j) '.jpg'];
%          copyfile(from,to);
%          j=j+1;
%     end
% i
% end


% folder_path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\24\animation\redo\real2\';
%
% j=1;
% for i=13:1000%length(files)   % sort the file name for reading and plot
%     from=[folder_path num2str(i) '.jpg'];
%     for ii=1:2
%         to =['E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\24\animation\redo\redodo\real_double\' num2str(j) '.jpg'];
%          copyfile(from,to);
%          j=j+1;
%     end
% i
% end




% real_path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\24\animation\redo\redodo\real_time\';
% change_path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\24\animation\redo\redodo\simulation_change\';
% bar_path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\24\animation\redo\redodo\bar\';
% PT_path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\24\animation\PT_re\';
% j=1;
% for i=1:660%length(files)   % sort the file name for reading and plot
%     real=imread([real_path num2str(i) '.jpg']);
%     change=imread([change_path num2str(i) '.jpg']);
%     bar=imread([bar_path num2str(i) '.jpg']);
%     PT=imread([PT_path num2str(i) '.jpg']);
%     PT(:,end-149:end,:)=PT(:,1:150,:);
%     simu=[change(1:1120,:,:); bar(1121:end,:,:)];
%     combine=[real simu PT];
% %     imshow(combine)
%     imwrite(combine,['E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\24\animation\redo\redodo\combine\' num2str(i) '.jpg'])
%     i
% end




% path=' E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\24\animation\redo\redodo\real_double\';
% j=1;
% for i=1:1000%length(files)   % sort the file name for reading and plot
%     real=imread([path num2str(i) '.jpg']);
%     time=i*0.002;
%     time=num2str(time, '%1.3f');
%     add_text=['time=' time 's'];
%     add_text=vision.TextInserter(add_text);
%     add_text.FontSize=40;
%     add_text.Location=[467 1200];
%     add_text.Color=[500 500 500];
%     real=step(add_text,real);
% %     imshow(real)
%     imwrite(real,['E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\24\animation\redo\redodo\real_time\' num2str(i) '.jpg'])
%     i
% end



% folder_path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\57mm\video\';
% files = dir([folder_path '*.jpg']);
% j=1;
% for i=1:length(files)   % sort the file name for reading and plot
%     from=[ folder_path files(i).name ];
%     to=[folder_path num2str(j) '.jpg'];
%     movefile(from, to);
%     j=j+1;
% end
