dt=0.01;
y0=2.7183;
t=0;
y=y0;
ts=[t];
ys=[y];
while(t<2)
    k1=dt*t*y;
    k2=dt*(t+0.5*dt)*(y+0.5*k1);
    k3=dt*(t+0.5*dt)*(y+0.5*k2);
    k4=dt*(t+dt)*(y+k3);
    ynp1=y+1/6*k1+1/3*k2+1/3*k3+1/6*k4
    t=t+dt;
    y=ynp1;
    ts=[ts t];
    ys=[ys y];
end

analytical=exp(ts.*ts./2+1);
plot(ts,ys);
hold on;
plot(ts,analytical,'-*')
