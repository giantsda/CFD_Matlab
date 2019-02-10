path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\24\animation\re_new\';
file=dir(path);
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