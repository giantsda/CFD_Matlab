movieFile='C:\Users\chenshen.ETS01297\Desktop\Paper\Go-NoGo meeting\3.avi';
path='C:\Users\chenshen.ETS01297\Desktop\Paper\Go-NoGo meeting\q\';
mov=VideoReader(movieFile);
numFrames = mov.NumberOfFrames;
 
for i=1:numFrames
    j=i;
    I=read(mov,j); % generate A-B file pairs
    imshow(I)
    imwrite(I,[path 'I_'  num2str(j,'%0.5d')  '.png']);
end
 