DCO2=1.91e-9; %m2/s
kL=0.000036; %m/s
thickness=DCO2/kL;
PHAtFilm=12;
H=10.^(-PHAtFilm); % [H] mol/L
OH=1e-14./H; % [OH] mol/L
T=20+273;
k=10^(13.635-(2895/T));% L/mol/s from <<THE KINETICS OF COMBINATION OF CARBON DIOXIDEWITH HYDROXIDE IONS>>
kPhoto=0.1319; % s-1
Ha=sqrt((k.*OH+kPhoto)*DCO2)/kL;
Cs=1.3332e-5; % mol/L
span=[0 1];
y0=[1,-8.9585];
% [t,y] = ode45(@Hatta, [0:0.0001:1], y0);
% g0 = [-0.5];
% x = fminsearch(@getgradient,g0)
 
[t,y] = ode45(@Hatta, [0:0.0001:1], y0);

x=t*thickness;
Ca=y(:,1)*1.3332e-5;
plot(t,y(:,1));
% plot(x,Ca)
% DCO2*(Ca(end-1)-Ca(end))/(x(end-1)-x(end))/(k1*Ca(end)*0.2)

 
% y(1,2)*1.3332e-5/thickness %first drivative in real system mol/L/m

 kL*1.3332e-5*Ha/tanh(Ha)*1000 %mol/m2/s
 kL*1.3332e-5*Ha/tanh(Ha)*1000/DCO2/1000*thickness/1.3332e-5 %317 mol/m3/m

z=linspace(0,1,1000);
solution=0.5*sinh(Ha*z)+sinh(Ha.*(1 - z))./sinh(Ha)

plot(z,solution)


function difference=getgradient(g)
y0=[1,g];
[t,y] = ode45(@Hatta, [0:0.0001:1], y0);
difference=abs(y(end,2))
end


function r=Hatta(t,Y)
Ha=9.000; 
Y1=Y(1);
Y2=Y(2);
r(1,1)=Y2;
r(2,1)=Ha*Ha*Y1;
end
 