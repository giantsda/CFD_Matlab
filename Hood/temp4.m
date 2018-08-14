folder='E:\desktop\temp\mesh'
all_files=[];
dirinfo = dir(folder);
dirinfo(~[dirinfo.isdir]) = [];  %remove non-directories
dirinfo(1:2)=[];
subdirinfo = cell(length(dirinfo),1);
for K = 1 : length(dirinfo)
    thisdir = dirinfo(K).name;
    subdirinfo{K} = dir(fullfile(folder,thisdir, '*.vtk'));
    if length(subdirinfo{K})~=0
        subdirinfo{K}.vtk=fullfile(folder,thisdir, subdirinfo{K}.name);
    end
end


close all;
figure;
set(gcf,'outerposition',get(0,'screensize'));
for i=1:length(subdirinfo)
    filename=subdirinfo{i}.vtk;
    Plot_VTK_mesh(filename);
end
