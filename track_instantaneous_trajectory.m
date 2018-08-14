%%  This file read particle to show instantaneous trajectory
figure(1);
for e=1:1:30
    i=1;
    set(gcf,'outerposition',get(0,'screensize'));
    e=randi([1 number]);
    e=121;
    matrixsize=size(particle{e});
    matrixsize=matrixsize(1);
    %%
    time=particle{e}(:,1);
    xp=100*particle{e}(:,3);
    yp=100*particle{e}(:,4);
    zp=100*particle{e}(:,5);
    subplot(3,1,1)
    plot3(zp, xp,yp,'LineWidth',0.5);
    xlabel('x')
    ylabel('z')
    zlabel('y')
    axis equal
    xlim([-60 60])
    ylim([-160 160])
    zlim([0 25])
    view(-50,10);
    title('spatial position history');
    suptitle(['This the history of Particle ID=' num2str(e) ]);
    for j=1:5:matrixsize
        %     if rem(j,500)==0
        %         j
        %     end
        subplot(3,1,2)
        plot3(zp(j), xp(j),yp(j),'Marker','o','Color','blue','MarkerSize',1);
        xlabel('x')
        ylabel('z')
        zlabel('y')
        axis equal
        xlim([-60 60])
        ylim([-160 160])
        zlim([0 25])
        view(-50,10);
        view(-90,90);
        hold on;
        %%
        subplot(3,1,3)
        plot(time(1:j),yp(1:j),'r');
        % xlim([0 35])
        ylim([0 22])
        title('xposition history');
        xlabel('time (s)')
        ylabel('xposition')
        hold on;
        pause(0)
        %  M(i)=getframe(gcf);
        i=i+1;
    end
end

% movie2avi(M,'E:\desktop\temp\single_light_history.avi','FPS',50,'quality',100)
