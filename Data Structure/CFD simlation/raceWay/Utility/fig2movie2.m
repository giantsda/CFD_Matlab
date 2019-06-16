path='E:\desktop\temp\re\63\';
frame_files = dir([ path '\*.png']);
%% this file combine figs to generate a Movie by writeVideo
v = VideoWriter('E:\desktop\temp\63Velocity.mp4','MPEG-4');
v.FrameRate=8;
v.Quality = 75;
open(v)
begin=1;
middle=1;
endd=10;
i=1;
for i=begin:middle:length(frame_files)
    file_name = [path '\' frame_files(i).name];
%     file_name=[path num2str(i) '.jpg'];
    frame=imread( file_name);
%     frame=imresize(frame,[1088 1920]);
    writeVideo(v, frame);
    i
end
close(v)

%%
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
%     imshow(real)
%     imwrite(combine,['E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\24\animation\redo\redodo\combine\' num2str(i) '.jpg'])
%     i
% end
