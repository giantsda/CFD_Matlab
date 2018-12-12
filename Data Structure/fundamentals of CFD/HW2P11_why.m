%% 1D problem
clear all; % clear all data
low=0; % define my low and high spatial boundary
high=1;
M=400; % number of grids
a=1; % a is the coefficient
M_s=[];
err_s=[];
for M=[100 200 400];
dx=(high-low)/(M+1);
out=[]; % output file which the solution of each time ste can be found here
pos=dx*[1:M]; % calculate position value at each grid
un=zeros(M,1);
%% set A
A=zeros(M); % initialize matrix A
for i=2:M-1
    A(i,i-1)=-1;
    A(i,i+1)=1;
end
A(1,2)=1;
A(M,M-1:M)=[-2 2]; % Now A is B(1,-2,1);
operator_2O_center=1/2/dx*A; % Define my 2nd-order centered differences operator;
%% different time martching methods
%% 4th-order Runge-Kutta methods
t=0;
h=a*dx; % Courant number=1
out=[];
t=0;
for i=1:(2/h)
    u0=zeros(M,1);
    u0(1)=sin(10*pi*t);
    unp1d2_1=un-1/2*h*(operator_2O_center*un);
    unp1d2_2=un-1/2*h*(operator_2O_center*unp1d2_1);
    unp1_bar=un-h*(operator_2O_center*unp1d2_2);
    unp1=un+1/6*h*(-operator_2O_center*(un+2*unp1d2_1+2*unp1d2_2+unp1_bar))+u0;
    un=unp1;
    out=[out ; t u0(1) unp1.'];
    t=t+h;
    plot(pos,unp1);
    hold on;
    analytical=sin(-10*pi*pos+10*pi*t);
    plot(pos,analytical)
    hold off;
    pause( 0)
end
t=t-h;
M_s=[M_s dx];
analytical=sin(-10*pi*[ 0 pos]+10*pi*t);
err=sqrt(sum((analytical-[sin(-10*pi*t) unp1.']).^2)/M);
err_s=[err_s err];
end
plot(M_s,err_s)
x=log(M_s);
y=log(err_s);
p=polyfit(x,y,1)