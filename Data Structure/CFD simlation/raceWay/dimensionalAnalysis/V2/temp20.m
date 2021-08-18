MainPath='D:\CFD_second_HHD\02212020\130';
close all;
timeS={};
for caseI=1:60
    
    cd (MainPath);
    cd (num2str(caseI));
    
    load('Data.mat');
    timeS{caseI}=Data.time;
    fprintf('done loading case %d\n',caseI);
end

for i=1:length(timeS)
    if ~isempty(timeS{i})
        plot(i,timeS{i}(end),'*');
        hold on;
        if timeS{i}(end)<113
            i
            pause;
        end
    end
end