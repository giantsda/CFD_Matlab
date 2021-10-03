filePath='C:\Users\chenshen.ETS01297\Desktop\temp\87\pick';
cd (filePath)

files=dir('./');
for i=3:length(files)
    i
    I=imread(files(i).name);
%     imshow(I);
    J=I(1:621,:,:);
    imshow(J)
    imwrite(J,files(i).name);
end

