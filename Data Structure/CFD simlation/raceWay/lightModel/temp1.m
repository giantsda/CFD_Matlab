% Im=20;
% Pm=0.7;
% I=linspace(0,100,1000);
%
% P=Pm.*I./(Im.*exp(1-I./Im));
% N=Pm./(Im)
% plot(I,P)


% I=linspace(0,100,10000);
% a=0.01;
% b=0.2;
% c=0.3;
% p=I./(a.*I.*I+b.*I+c)
% plot(I,p)

% function temp1
% 
% 
% t=linspace(0,110.5,1000);
% IC=0;
% [t,x]=ode45(@myode,t,IC);
% 
% plot(t,x)
% 
%     function dipdt=myode(t,ip)
%         Ip=5*sin(2*t)+5;
%         tau=0.2;
%         K=1;
%         dipdt=1/tau*(K*Ip-ip);
%     end
% 
% end
% 
% 
% 
syms x y;


a=[x;y]
 