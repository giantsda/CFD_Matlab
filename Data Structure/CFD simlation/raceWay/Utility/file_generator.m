%% this file generate folds in fold_path
fold_path = 'D:\CFD_second_HHD\02212020\130'; 
for i=1:1:20
i=num2str(i);    
path=[fold_path '\' i]
mkdir(path); 
end
