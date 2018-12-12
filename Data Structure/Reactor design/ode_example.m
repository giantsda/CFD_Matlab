function  ode_example (ca0)
ca0=0;y0=0;t=linspace (0,400,200000); 
[ts,cs]=ode45(@my_ode_hw4, t, y0,[]);
plot(ts,cs,'--');hold on;y0=1;
t=linspace (0,400,200000); 
[ts,cs]=ode45(@my_ode_hw4, t, y0,[]);
plot(ts,cs,'-');cs_atss=cs(end);
title(['ca at ss state is ',num2str(cs_atss)]);
ylabel('ca');xlabel('time(min)');legend('ca0=0','ca0=1');
end
function [dcadt] = my_ode_hw4 (t,ca)
dcadt=1/119*(1-ca)-0.02*ca;
end

