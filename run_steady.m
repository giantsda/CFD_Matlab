%%
%define and initialization
clc;
clear;
                                    ll='30000';
                                    folder_path=['C:\Users\chenshen\Desktop\CFD\Result validation\41\water\' ll '_9.0s'];
                                    file_name=ll;
% folder_path='C:\Users\chenshen\Desktop\temp\debug';
% file_name='500';
timelimitfactor=0.9;
timevector=[];
del=0;
gas=[];
light=[];
% [file_number] = get_file_number (folder_path, file_name);
                file_number=5
rename_file (folder_path, file_name,file_number)
%%
% in order to get timelimit
line_vector=[];
        file_repeat=1;
        [particle,number_m] = read_and_store (folder_path, file_name,file_repeat,line_vector);
        [particle,timevector_m,gas_m]  = delete_gas (particle,number_m);
        timevector= timevector_m;
        mediantime=median(timevector); %average time for integration
        timelimit=timelimitfactor*mediantime
%%
line_vector=[];
for file_repeat=1:1:file_number
    file_repeat 
    [particle,number_m,line_vector] = read_and_store (folder_path, file_name,file_repeat,line_vector);
    [particle,timevector_m,gas_m]  = delete_gas (particle,number_m);
    [particle,del_m]  = delete_small_time (particle,number_m,timelimit);
    [light_m] = light_integ (number_m, particle,timelimit);
    del=del+del_m;
    light=[light light_m];  
    numbervector(file_repeat)=number_m;
    gas=[gas gas_m];
end
number=sum(numbervector);
report (light, mediantime,gas,number,del,timelimit,timelimitfactor,folder_path,file_name,line_vector);
