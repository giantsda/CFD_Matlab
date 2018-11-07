
[vertex face]=Plot_VTK_mesh('filter_cross_section.vtk');
[a b]=hist (vertex(:,2),100);
A=[a;b].';
trim=[];
for i=1:length(A)
    if A(i,1)==0
        trim=[trim i];
    end
end
A(trim,:)=[];
filter_depth=max(A(:,2));
close all;
figure;
set(gcf,'outerposition',get(0,'screensize'));
%% trim face
trim=[];
for i=1:length(face)
    if  sum(vertex(face(i,2:face(i,1)+1),2))/face(i,1)<=filter_depth
        trim=[trim i];
    end
end
face(trim,:)=[];


start=face(1,1);
last=face(end,1);
num=zeros(2,last);
d=find(diff(face(:,1))~=0)+1;
num(1,start+1:last)=d;
for i=start:last-1
    num(2,i)=num(1,i+1)-1;
end
num(1,start)=1;
num(2,last)=length(face);
for i=start:last
    patch('Faces',face(num(1,i):num(2,i),2:1+i),'Vertices',vertex,'FaceColor','none')
end
view(-195,-43);
% lighting phong;
% camproj('perspective');
axis square;
axis tight;
% axis equal;
camlight;
hold on;
%% 
pos=[];
for e=1:length(particle)
    for i=1:length(particle{e})
        if particle{e}(i,4)<=filter_depth
            break;
        end
    end
    if i~=length(particle{e})
         pos=[pos ;particle{e}(i,:)];
    end
% % pause( 0);    
end
   
scatter3(pos(:,3),pos(:,4),pos(:,5),200,'.');
hold on;
view(-180,-0);
xlabel('x');
ylabel('y');
zlabel('z');
set(gcf,'color','w');