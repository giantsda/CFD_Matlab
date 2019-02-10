movieFile='E:\desktop\temp\PIV\IMG_0333.MOV';
path='E:\desktop\temp\PIV\333\';
mov=VideoReader(movieFile);
numFrames = mov.NumberOfFrames;
totalImage=4;
% frameStore=randi([1000,numFrames-1],totalImage,1);
frameStore=[1050 1251 1555];
mov=VideoReader(movieFile);

for i=1:length(frameStore)
    j=frameStore(i);
    frame = read(mov,j);
    figure;
    imshow(frame);
    figure;
    frame = read(mov,j+10);
    imshow(frame);
    pause();
    close all;
end
