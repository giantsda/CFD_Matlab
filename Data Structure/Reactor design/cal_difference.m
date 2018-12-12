function cal_difference
Ti=300:1:350;
X_max_mixed=[];
X_segregated=[];
for i= 1:1:51
    T=Ti(i);
 X_max_mixed(i)= max_mixed (T);
 X_segregated(i)= segregated(T);
 difference(i)= X_max_mixed(i)- X_segregated(i);
end
 plot(Ti,X_max_mixed,Ti,X_segregated);
 xlabel('Temperature')
 ylabel('Conversion (%)')
 legend('X of max\_mix', 'X of segregated')
 figure
 plot(Ti,difference);
 xlabel('Temperature')
 ylabel('difference(%)')
end
function X_max_mixed= max_mixed (T)
X_max_mixed=conversion_versus_time_maximum_mixedness(T);
function X_mix=conversion_versus_time_maximum_mixedness(T)
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
[tsol,ca] = ode15s(@ode,tspan,y0,[],p,T);
 tsol = flip(tsol); 
% plot(ca);
 X=(2-ca)/2*100;
%  plot(tsol,X)
%  xlabel('time(s)')
% ylabel('convection (%)')
% title('conversion\_versus\_time\_maximum\_mixedness')
X_mix=X(end);
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
function  dcdt=ode(t,ca,p,T)
 k=0.3*exp(20000*(1/300-1./T));
 caf=2;
ra=-k*ca^3;
F=get_F(t,p);
E=get_E(t);
dcdt=-ra+(ca-caf)*E/(1-F);
end
end
function X_segregated = segregated(T)
iteration=10000;
t=linspace(0,10 ,iteration); %generate time vector
E=[]; %initialize
X=[]; %initialize
ca0=2;
k=0.3*exp(20000*(1/300-1./T));
for i=1:1:iteration  %get E(t)
    if t(i)<1
        E(i)=0;
    elseif t(i)>=1 && t(i)<=2
            E(i)=1;
        else 
            E(i)=0;
    end
end
% ll=1;
for i=1:1:iteration  %calcuate every X(i)
    if E(i)==0
      ca(i)=ca0;
    else
        ca(i)=sqrt(1/(k*E(i)+ca0^-2));%ca0*exp(-k*E(i)); 
    end
end
total_X_store=[0];
X=(ca0-ca)/ca0;
for i=2:1:iteration   %integrate to get X(t)
total_X=trapz(t(1:i),X(1:i));
total_X_store=[total_X_store total_X];
end
% ll=1;
% plot(t,total_X_store*100)
% title('conversion\_versus\_time\_segregated')
% xlabel('time(s)')
% ylabel('convection (%)')
X_segregated=100*total_X_store(end);
end
