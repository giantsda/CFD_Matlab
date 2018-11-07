function [vertex face]= Plot_VTK_mesh(filename)

% filename='wall-filter_0.vtk';
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
    face = 0;
end
if(info == 'P')
    [nface]= sscanf(str,'%*s %d %d');
    [A,cnt] = fscanf(fid,'%d', nface(2));
end
face=zeros(nface(1),5);
line=1;
for  i=1:length(face)
    face(i,1:A(line)+1)=A(line:line+A(line));
    line=line+A(line)+1;
end
face=sortrows(face,1);

face(:,2:end)=face(:,2:end)+1; %VTK is 0 based
start=face(1,1);
last=face(end,1);
number=zeros(2,last);
d=find(diff(face(:,1))~=0)+1;
number(1,start+1:last)=d;
for i=start:last-1
    number(2,i)=number(1,i+1)-1;
end
number(1,start)=1;
number(2,last)=length(face);
fclose(fid);

% %% plot
% for i=start:last
%     patch('Faces',face(number(1,i):number(2,i),2:1+i),'Vertices',vertex,'FaceColor','none')
% end
% view(0,0);
% lighting phong;
% camproj('perspective');
% axis square;
% axis tight;
% axis equal;
% camlight;


for i=start:last
    h=patch('Faces',face(number(1,i):number(2,i),2:1+i),'Vertices',vertex,'FaceColor','none','EdgeColor','b');
    alpha(0.22)
    light
    h.FaceLighting = 'gouraud';
    hold on;
end
lighting gouraud;
view(180,-44);
camproj('perspective');
axis square;
axis tight;
axis equal;
 