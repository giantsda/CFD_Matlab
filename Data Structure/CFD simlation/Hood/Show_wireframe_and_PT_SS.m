figure;
set(gcf,'outerposition',get(0,'screensize'));

%% Read wall mesh
[vertex face]= Plot_VTK_mesh('wall-filter_0.vtk');
 view(-180,-43);
hold on;
for e=1:2000 
     e=randi([1 number]);
    plot3(particle{e}(:,3),particle{e}(:,4),particle{e}(:,5));
    pause();
end

