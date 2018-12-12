%% gegenerate mesh
cell_per_edge=50;
left_bottom=[0 0];
right_top=[1 1];
vertices=zeros(cell_per_edge+1);
k=1;
for i=1:cell_per_edge+1
    for j=1:cell_per_edge+1
        vertices(i,j)=k;
        k=k+1;
    end
end
cell=zeros(cell_per_edge*cell_per_edge,4);
k=1;
for i=1:cell_per_edge 
    for j=1:cell_per_edge
        m4=transpose(vertices(i:i+1,j:j+1));
        cell(k,:)=m4(:).';
        k=k+1;
    end
end
cell(:,[3 4])=cell(:,[4 3]);
vertices_location=zeros((cell_per_edge+1)*(cell_per_edge+1),2);
x_v=linspace(0,1,cell_per_edge+1);
y_v=linspace(0,1,cell_per_edge+1);
k=1;
for j=1:cell_per_edge+1
    for i=1:cell_per_edge+1
        vertices_location(k,:)=[x_v(i) y_v(j)];
        k=k+1;
    end
end
plot_mesh(cell,vertices_location)

%% get A
local_matrix=get_local_matrix(cell,vertices_location);
% A= sparse((cell_per_edge+1)^2,(cell_per_edge+1)^2);
A= zeros((cell_per_edge+1)^2,(cell_per_edge+1)^2);
for i=1:length(local_matrix)
    A(local_matrix(i,1),local_matrix(i,2))= A(local_matrix(i,1),local_matrix(i,2))...
    +local_matrix(i,6);
end

%% get rhs
rhs_local_matrix=get_rhs(cell,vertices_location);
% rhs= sparse((cell_per_edge+1)^2,1);
rhs= zeros((cell_per_edge+1)^2,1);
for i=1:length(rhs_local_matrix)
    rhs(rhs_local_matrix(i,1))= rhs(rhs_local_matrix(i,1))+rhs_local_matrix(i,4);
end


%% apply BC
% find boudary
boundary=[];
for i=1:size(vertices,1)
    for j=1:size(vertices,2)
        tag1=0;
        tag2=0;
        if i==1||i==size(vertices,1)
            tag1=1;
        end
        if j==1||j==size(vertices,2)
            tag2=1;
        end
        if tag1||tag2
            boundary=[boundary vertices(i,j)];
        end 
    end
end
boundary
for i=1:length(boundary)
    a=boundary(i);
    A(a,:)=0;
   A(:,a)=0;
   A(a,a)=1;
   rhs(a)=0;
end
Uj=A\rhs;
solution_write_vtk(cell,vertices_location,Uj)
plot_solution(cell_per_edge,Uj)
 



