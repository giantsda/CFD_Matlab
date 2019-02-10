 path='E:\desktop\temp\';
frame_files = dir([ path '*.jpg']);
%% this file combine figs to generate a Movie by writeVideo
v = VideoWriter('E:\desktop\temp\haha.avi');
v.FrameRate=10;
open(v)
begin=1;
middle=1;
endd=196;
i=1;
for i=begin:middle:length(frame_files)
    file_name = [path '\' frame_files(i).name];
%     file_name=[path num2str(i) '.jpg'];
    frame=imread( file_name);
    for j=1:3
    writeVideo(v, frame);
    end
    i
end

close(v)











