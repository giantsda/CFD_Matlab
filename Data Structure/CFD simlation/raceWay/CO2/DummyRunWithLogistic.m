lightIntensity =[ 0, 250, 375, 500, 625, 750, 1000, 1250, 1500, 2000 ];
growthRate =[ 0, 210, 290, 350, 400, 420, 450, 460, 460, 460 ];
PHData =[ 0, 1, 2, 3, 4, 4.500, 5, 5.500, 6, 6.370, 6.500, 7, 7.500, 7.600, 8, 8.380,    8.500, 9, 9.050, 9.500, 10, 10.30, 10.50, 11, 11.50, 12, 13, 14 ]; HCO3mData =[ 0, 0, 0, 0, 0, 0.02000, 0.05000, 0.1350, 0.3000, 0.5000, 0.6000, 0.8100,    0.9300, 0.9500, 0.9700, 0.9760, 0.9700, 0.9630, 0.9620, 0.8900, 0.6700,    0.5000, 0.4000, 0.1800, 0.05000, 0, 0, 0 ];
CO2Data =[ 1, 1, 1, 1, 1, 0.9800, 0.9500, 0.8650, 0.7000, 0.5000, 0.4000, 0.1900,    0.07000, 0.05000, 0.02000, 0.01200, 0.01000, 0.002000, 0, 0, 0, 0, 0, 0,    0, 0, 0, 0 ];
CO32mData =[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.01000, 0.01200, 0.02000,    0.03500, 0.03800, 0.1100, 0.3300, 0.5000, 0.6000, 0.8200, 0.9500, 1,    1, 1 ];
PHforEfficiency =[ 0, 6.500, 6.550, 6.600, 6.650, 6.700, 6.750, 6.800, 6.850, 6.900, 6.950, 7,    7.050, 7.100, 7.150, 7.200, 7.250, 7.300, 7.350, 7.400, 7.450, 7.500,    7.550, 7.600, 7.650, 7.700, 7.750, 7.800, 7.850, 7.900, 7.950, 8, 8.050,    8.100, 8.150, 8.200, 8.250, 8.300, 8.350, 8.400, 8.450, 8.500, 100 ];
Pefficiency =[ 0, 0, 1.25737682214811e-05, 3.99593527672633e-05, 0.000119296591353013,    0.000334575564412215, 0.000881489205918614, 0.00218170673761439,    0.00507262014324939, 0.0110796210298451, 0.0227339062539777,    0.0438207512339213, 0.0793491295891684, 0.134977416282970,    0.215693297066280, 0.323793989164730, 0.456622713472555,    0.604926811297858, 0.752843580387010, 0.880163316910750,    0.966670292007123, 0.997355701003582, 0.966670292007123,    0.880163316910750, 0.752843580387010, 0.604926811297858,    0.456622713472555, 0.323793989164730, 0.215693297066280,    0.134977416282970, 0.0793491295891684, 0.0438207512339213,    0.0227339062539774, 0.0110796210298451, 0.00507262014324939,    0.00218170673761443, 0.000881489205918614, 0.000334575564412209,    0.000119296591353013, 3.99593527672633e-05, 1.25737682214813e-05, 0, 0 ];

data=[0,0.0664580000000000;1284,0.113740000000000;2743,0.221511000000000;4150,0.311774500000000;5548,0.360983500000000;7070,0.392943500000000];


K0=0.417903512646799;
X0=5.178181776638869e-05;% some constant to convert O2 revolution to biomass increase
parameters0=[K0,X0];
options = optimset('PlotFcns','optimplotfval','TolX',1e-9);
x = fminsearch(@getdiff,parameters0,options)

span=linspace(0,7070,200);
umax=x(1);
K=x(2); 
N0=0.066;
[t,N] = ode15s(@ode, span, N0,[],[umax,K]);
 
plot(t,N);
hold on;
xlabel('time(min)');
ylabel('biomass (mg/L)')

plot(data(:,1),data(:,2),'*-');
plot(t,N,'o-') 

growthRate = diff(N(:))./diff(t(:));
plot(growthRate);
 
function r=ode(t,N,x)
K=x(1);
X=x(2);
maxLightIntensity = 1500;
depth=linspace(0,0.15,100); %m
Biomass=N;
DecayConstant=147.45*Biomass-6.3909;
I = 1./ exp(DecayConstant*(depth)) *maxLightIntensity; 
r=trapz(depth,I)*Biomass*X;
r=r*(K-N)/K*N;
end

function difference=getdiff(X)
data=[0,0.0664580000000000;1284,0.113740000000000;2743,0.221511000000000;4150,0.311774500000000;5548,0.360983500000000;7070,0.392943500000000];
span=linspace(0,7070,200);
N0=0.066;
[t,N] = ode15s(@ode, span, N0,[],X);
vq = interp1(t,N,data(:,1),'spline');
difference=sum(abs(vq-data(:,2)));
end
