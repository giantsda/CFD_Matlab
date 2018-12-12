movieFile='E:\desktop\temp\PIV\IMG_0334.MOV';
path='E:\desktop\temp\PIV\334\';
mov=VideoReader(movieFile);
numFrames = mov.NumberOfFrames;
totalImage=2;
frameStore=randi([100,1000-1],totalImage,1); 
frameStore=[50 251 555];
parfor_progress(totalImage); % Set the total number of iterations
parfor i=1:length(frameStore)
    j=frameStore(i);
    pivFigGenerator(movieFile,path,j,10); % generate A-B file pairs
    parfor_progress;
end
parfor_progress(0);

flierRemove(path,10)
 

