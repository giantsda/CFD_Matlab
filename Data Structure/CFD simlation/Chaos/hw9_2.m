function hw9_2 %bisection
% a=3.53;
% b=3.55;
% while(b-a)>=1e-8
%     middle=(a+b)/2;
%     fa=solve_u(a);
%     fb=solve_u(b);
%     fmiddle=solve_u(middle);
%     if fmiddle==0
%         fprintf('FIND SOLUTION u=%f',middle);
%         break
%     else   if (abs(fa)/fa*abs(fmiddle)/fmiddle)<0
%             b=middle;
%         else
%             a=middle;
%         end
%     end
% end
% fprintf('FIND SOLUTION u=%f \n',middle);
a=linspace(3.53,3.55,100);
% a=sqrt(6)+1;
for i=1:length(a)
    i
    b(i)=solve_u(a(i));
end
plot(a,b)


function product=solve_u(u)
x=0.5;
period=3;
options = optimset('TolFun',1e-18);
[x fval]=fsolve(@logistic,x,options,u,period);
x_save(1)=x;
for i=2:2^(period-1)
    x=u*x*(1-x);
    x_save(i)=x;
end
product=1;
for i=1:2^(period-1)
    product=product*(-2*u*x_save(i)+u);
end
product=product+1;

function y=logistic(x,u,period)
t=x;
for i=1:2^(period-1)
    x=u*x*(1-x);
end
y=x-t;
