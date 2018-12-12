%% plot_mesh file
% the goal of this function is take mesh info, vertices location and plot
% the mesh
function plot_mesh(cell,vertices_location)
x1=zeros(1,length(cell)*6);
x2=x1;
j=1;
for i=1:length(cell)
    c=cell(i,:);
    h=vertices_location(c,:);
    x1(j:j+5)=[h(:,1).' h(1,1) NaN];
    x2(j:j+5)=[h(:,2).' h(1,2) NaN];
    j=j+6;
end
plot(x1,x2,'k');
axis equal;





