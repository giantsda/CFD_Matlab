%% this file generate figs of all frame
mov=VideoReader('E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\24\re.MOV'); 
numFrames = mov.NumberOfFrames
path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\24\animation\re_new\';
j=1;
 for i = 1 : 1: numFrames 
     frame = read(mov,i);
%      frame=fliplr(frame);
%      imshow(frame);
 imwrite(frame,[path  num2str(j)  '.jpg']);
 j=j+1;
       if rem(i,100)==0
          disp([num2str(i) ' / ' num2str(numFrames)]); 
       end
 end
 
 
%%
%  tex=['time= ' num2str(time,'%0.4f') ' s'];
% add=vision.TextInserter(tex, 'Location', [460 1200],'FontSize', 42,'Color',[255 255 255],'Font', 'Times New Roman');
% add.Font='Times New Roman';
% F=step(add,f);
% imwrite(F,['E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\24\animation\real_time\' num2str(i) '.jpg'])