iteration=10000;
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
        ca(i)=sqrt(1/(k*E(i)+ca0^-2));%ca0*exp(-k*E(i)); 
    end
end
total_X_store=[0]
X=(ca0-ca)/ca0;
for i=2:1:iteration   %integrate to get X(t)
total_X=trapz(t(1:i),X(1:i));
total_X_store=[total_X_store total_X];
end
plot(t,total_X_store*100)
title('conversion\_versus\_time\_segregated')
xlabel('time(s)')
ylabel('convection (%)')
