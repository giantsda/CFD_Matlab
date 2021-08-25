% MainPath='D:\CFD_second_HHD\02212020\130\1';
% % load  ('D:\CFD_second_HHD\PT29\particle.mat')
% cd (MainPath);
% caseN=1
% Data={};
% LDlocation=[];
%
%
% xmin=10000;
% ymin=10000;
% xmax=-10000;
% ymax=-10000;
% for e=1:length(particle)/5
%     xminI=min(particle{e}(:,3)) ;
%     xmaxI=max(particle{e}(:,3)) ;
%     yminI=min(particle{e}(:,5)) ;
%     ymaxI=max(particle{e}(:,5)) ;
%     if xminI<=xmin
%         xmin=xminI;
%     end
%     if yminI<=ymin
%         ymin=yminI;
%     end
%     if xmaxI>=xmax
%         xmax=xmaxI;
%     end
%     if ymaxI>=ymax
%         ymax=ymaxI;
%     end
% end
%
%
%
% %%
% time=particle{1}(:,1);
% time=double(time);
% for e=1:3000%length(particle)
%     e
%     criticalLightIntensity=500;
%     p=particle{e};
%     if size(p,1)~=length(time)
%         continue;
%     end
%     x_pos=particle{e}(:,3);
%     y_pos=particle{e}(:,4);
%     z_pos=particle{e}(:,5);
%
%     timeInterpolate=[min(time):0.01:max(time)].';
%     x_posInterpolate = interp1(time,x_pos,timeInterpolate,'spline');
%     y_posInterpolate = interp1(time,y_pos,timeInterpolate,'spline');
%     z_posInterpolate = interp1(time,z_pos,timeInterpolate,'spline');
%     light_history=1./exp(40*(0.2-y_posInterpolate))*2000;
%
%     above=find(light_history>=criticalLightIntensity);
%     out=zeros(length(above),7);
%
%     if ~isempty(out)
%         j=1;
%         for i=2:length(above)
%             if above(i,1)-above(i-1,1)~=1
%                 out(j,1)=i;
%                 j=j+1;
%             end
%         end
%         out(j:end,:)=[];
%         out(:,2)= [(out(2:end,1)-1); length(above)];
%         out(:,3:4)=above(out(:,1:2));
%         out(:,5:6)=timeInterpolate(out(:,3:4));
%     end
%     LDlocation=[LDlocation; x_posInterpolate(out(:,3)) z_posInterpolate(out(:,3)) ];
%     LDlocation=[LDlocation; x_posInterpolate(out(:,4)) z_posInterpolate(out(:,4)) ];
%
%     %     scatter(LDlocation(:,1),LDlocation(:,2),0.1)
%     %     axis equal;
% end



yresolution=100;
yMesh=linspace(ymin,ymax,yresolution);
dy=(ymax-ymin)/yresolution;
xMesh= xmin:dy:xmax;

%% convert scatter plot to grid plot

radius=(ymax-ymin)/2;
leftPoint=xmin;

D=zeros(length(xMesh),length(yMesh));
originX=leftPoint+radius;
E=D;
for i=1:length(xMesh)
    i/length(xMesh)*100
    xx=xMesh(i);
    for j=1:length(yMesh)
        yy=yMesh(j);
        C=abs(LDlocation(:,1:2)-[xx yy]);
        C(:,3)=sqrt(C(:,1).^2+C(:,2).^2);
        %         minDistance=min(C(:,3));
        n=length(find(C(:,3)<=dy));
        D(i,j)=D(i,j)+n;
        E(i,j)=E(i,j)+n;
        if ((xx-originX)^2+yy^2>=radius^2 && xx<=originX)
            E(i,j)=-100;
            E(length(xMesh)-i+1,j)=-100;
        end
    end
end

E(E>400)=400
imshow(fliplr(rot90(E)),[]);
axis equal;
colormap('jet');
colorbar;
% hold on;
% scatter(LDlocation(:,1),LDlocation(:,2),1)
