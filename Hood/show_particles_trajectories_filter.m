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
for i=1:length(face_4)
    if  sum(vertex(face_4(i,:),2))/4<=filter_depth
        trim=[trim i];
    end
end
face_4(trim,:)=[];
trim=[];
for i=1:length(face_3)
    if  sum(vertex(face_3(i,:),2))/3<=filter_depth
        trim=[trim i];
    end
end
face_3(trim,:)=[];


patch('Faces',face_4,'Vertices',vertex,'FaceColor','none')
hold on;
patch('Faces',face_3,'Vertices',vertex,'FaceColor','none')
view(-195,-43);
% lighting phong;
% camproj('perspective');
axis square;
axis tight;
% axis equal;
camlight;

pos=[];

for e=1:length(particle)
 
    for i=1:length(particle{e})
        if particle{e}(i,4)<=filter_depth
            break;
        end
    end
    if i~=length(particle{e})
%         plot3(particle{e}(1:i,3),particle{e}(1:i,4),particle{e}(1:i,5));
 
        pos=[pos ;particle{e}(i,:)];
    end
% % pause( 0);    
end
%  
scatter3(pos(:,3),pos(:,4),pos(:,5),300,'.');
hold on;
view(-180,-0);
xlabel('x');
ylabel('y');
zlabel('z');