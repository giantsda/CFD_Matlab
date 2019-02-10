movieFile='E:\desktop\temp\PIV\IMG_0333.MOV';
path='E:\desktop\temp\PIV\333\';
mov=VideoReader(movieFile);
numFrames = mov.NumberOfFrames;
totalImage=4;
% frameStore=randi([1000,numFrames-1],totalImage,1); 
frameStore=[1050 1251 1555];
parfor_progress(totalImage); % Set the total number of iterations
parfor i=1:length(frameStore)
    j=frameStore(i);
    pivFigGenerator(movieFile,path,j,2); % generate A-B file pairs
    parfor_progress;
end
parfor_progress(0);

flierRemove(path,10)
  