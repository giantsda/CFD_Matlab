% %% This file reads infomaton of particles to plot all the pathlines

% load ('C:\CFD_second_HHD\racewayOpenfoam\07272019\82\PT\particle1')
figure;
set(gcf,'outerposition',get(0,'screensize'));
% clear M;
i=1;
N=20;
for e=1:1:N
         e
    e=randi([1 number]);
    matrixsize=size(particle{e});
    matrixsize=matrixsize(1);
    if matrixsize ~=0
        time=particle{e}(:,1);
        xp=100*particle{e}(:,3);
        yp=100*particle{e}(:,4);
        %         yp=yp-23.8;
        zp=100*particle{e}(:,5);
        radiallength=sqrt(xp.^2+yp.^2);
        plot(time,radiallength);
        
        
%         plot3(zp,xp,yp,'LineWidth',0.5)
%         hold on;
        t1=  xlabel('Time (s)');
        t2=ylabel('Radial position (cm)');
%         t3=zlabel('Depth (cm)');
        
        axis equal
        %         xlim([-60 60])
        %         ylim([-160 160])
        %         zlim([0 25])
        %         xlim([-6 6])
        %         ylim([-5 5])
        %         zlim([0 15])
        %         view(-90,90);
        
        %         axis equal
        %         haha=3;
        %         xlim([-haha haha])
        %         ylim([-haha  haha])
        %         zlim([0-24  03])
        %         view(-50,10);
        
        % hold off;
        % t=title(['ParticleN=' num2str(nn)]);
%         set(t1,'FontSize',32);
%         set(t2,'FontSize',32);
%         set(t3,'FontSize',32);
%         set(gca,'FontSize',23);
        % set(t,'Fontname','Arial');
        % % set(gca,'Fontname','Arial');
        % set(get(gca,'YLabel'),'Fontsize',20)
        pause();
    end
    %  M(i)=getframe(gcf);
    i=i+1;
end
%  movie2avi(M,'E:\desktop\temp\2.avi','FPS',30,'quality',100)
% saveas(gcf,[num2str(nn) '.jpg']);

 