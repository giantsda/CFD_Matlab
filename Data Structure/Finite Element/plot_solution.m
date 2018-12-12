function plot_solution(cell_per_edge,Uj)
xv=linspace(0,1,cell_per_edge+1);
yv=xv;
[X Y]=meshgrid(xv,yv);
B = reshape(Uj,[cell_per_edge+1,cell_per_edge+1]).';
B=flipud(B);
surf(X,Y,B)