function solution_write_vtk(cell,vertices_location,Uj)
fileID = fopen('solution.vtk','w');
fprintf(fileID,'# vtk DataFile Version 3.0 \n# this \n');
fprintf(fileID,'ASCII \nDATASET UNSTRUCTURED_GRID\n\n');
a=64;
fprintf(fileID,'POINTS %d double\n',size(cell,1)*4);
cell_i=reshape(cell.',[],1);
for i=1:size(cell_i)
    position=vertices_location(cell_i(i),:);
    fprintf(fileID,'%f %f 0\n',position(1),position(2));
end
fprintf(fileID,'\nCELLS %d %d\n',size(cell,1),size(cell,1)*(size(cell,2)+1));
k=0;
for i=1:size(cell,1)
    fprintf(fileID,'%d',size(cell,2));
    for j=1:size(cell,2)
        fprintf(fileID,'\t%d',k);
        k=k+1;
    end
    fprintf(fileID,'\n');
end
fprintf(fileID,'\nCELL_TYPES %d\n ',size(cell,1));
for i=1:size(cell,1)
    fprintf(fileID,'9 ');
end
fprintf(fileID,'\nPOINT_DATA %d\n',length(cell_i));
fprintf(fileID,'SCALARS solution double 1\n');
fprintf(fileID,'LOOKUP_TABLE default\n');
for i=1:size(cell_i)
    fprintf(fileID,'%f ',Uj(cell_i(i)));
end

fclose(fileID);