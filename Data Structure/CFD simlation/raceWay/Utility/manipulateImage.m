filaPath='C:\Users\chenshen.ETS01297\Desktop\temp\plot\Hood';
files=dir(filaPath);
cd(filaPath)
for i=3:length(files)
    fileName=files(i).name
    I=imread(fileName);
    J=I(:,1:900,:);
    imshow(J);
    imwrite(J,['M_' fileName]);
%     pause();
end











