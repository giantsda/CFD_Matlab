%  cd('C:\Users\chenshen.ETS01297\Desktop\Linux\a');
%  for i=33:62
%      mkdir(num2str(i));
%  end


cd('F:\Temp\redo');
dirs=dir('.');;
for i=3:length(dirs)
    dirName=dirs(i).name;
    copyfile('../controlDict', ['./' dirs(i).name '/system/controlDict'])
end