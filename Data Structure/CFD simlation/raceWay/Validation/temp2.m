figure;
subplot(3,1,1)
pcolor(y1,z1,meanVelocityLES)
shading interp;
axis equal;
axis tight;
colormap parula
colorbar

% caxis([0.07 0.68]);
hold on;
scatter(reshape(y1,1,[]),reshape(z1,1,[]),66,'*')


 
subplot(3,1,2)
 

 
subplot(3,1,3)
 


print(gcf,'C:\Users\chenshen.ETS01297\Desktop\temp\openFoam.png','-dpng','-r600');


