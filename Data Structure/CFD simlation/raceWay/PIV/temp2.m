path='E:\desktop\temp\PIV\955\';
 
%% this file combine figs to generate a Movie by writeVideo
v = VideoWriter('E:\desktop\temp\ne.avi');
v.FrameRate=30;
open(v)
begin=1282;
middle=1;
endd=1463;
i=1;
for i=begin:middle:endd
%     file_name = [path '\' frame_files(i).name];
    file_name=[path 'I_0' num2str(i) '.png'];

    frame=imread( file_name); 
%     imshow(frame);
    for j=1:5
    writeVideo(v, frame);
    end
    i
end

close(v)