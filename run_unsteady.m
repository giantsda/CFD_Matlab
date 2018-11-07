%%
%define and initialization
clc;
clear;
folder_path='E:\desktop\CFD\Dr Peers Reactor\Simulation\redo3';
file_name='export';
timevector=[];
del=0;
light=[];
de_num=[];
file_number=1
% rename_file (folder_path, file_name,file_number);
%%
% in order to get timelimit
line_vector=[];
% file_repeat=1;
% [particle,number_m] = unsteady_read_and_store (folder_path, file_name,file_repeat,line_vector);
% [timelimit]  = unsteady_timelimit (particle,number_m);
% timelimit 
%%
line_vector=[];
for file_repeat=1:1:file_number
file_repeat 
[particle,number_m,repeat,line_vector] = unsteady_read_and_store (folder_path, file_name,file_repeat,line_vector);  
if file_repeat==1
     [timelimit]  = unsteady_timelimit (particle,number_m)
end
[particle,del_m,ch_m]  = unsteady_delete_poor_par (particle,number_m,repeat);   
[light_m] = unsteady_light_int (number_m, particle, [] );
del=del+del_m;
light=[light light_m];  
numbervector(file_repeat)=number_m;
de_num=[de_num ch_m];
end
number=sum(numbervector);
unsteady_report (light,number,del,timelimit,folder_path,file_name,line_vector);
