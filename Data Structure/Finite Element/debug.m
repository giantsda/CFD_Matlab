%% debug
function debug(cell,vertices_location)
v1=vertices_location(cell(1,:),:);

debug_J(0.1,0.1,vertices_location)

function R=debug_J(x,y,vertices_location)
 vertices=[1 2 5 4];
 v=vertices_location(vertices,:);
R(1,1)=v(1,1)*(y-1)+v(2,1)*(1-y)+v(3,1)*y+v(4,1)*-y;
R(1,2)=v(1,1)*(x-1)+v(2,1)*(-x)+v(3,1)*x+v(4,1)*(1-x);
R(2,1)=v(1,2)*(y-1)+v(2,2)*(1-y)+v(3,2)*y+v(4,2)*-y;
R(2,2)=v(1,2)*(x-1)+v(2,2)*(-x)+v(3,2)*x+v(4,2)*(1-x);
 
 


