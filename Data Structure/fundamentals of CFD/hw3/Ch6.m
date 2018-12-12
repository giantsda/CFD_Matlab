% x=linspace(0,8,2000);
% plot(sin(x),cos(x));
% hold on;
% s=[];
% for wh=0:0.1:1.5
%     wh
% syms sgm;
% lh=i*wh;
% eqn = sgm^2-(1+1.5*lh)*sgm+0.5*lh ==0;
% solx = double(solve(eqn,sgm));
% s=[s solx];
% end
% plot(s(1,:),'*');
%  plot(s(2,:),'o');
% axis equal;
% %
%



% syms x;
% s=[];
% for Re=0:0.1:1;
%     Re
%     im=-sqrt(1-Re^2);
%     sgm=Re+im*i;
%     eqn =  sgm-1-x-0.5*x^2-1/6*x^3-1/24*x^4==0;
%     solx = double(solve(eqn,x));
%     s=[s;solx];
%     plot( s,'*');
%     hold on;
%     pause(0);
% end
% plot( s,'*');
% axis equal;



 
%%
%  clear 
%  
%  mu=0.3;
%  i=1;
%  l=0.8;
%  for h=0:0.00000001:0.0001
%      muh=mu*h;
%      expr(i)=h*exp(muh)^(4/3) - (exp(muh)^(5/6) - exp(muh)^(11/6) + (h^2*l^2*exp(muh)^(5/6))/2 + (h^3*l^3*exp(muh)^(5/6))/6 + h*l*exp(muh)^(5/6))/(l - mu) + (h^3*l^2*exp(muh)^(5/6))/6 + (h^2*l*exp(muh)^(7/6))/2;
% i=i+1;
%  end
%  plot(expr)
%  
%  
% % clear
% % 
% % l=0.5;
% % mu=3;
% % h=0.0001;
% % (h*(l - mu))/(exp(h*mu)^(5/6) - exp(h*mu)^(11/6) + h*l*exp(h*mu)^(5/6) + (h^2*l^2*exp(h*mu)^(5/6))/2 + (h^3*l^3*exp(h*mu)^(5/6))/6)
  


















