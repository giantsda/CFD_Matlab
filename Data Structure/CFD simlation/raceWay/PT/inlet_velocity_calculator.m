%% this file calculate the inlet velocity (m/s) bu given area, volume
% this file is to calculate the inlet velocity to meet the requirement that
% 1 cultural volumn per minute
x=50; % x is the length in mm;
y=50;
z=12.5;
r=5.6%4.35/2;
v=x*y*z/1000000000;  %convert mm3 to m3
v=500/1000000;
% inlet_velocity=0.005;
a=pi*(r/1000)^2;
a=5/1000*7/1000;
inlet_velocity=1*v/a/60     % unit: m/s; rpm=52.36 water level = 238
% a=v/60/inlet_velocity;
% r=(a/pi)^0.5*1000