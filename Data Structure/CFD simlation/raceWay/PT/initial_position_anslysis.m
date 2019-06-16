ini_pos=[];
for i=1:number_m
    ini_pos(i,:)=particle{i}(1,:);
end
ini_pos(:,3:5)=ini_pos(:,3:5)*100;
scatter3(ini_pos(:,5),ini_pos(:,3),ini_pos(:,4),10,'filled')
% haha=find(ini_pos(:,3)>-20 & ini_pos(:,3)<20 & ini_pos(:,5)>20 & ini_pos(:,5)<50 )
% haha_size=size(haha);
% haha_size=haha_size(1);
% ini_pos2=[];
% for i=1:haha_size
%     ini_pos2(i,:)=particle{haha(i)}(1,:);
% end
% ini_pos2=100*ini_pos2;
% scatter3(ini_pos2(:,5),ini_pos2(:,3),ini_pos2(:,4),10,'filled')
xlabel('x')
ylabel('z')
zlabel('y')
axis equal
xlim([-60 60])
ylim([-160 160])
zlim([0 25])
view(-50,10);
% title('Initial position of injected particles','FontSize',20)