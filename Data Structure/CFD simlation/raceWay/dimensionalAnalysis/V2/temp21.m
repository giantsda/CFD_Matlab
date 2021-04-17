MainPath='D:\CFD_second_HHD\02212020\130';
close all;
timeS={};
 
    
    cd (MainPath);
    cd (num2str(caseI));
    
    load('Data.mat');
    timeS{caseI}=Data.time;
    fprintf('done loading case %d\n',caseI);
 
 