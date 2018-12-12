%% Problem 9
clear all; % clear all data
low=0; % define my low and high spatial boundary
high=1;
M_s=[];
err_s=[];
 for M=[100 200 400]
a=1; % a is the coefficient 
dx=(high-low)/M;  
out=[]; % output file which the solution of each time ste can be found here
un=zeros(1,M); % initialize my IC vector;
pos=(high-low)/(M)*([0:(M-1)]); % calculate position value at each grid
%% set IC
for i=1:M
        un(i)=exp(-0.5*((pos(i)-0.5)/0.08)^2);
end
u_ic=un; %% save my IC so I can compare with my soilution
%% set A
A=zeros(M); % initialize matrix A
for i=2:M-1
    A(i,i-1)=-1;
    A(i,i+1)=1;
end
A(1,2)=1;
A(1,end)=-1;
A(M,1)=1;
A(M,M-1)=-1; % Now A is B(1,-2,1);
un=un.';
operator_2O_center=1/2/dx*A; % Define my 2nd-order centered differences operator;
t=0;

%% 4th-order Runge-Kutta methods
h=a*dx; % Courant number=1
out=[];
un=u_ic.';
t=0;
for i=1:(1/h)
    t=t+h;
    unp1d2_1=un-1/2*h*operator_2O_center*un;
    unp1d2_2=un-1/2*h*operator_2O_center*unp1d2_1;
    unp1_bar=un-h*operator_2O_center*unp1d2_2;
    unp1=un+1/6*h*(-operator_2O_center*(un+2*unp1d2_1+2*unp1d2_2+unp1_bar));
    un=unp1;
    out=[out ; t unp1.'];
%     plot(pos,unp1,'o-');
%     pause(0)
end
solution=out(end,2:end);
M_s=[M_s dx];
err=sqrt(sum((solution-u_ic).^2)/M);
err_s=[err_s err];
end

plot(M_s,err_s)
x=log(M_s);
y=log(err_s);
p=polyfit(x,y,1)