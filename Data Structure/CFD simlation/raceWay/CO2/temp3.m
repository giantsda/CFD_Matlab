% a=1;
% b=1.9984e-4;
% N0=linspace(1,100000,10000);
% c=1.1111e-5./N0-1.1777e-7./N0;
% delta=sqrt(b*b-4*a.*c);
% plot(N0,(-b+delta)./2./a)

% u=linspace(-10,10,1000);
% y=u.^4-8.*u.^2;
% y2=-u.^2+sqrt(y)
% % plot(u,y);
% hold on;
% plot(u,y2)
% plot(u,zeros(1,length(u)))


% a=1;
% b=3
%
% c=4
% delta=sqrt(b*b-4*a.*c)
% (-b+delta)./2./a
% (-b-delta)./2./a
% plot(N0,(-b+delta)./2./a)


% x1=-0.198394
% x2=-0.181394
% y1=-0.1272
% y2=-0.107
% z1=0;
% z2=0.01;
dx=0.015
dy=0.02;
dz=0.01;
x1=0.0615
y1=-0.1324
z1=0;
x2=x1+dx;
y2=y1+dy;
z2=z1+dz;
fprintf("box (%1.6f %1.6f %1.6f) (%1.6f %1.6f %1.6f);\n\n",x1,y1,z1,x2,y2,z2);








