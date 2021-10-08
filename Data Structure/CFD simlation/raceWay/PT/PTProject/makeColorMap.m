pcolor(X,Y,D.');
shading interp;
axis equal
colormap jet
c=colorbar('south')
axis equal;
title(num2str(caseI));
caxis([0 8]);
axis off
 
x1=get(gca,'position');
x=get(c,'Position');
x(2)=0.03;
set(c,'Position',x)
set(gca,'position',x1)
print(gcf,['C:\Users\Chen\Documents\GitHub\Papers\PT\Figures\colorBar2.png'],'-dpng','-r400');







