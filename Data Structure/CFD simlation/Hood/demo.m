figure;
set(gcf,'outerposition',get(0,'screensize'));

% load('E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10212016\29\particle')
raceway='E:\desktop\temp\raceway_wall\VTK\wall\wall_0.vtk';
flatPBR='E:\desktop\temp\flatPBR.vtk';
lightBulb='E:\desktop\temp\lightBulb.vtk';
ax1=subplot(2,20,[1:16])
Plot_VTK_mesh(raceway,[0 88/256 104/256]);
view(ax1,[-180 -78])
axis off
ax3=subplot (2,20,[17,18]);
Plot_VTK_mesh(flatPBR,[0 1 0]);
view(ax3,[-173 12])
axis off


e=2095;
t=700;
p=particle{e};
xp=p(1:t,3);
yp=p(1:t,4);
zp=p(1:t,5);
plot3(ax1,xp,yp,zp,'r');
ax2=subplot(2,20,[21:40])
plot(ax2,p(1:t,1)-p(1,1),yp,'k');
ylim([0 0.22])
t1=xlabel('simulation time (second)');
t2=ylabel('distance to bottom (meter)')
set(t1,'FontSize',28);
set(t2,'FontSize',28);
pause();
hold on;
for i=1:1:t
    h1= scatter3(ax1,xp(i),yp(i),zp(i),80,[0 1 0],'filled');
    h2= scatter(ax2,p(i,1)-p(1,1),yp(i),80,[0 1 0],'filled');
    ax4=subplot (2,20,[19:20]);
    if yp(i)>=0.2
        color=1;
    else
        color=1/exp(40*(0.2-yp(i)));
    end
    PlotLightBullb(lightBulb,color*0.8+0.2);
    axis off
%     saveas(gcf,['E:\desktop\temp\lightEnvironment\' num2str(i) '.png']);
    pause(0)
    delete(h1);
    delete(h2);
    delete(ax4);
end

