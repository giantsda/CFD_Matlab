function combine_T_C
iteration=1000;
t=linspace(0,10 ,iteration); %generate time vector
E=[]; %initialize
X=[]; %initialize
ca0=2;
k=0.3;
for i=1:1:iteration  %get E(t)
    if t(i)<1
        E(i)=0;
    elseif t(i)>=1 && t(i)<=2
            E(i)=1;
        else 
            E(i)=0;
    end
end
for i=1:1:iteration  %calcuate every X(i)
    if E(i)==0
      ca(i)=ca0;
    else
        Y=get_ca;
        ca(i)=Y(end);%ca0*exp(-k*E(i)); 
    end
end
total_X_store=[0]
X=(ca0-ca)/ca0;
figure;
tspan=linspace(0,1,1000);
plot(tspan,Y(:,1));
title('Temperature vs time')
figure;
plot(tspan,Y(:,2));
title('Concentration vs time')
for i=2:1:iteration   %integrate to get X(t)
total_X=trapz(t(1:i),X(1:i));
total_X_store=[total_X_store total_X];
end
figure
plot(t,total_X_store*100)
title('conversion\_versus\_time\_segregated')
xlabel('time(s)')
ylabel('convection (%)')
end
function Y= get_ca
tspan=linspace(0,1,1000);
x0=[305;2];
[tsol,Y] = ode45(@ode_sys,tspan,x0);
end
function dydt=ode_sys(t,x)
T=x(1);
ca=x(2);
k=0.5*exp(20000*(1/300-1/T));
dTdt=40000/25000*k*ca^3;
dcadt=-k*ca^3;
dydt=[dTdt;dcadt];
end