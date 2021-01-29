path='E:\desktop\temp\PIV\0271';
frame_files = dir([ path '\color*.bmp']);
%% this file combine figs to generate a Movie by writeVideo
v = VideoWriter('E:\desktop\temp\ne.avi');
v.FrameRate=30;
open(v)
begin=1;
middle=1;
endd=300;
i=1;
for i=begin:middle:endd
    file_name = [path '\' frame_files(i).name];
%     file_name=[path num2str(i) '.jpg'];

    frame=imread( file_name); 
    for j=1:5
    writeVideo(v, frame);
    end
    i
end

close(v)