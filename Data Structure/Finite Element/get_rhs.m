function local_matrix=get_rhs(cell,vertices_location)
% local_matrix format:
% 1                   2                        3             4
% i     location_index_i   cell_number value
local_matrix=zeros(4*length(cell),4);
kk=1;
for ii=1:length(cell)
    vertice=cell(ii,:);
    local_matrix_i=zeros(4,4);
    for i=1:4
        local_matrix_i(i,1:3)=[vertice(i)  i ii];
    end
    local_matrix(kk:kk+3,:)=local_matrix_i;
    kk=kk+4;
end

%%
for i=1:length(local_matrix)
    vertice=cell(local_matrix(i,3),:);
    v=vertices_location(vertice,:);
    integra=gauss_q_rhs(v,local_matrix(i,:));
    local_matrix(i,4)=integra;
end



