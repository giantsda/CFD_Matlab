%% problem 11
clear all; % clear all data
low=0; % define my low and high spatial boundary
high=1;
M=100; % number of grids
a=1; % a is the coefficient
M_s=[];
err_s=[];
j=1;
solu=[];
for M=[100 200 400 ];
dx=(high-low)/(M);
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
%% 4th-order Runge-Kutta methods
t=0;
h=a*dx; % Courant number=1
out=[];
for i=1:(10/h)+1
    bc=zeros(M,1);
    u0=sin(10*pi*t)/2/dx;
    bc(1)=-u0;
    unp1d2_1=un-1/2*h*(operator_2O_center*un+bc);
    unp1d2_2=un-1/2*h*(operator_2O_center*unp1d2_1+bc);
    unp1_bar=un-h*(operator_2O_center*unp1d2_2+bc);
    unp1=un-1/6*h*(operator_2O_center*(un+2*unp1d2_1+2*unp1d2_2+unp1_bar)+6*bc);
    un=unp1;
    out=[out ; t -bc(1)*2*dx unp1.'];
    analytical=sin(-10*pi*[0 pos]+10*pi*t);
%     plot([0 pos],out(i,2:end),'*-',[0 pos],analytical)
    t=t+h;
%     pause( )
end
 solu{1,j}=unp1;
 j=j+1;
t=t-h;
M_s=[M_s M];
analytical=sin(-10*pi*pos+10*pi*t);
err=sqrt(sum((analytical-unp1.').^2)/M)
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

% plot(M_s,err_s)
x=log(M_s);
y=log(err_s);
p=polyfit(x,y,1)