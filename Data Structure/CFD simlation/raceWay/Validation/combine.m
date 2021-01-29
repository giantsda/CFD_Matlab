figure;
subplot(3,1,1)
pcolor(y1,z1,meanVelocityLES)
shading interp;
axis equal;
axis tight;
colormap parula
% colorbar
hold on;
scatter(reshape(y1,1,[]),reshape(z1,1,[]),'*')


 
subplot(3,1,2)
pcolor(y1,z1,meanVelocityke)
shading interp;
axis equal;
axis tight;
colormap parula
% colorbar
hold on;
scatter(reshape(y1,1,[]),reshape(z1,1,[]),'*')


subplot(3,1,3)
pcolor(y1,z1,fliplr(velocity));
shading interp;
axis equal;
axis tight
colormap parula
colorbar;
hold on;
scatter(reshape(y1,1,[]),reshape(z1,1,[]),'*')
