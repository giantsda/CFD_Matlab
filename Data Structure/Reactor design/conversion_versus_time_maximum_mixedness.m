function conversion_versus_time_maximum_mixedness
iteration=10000;
t=linspace(0,10 ,iteration); %generate time vector
E=[]; %initialize
X=[]; %initialize
F=[];
for i=1:1:iteration  %get E(t)
    if t(i)<1
        E(i)=0;
    elseif t(i)>=1 && t(i)<=2
            E(i)=1;
        else 
            E(i)=0;
       end
end
% plot(t,E)
for i=1:1:iteration
    if i==1
        F_i=0;
    else
    F_i=trapz(t(1:i),E(1:i));
   end
    F=[F F_i];
end
p = polyfit(t(1000:2000),F(1000:2000),1);
tspan=linspace(1.99,0,2000);
y0=2;
[tsol,ca] = ode15s(@ode,tspan,y0,[],p);
 tsol = flip(tsol); 
plot(ca);
 X=(2-ca)/2*100;
 plot(tsol,X)
 xlabel('time(s)')
ylabel('convection (%)')
title('conversion\_versus\_time\_maximum\_mixedness')
end

function F =get_F(t,p)
if t<1
    F=0;
elseif t>=1 && t<=2
        F=polyval(p,t);
    else
        F=1;
    end
end

function E =get_E(t )
     if t<1
   E=0;
  elseif t>=1 && t<=2
        E=1;
    else
        E=0;
    end
end 
function  dcdt=ode(t,ca,p)
k=0.3;
caf=2;
ra=-k*ca^3;
F=get_F(t,p);
E=get_E(t);
dcdt=-ra+(ca-caf)*E/(1-F);
end
