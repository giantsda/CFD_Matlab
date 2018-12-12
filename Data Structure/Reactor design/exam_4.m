function [X_final]= exam_4
k=0.307;
T=[0 5 10 15 20 25 30 35];
C=[0 3 5 5 4 2 1 0];
p = polyfit(T,C,5)
x= [0:0.1:35];
len=length(x);
y = polyval(p,x);
total_integral=trapz(x,y);
for i=1:1:len
    t(i)=x(i);
    E(i)=polyval(p, t(i))/total_integral;
end
for i=1:1:len
%    C(i)=exp(-k*x(i));
    X(i)=1-exp(-k*t(i));
    PX(i)=X(i)*E(i);
end
plot(t,E);
xlabel('time');
ylabel('E');
X_final=trapz(t,PX)
gtext(['The final X is' num2str(X_final)]);

end








