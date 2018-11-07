 folder_path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\24\animation\PT\'
files = dir([folder_path '*.jpg'])
j=1
for i=1:650   % sort the file name for reading and plot
    i
%     old_name=files(i).name;
%     old_path=[folder_path old_name];
    old_path=[folder_path num2str(i) '.jpg'];
    new_name=num2str(i);
    new_path=[folder_path new_name '.jpg'];
    for haha=1:16
      new_path=['E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10022016\24\animation\PT_double\' num2str(j) '.jpg'];
     copyfile(old_path,new_path);
     j=j+1;
    end
end   

 