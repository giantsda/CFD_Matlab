% y=linspace(-0.5,0.5,100000);
% a=1.4;
% b=0.3;
% x=1-a/b^2*y.^2;
% plot(x,y)
% xlabel('x');
% ylabel('y');

% y=linspace(-0.5,0.5,100000);
% a=1.4;
% b=0.3;
% x=1-a/b^2*y.^2+(b/a)^0.5*(b-y).^0.5;
% plot(x,y)
% xlabel('x');
% ylabel('y');
% hold on;
% x=1-a/b^2*y.^2-(b/a)^0.5*(b-y).^0.5;;
% plot(x,y)


x_n=0;
y_n=0;
a=1.4;
b=0.3;
N=10000000;
for i=1:N
    x_n1=y_n+1-a*x_n*x_n;
    y_n1=b*x_n;
    x_p(i)=x_n1;
    y_p(i)=y_n1;
    x_n=x_n1;
    y_n=y_n1;
end
why=[x_p;y_p];
plot(x_p,y_p,'k.','markersize',0.005)
xlabel('x');
ylabel('y');


figure;
y=linspace(-0.5,0.5,100000);
a=1.4;
b=0.3;
xlabel('x');
ylabel('y');
xlim([-1.5 1.5]);
ylim([-0.4 0.4]);
hold on;
x=1-a/b^2*y.^2+b/sqrt(a)*sqrt(1-y/b+sqrt(b^2/a*(1-sqrt((1-y./b)/a))));
plot(x,y)
x=1-a/b^2*y.^2+b/sqrt(a)*sqrt(1-y/b-sqrt(b^2/a*(1+sqrt((1-y./b)/a))));
plot(x,y)%%
x=1-a/b^2*y.^2-b/sqrt(a)*sqrt(1-y/b+sqrt(b^2/a*(1-sqrt((1-y./b)/a))));
plot(x,y)%%
x=1-a/b^2*y.^2-b/sqrt(a)*sqrt(1-y/b-sqrt(b^2/a*(1+sqrt((1-y./b)/a))));
plot(x,y)
 legend('1','2','3','4')
