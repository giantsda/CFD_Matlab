%% this file generate folds in fold_path
fold_path = 'E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\HPC speed study'; 
for i=2:1:20
i=num2str(i);    
path=[fold_path '\' i]
mkdir(path); 
end
