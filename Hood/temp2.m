figure;
set(gcf,'outerposition',get(0,'screensize'));
Plot_VTK_mesh('F:\wall-human_0.vtk')
%  zoom(2);
 view(79,22)
 c=[];
for e=1:number
    if particle{e}(end,4)<=-0.008
        c=[c e];
    end
end
 
% for e=1:5000
%     e=randi(number);
%     plot3(particle{e}(:,3),particle{e}(:,4),particle{e}(:,5));
%     hold on;
%     pause(0);
% end


for e=c
    plot3(particle{e}(:,3),particle{e}(:,4),particle{e}(:,5));
    hold on;
    pause(0);
end