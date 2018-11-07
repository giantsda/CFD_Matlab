function rename_file (folder_path, file_name,file_number)
    for i=1:1:file_number
        s = num2str(i);
        if i<10
        newpath=[folder_path '\' file_name '.csv.00' s];% for example 'C:\Users\chenshen\Desktop\temp\New folder (2)\12_20.txt.001'
        else
        newpath=[folder_path '\' file_name '.csv.0' s] ;% for example 'C:\Users\chenshen\Desktop\temp\New folder (2)\12_20.txt.012'
        end
        newname=[folder_path '\' file_name '_' s '.csv' ];% for example 'C:\Users\chenshen\Desktop\temp\New folder (2)\12_20_1.txt'
        movefile(newpath,newname);
    end

%%     
% path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10182016\28\data'
% file=dir([ path '\E*']);
% for i=1:length(file)
% file_name=[ path '\' file(i).name]
% new_name=[path '\'  '28' file(i).name(end-14:end)]
% movefile(file_name,new_name)
% end
