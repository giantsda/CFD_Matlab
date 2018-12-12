%% 1D problem
clear all; % clear all data
low=0; % define my low and high spatial boundary
high=1;
M=50; % number of grids
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
%% different time martching methods
% %% Explicit Euler
% h=dx*a*0.1; % Courant number=0.1
% for i=1:(1/h)+1
%     unp1=un-operator_2O_center*un*h; % unp1 stands for Un+1;
%     un=unp1;
%     out=[out ; t unp1.'];
%     t=t+h;
%     %     plot(pos,unp1,'o-');
%     %     pause(0)
% end
% plot(pos,out(end,2:end),'o-');
% hold on;



%% AB2
% h=dx*a*0.1; % Courant number=0.1
% t=0;
% out=[];
% unm1=u_ic.';
% un=unm1-operator_2O_center*unm1*h;
% dunm1dt=(un-unm1)/h;
% for t=1:((1/h)-1)
%     unp1= (-dunm1dt-3*operator_2O_center*un)*h/2+un;
%     dundt=(dunm1dt+2/h*(unp1-un))/3;
%     out=[out ;  t unp1.'];
%     t=t+h;
%     unm1=un;
%     un=unp1;
%     dunm1dt=dundt;
% %     plot(pos,unp1,'o-');
% %     pause(0)
% end
% plot(pos,out(end,2:end),'*-');





% %% implicit Euler
% h=a*dx; % Courant number=1
% out=[];
% un=u_ic.';
% A=(operator_2O_center*h+eye(M));
% for t=1:(1/h)
%     unp1=A\(un);
%     un=unp1;
%     out=[out ; unp1.'];
%     plot(pos,unp1,'o-');
%     pause(0)
% end
% plot(pos,out(end,2:end),'.-');



% %% trapezoidal
% h=dx*a*0.1; % Courant number=0.1
% t=0;
% out=[];
% un=u_ic.';
% unp1=un-operator_2O_center*un*h; 
% dundt=(unp1-un)/h;
% for t=1:((1/h)-1)
%     unp1=(2/h*eye(M)+operator_2O_center)\(2/h*un+dundt)
%     dunp1dt=(unp1-un)*2/h-dundt;
%     out=[out ;  t unp1.'];
%     t=t+h;
%     un=unp1;
%     dundt=dunp1dt;
%     plot(pos,unp1,'o-');
%     pause(0)
% end
% plot(pos,out(end,2:end),'x-');


%% 4th-order Runge-Kutta methods
h=a*dx; % Courant number=1
out=[];
un=u_ic.';
for t=1:(1/h)
    unp1d2_1=un-1/2*h*operator_2O_center*un;
    unp1d2_2=un-1/2*h*operator_2O_center*unp1d2_1;
    unp1_bar=un-h*operator_2O_center*unp1d2_2;
    unp1=un+1/6*h*(-operator_2O_center*(un+2*unp1d2_1+2*unp1d2_2+unp1_bar));
    un=unp1;
    out=[out ; unp1.'];
    plot(pos,unp1,'o-');
    pause(0)
end
plot(pos,out(end,:),'-*');


% plot(pos,u_ic,'-^');
% legend(' Explicit Euler','AB2','implicit Euler','trapezoidal',' 4th-order Runge-Kutta','exact solution');