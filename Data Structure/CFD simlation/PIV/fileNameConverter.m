%% This files convert file names bw_00042_A.png and bw_00042_B.png to 1.png and 2.png
%% this will aid for flierRemove.m
function fileNameConverter(path)
clc;
filePattern='*_A.*';
files=dir([path filePattern]);
for i=1:length(files)
    fileA=files(i).name;
    fileB=strrep(fileA,'_A','_B');
    if (~exist([path fileB]))
       error([fileA ' exists but ' fileB ' does not exist! \n']);
    end    
end
fprintf('Checked: file A-B pattern OK. \n');
fprintf('Renaming... \n');

j=1;
for i=1:length(files)
    fileA=files(i).name;
    fileB=strrep(fileA,'_A','_B');
    movefile([path fileA],[path num2str(j,'%0.5d') '.png']);
    movefile([path fileB],[path num2str(j+1,'%0.5d') '.png']); 
    j=j+2;
end
fprintf('Rename Done \n');


 