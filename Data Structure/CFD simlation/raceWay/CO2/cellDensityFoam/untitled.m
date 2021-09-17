% maxLightIntensity = 1500;
% depth=linspace(0,0.15,10000); %m
% Biomass=linspace(0,1,10000);
% 
% rate=[];
% 
% for i=1:length(Biomass)
% DecayConstant=147.45.*Biomass(i)-6.3909;
% I = 1./ exp(DecayConstant.*(depth)) *maxLightIntensity; 
% r=trapz(depth,I)*Biomass(i);
% rate(i)=r*3e-5;
% end
% plot(Biomass,rate)

 

span=linspace(0,7070,200);
 
N0=[0.113740000000000];
[t,N] = ode15s(@ode, span, N0,[],5e-3);

data=[0,0.0664580000000000;1284,0.113740000000000;2743,0.221511000000000;4150,0.311774500000000;5548,0.360983500000000;7070,0.392943500000000;11369,0.339868593000000];
span=linspace(0,11369,1000);
plot(data(:,1)-1284,data(:,2),'*-');
hold on;
b=[0.08165 0.1284 0.2005 0.285 0.550925 1.410475 1.612775 3.047 3.4345 3.6835 4.0405 4.131 4.344 ]*0.235;
Time=[0 0.941666666666667 1.86597222222222 2.78680555555556 4.01597222222222 6.91250000001157 7.91250000001157 8.88125000001157 9.98055555555556 10.7930555555556 13.8194444444444 14.7944444444444 15.9291666666667]*24*60;
plot(t,N,'o-')
plot(Time,b,'*-');
xlabel('Time(min)')
ylabel('biomass(g/L)')


function r=ode(t,N,x)
maxLightIntensity = 1500;
depth=linspace(0,0.15,100); %m
Biomass=N;
DecayConstant=147.45*Biomass-6.3909;
I = 1./ exp(DecayConstant*(depth)) *maxLightIntensity; 
r=trapz(depth,tanh(I/505.3))*Biomass*x;
end
