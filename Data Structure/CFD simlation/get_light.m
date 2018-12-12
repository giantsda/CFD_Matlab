%% this file calculate light intensity by given x and y if the bottle is inclined
function light=get_light(x3,y3,sita)
%%
% (x1,y1) and (x2,y2) is the position of two points which can determine a
% line (x3,y3) is the position of the particle, this function will calculate the distance of the
% point to the line. sita is the rotation degree in degree. length units in
% this function is cm;
sita=sita/180*pi; % convert sita to rad
x1=2.41*cos(sita);
y1=2.41*sin(sita);
x2=2.41*cos(sita)-7.68*sin(sita);
y2=2.41*sin(sita)+7.68*cos(sita);
% x1=4
% y1=2;
% x2=2
% y2=4
a=x2-x1;
b=y2-y1;
c=x3*x2-x3*x1+y3*y2-y3*y1;
d=y2-y1;
e=x1-x2;
f=y2*x1-y1*x2;
intersectionx=(c*e-b*f)/(a*e-b*d);
intersectiony=(c*d-a*f)/(b*d-a*e);
distanc=sqrt((intersectionx-x3)^2+(intersectiony-y3)^2);
light=1.2/(exp(3*(distanc)));