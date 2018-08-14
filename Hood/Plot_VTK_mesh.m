% function Plot_VTK_mesh(filename)

filename='filter_coarse.vtk';
fid = fopen(filename,'r');
if( fid==-1 )
    error('Can''t open the file.');
    return;
end

str = fgets(fid);   % -1 if eof
if ~strcmp(str(3:5), 'vtk')
    error('The file is not a valid VTK one.');
end
%%% read header %%%
str = fgets(fid);
str = fgets(fid);
str = fgets(fid);
str = fgets(fid);
n_point = sscanf(str,'%*s %d %*s', 1);
% read vertices
[A,cnt] = fscanf(fid,'%f', 3*n_point);
if cnt~=3*n_point
    warning('Problem in reading vertices.');
end
A = reshape(A, 3, cnt/3);
vertex = A.';
% read polygons
str = fgets(fid);
str = fgets(fid);

info = sscanf(str,'%c %*s %*s', 1);
if((info ~= 'P') && (info ~= 'V'))
    str = fgets(fid);
    info = sscanf(str,'%c %*s %*s', 1);
end
if(info ~= 'P')
    face_4 = 0;
end
if(info == 'P')
    [nface]= sscanf(str,'%*s %d %d');
    [A,cnt] = fscanf(fid,'%d', nface(2));
end
face_4=zeros(nface(1),5);
line=1;
for  i=1:length(face_4)
    face_4(i,1:A(line)+1)=A(line:line+A(line));
    line=line+A(line)+1;
end
face_4=sortrows(face_4,1);
for i=1:length(face_4)
    if (face_4(i,1)==4)
        break;
    end
end
if (i~=1)
    face_3=face_4(1:i-1,:);
    face_4(1:i-1,:)=[];
end

face_3(:,1)=[];
face_3(:,end)=[];
face_3=face_3+1; % VTK is 0 based;
face_4(:,1)=[];
face_4=face_4+1; % VTK is 0 based;
fclose(fid);

%% plot
patch('Faces',face_4,'Vertices',vertex,'FaceColor','none')
hold on;
patch('Faces',face_3,'Vertices',vertex,'FaceColor','none')
view(0,0);
lighting phong;
camproj('perspective');
axis square;
axis tight;
axis equal;
camlight;



