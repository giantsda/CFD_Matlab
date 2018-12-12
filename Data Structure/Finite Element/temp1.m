A= sparse((cell_per_edge+1)^2,(cell_per_edge+1)^2);
for i=1:length(local_matrix)
    A(local_matrix(i,1),local_matrix(i,2))= A(local_matrix(i,1),local_matrix(i,2))...
    +local_matrix(i,5);
end
 