 
function hw9_3
u0=3.96109;
u_solve=[];
for period=1:4
[u fval]=fsolve(@logistic,u0,[],period);
u_solve=[u_solve u];
end
for i=1:length(u_solve)
fprintf('solved! lamda(%d)=%0.7f\n',i-1,u_solve(i))
end
% period=1;
% x=linspace(3.9610,3.9612,1000);
% for i=1:length(x)
%     y(i)=logistic(x(i),period);
% end
% plot(x,y)

function y=logistic(u,period)
x=u*0.5*(1-0.5);
for i=1:4*2^(period-1)-1
    x=u*x*(1-x);
end
y=x-0.5;
