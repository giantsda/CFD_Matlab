figure;
Plot_VTK_mesh('filter_meadian.vtk');
view(180,0)
finalP=[];
for e=1:number
    finalP=[finalP; particle{e}(end,3:5)];
end
hold on;
scatter3(finalP(:,1),finalP(:,2),finalP(:,3),100,'.');