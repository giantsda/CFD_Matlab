movieFile='E:\desktop\temp\PIV\IMG_0955.MOV';
path='E:\desktop\temp\PIV\955\';
mov=VideoReader(movieFile);
numFrames = mov.NumberOfFrames;

frameStore=[1000:2000];

parfor_progress(length(frameStore)); % Set the total number of iterations
parfor i=1:length(frameStore)
    j=frameStore(i)
    I=read(mov,j); % generate A-B file pairs
    imwrite(I,[path 'I_'  num2str(j,'%0.5d')  '.png']);
    parfor_progress;
end
parfor_progress(0);

% parfor_progress(length(frameStore)); % Set the total number of iterations
% parfor i=1:length(frameStore)
%     j=frameStore(i)
%     pivFigGenerator(mov,path,j,2); % generate A-B file pairs
%     parfor_progress;
% end
% parfor_progress(0);

% flierRemove(path,10)
  