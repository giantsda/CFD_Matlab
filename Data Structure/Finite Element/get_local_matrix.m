function local_matrix=get_local_matrix(cell,vertices_location)
% local_matrix format:
% 1 2                    3                      4                           5          6
% i  j   location_index_i location_index_j  cell_number value
local_matrix=zeros(4*4*length(cell),6);
kk=1;
for ii=1:length(cell)
    vertice=cell(ii,:);
    local_matrix_i=zeros(4*4,6);
    k=1;
    for i=1:4
        for j=1:4
            local_matrix_i(k,1:5)=[vertice(i) vertice(j) i j ii];
            k=k+1;
        end
    end
    local_matrix(kk:kk+15,:)=local_matrix_i;
    kk=kk+16;
end

%%
for i=1:length(local_matrix)
     vertice=cell(local_matrix(i,5),:);
     v=vertices_location(vertice,:);
    integra=gauss_q_Aij(v,local_matrix(i,:));
    local_matrix(i,6)=integra;
end



