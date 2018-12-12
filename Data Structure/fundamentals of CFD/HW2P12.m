%% Problem 12
clear all; % clear all data
low=0; % define my low and high spatial boundary
high=1;
M=100; % number of grids
a=1; % a is the coefficient
M_s=[];
err_s=[];
solu=[];
j=1;
for M=[100 200 400];
dx=(high-low)/(M+1);
out=[]; % output file which the solution of each time ste can be found here
pos=dx*[1:M]; % calculate position value at each grid
un=zeros(M,1);
%% set A
B=zeros(M);
for i=3:M-2
    B(i,i-2:i+2)=[1 -8 0 8 -1];
end
B(1,1:3)=[-6 12 -2];
B(2,1:4)=[-8 0 8 -1];
B(M-1,M-3:M)=[2 -12 6 4];
B(M,M-3:M)=[-4 18 -36 22];
operator_4O_center=1/12/dx*B; % Define my 2nd-order centered differences operator;
%% different time martching methods
%% 4th-order Runge-Kutta methods
t=0;
h=a*dx*0.5; % Courant number=1
out=[];
t=0;

for i=1:(50/h)+1
    bc=zeros(M,1);
    u0=sin(10*pi*t);
    bc(1)=-4*u0/12/dx;
    bc(2)=u0/12/dx;
    unp1d2_1=un-1/2*h*(operator_4O_center*un+bc);
    unp1d2_2=un-1/2*h*(operator_4O_center*unp1d2_1+bc);
    unp1_bar=un-h*(operator_4O_center*unp1d2_2+bc);
    unp1=un-1/6*h*(operator_4O_center*(un+2*unp1d2_1+2*unp1d2_2+unp1_bar)+6*bc);
    un=unp1;
%     out=[out ; t u0 unp1.'];
%     plot(pos,unp1);
%     hold on;
%     analytical=sin(-10*pi*pos+10*pi*t);
%     plot(pos,analytical)
%     legend('my','true')
%     hold off;
    t=t+h;
%     pause(0)
end
 solu{1,j}=unp1;
 j=j+1;
t=t-h;
M_s=[M_s dx];
analytical=sin(-10*pi*pos+10*pi*t);
err=sqrt(sum((analytical-unp1.').^2)/M);
err_s=[err_s err];
end

M=100;
dx=(high-low)/(M);
out=[]; % output file which the solution of each time ste can be found here
pos=dx*[1:M]; % calculate position value at each grid
plot(pos,solu{1},'-');

hold on;
M=200;
dx=(high-low)/(M);
out=[]; % output file which the solution of each time ste can be found here
pos=dx*[1:M]; % calculate position value at each grid
plot(pos,solu{2},'*-');

M=400;
dx=(high-low)/(M);
out=[]; % output file which the solution of each time ste can be found here
pos=dx*[1:M]; % calculate position value at each grid
plot(pos,solu{3},'o-');
analytical=sin(-10*pi*pos+10*pi*50);
plot(pos,analytical,'x-');
legend('M=100','M=200','M=400','analyticla solution');
xlabel('x')
ylabel('u')



plot(M_s,err_s)
x=log(M_s);
y=log(err_s);
p=polyfit(x,y,1)