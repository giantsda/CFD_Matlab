%% AB1
step_size=0.1;
syms lh;
p=[];
for Re=-1:step_size:1;
    Re
    im=sqrt(1-Re^2);
    sgm=Re+im*i;
    lh=sgm-1;
    p=[p;real(lh), imag(lh)];
    hold on;
    im=-sqrt(1-Re^2);
    sgm=Re+im*i;
    lh=sgm-1;
    p=[p;real(lh), imag(lh)];
end
plot(p(:,1),p(:,2), '*');
axis equal;
%% AB2
syms lh;
p=[];
for Re=-1:step_size:1;
    Re
    im=sqrt(1-Re^2);
    sgm=Re+im*i;
    eqn=sgm^2-(1+1.5*lh)*sgm+0.5*lh==0;
    solx = double(solve(eqn,lh));
    p=[p;real(solx), imag(solx)];
    hold on;
    im=-sqrt(1-Re^2);
    sgm=Re+im*i;
    eqn=sgm^2-(1+1.5*lh)*sgm+0.5*lh==0;
    solx = double(solve(eqn,lh));
    p=[p;real(solx), imag(solx)];
end
plot(p(:,1),p(:,2), 'x');
axis equal;
%% AB3
syms lh;
p=[];
for Re=-1:step_size:1;
    Re
    im=sqrt(1-Re^2);
    sgm=Re+im*i;
    eqn=sgm^3-(1+23/12*lh)*sgm^2+16/12*lh*sgm-5/12*lh==0;
    solx = double(solve(eqn,lh));
    p=[p;real(solx), imag(solx)];
    hold on;
    im=-sqrt(1-Re^2);
    sgm=Re+im*i;
    eqn=sgm^3-(1+23/12*lh)*sgm^2+16/12*lh*sgm-5/12*lh==0;
    solx = double(solve(eqn,lh));
    p=[p;real(solx), imag(solx)];
end
plot(p(:,1),p(:,2), 'o');
axis equal;
%% AB4
syms lh;
p=[];
for Re=-1:0.02:1;
    Re
    im=sqrt(1-Re^2);
    sgm=Re+im*i;
    eqn=24*sgm^4-(24+55*lh)*sgm^3+59*lh*sgm^2-37*lh*sgm+9*lh==0;
    solx = double(solve(eqn,lh));
    p=[p;real(solx), imag(solx)];
    hold on;
    im=-sqrt(1-Re^2);
    sgm=Re+im*i;
    eqn=24*sgm^4-(24+55*lh)*sgm^3+59*lh*sgm^2-37*lh*sgm+9*lh==0;
    solx = double(solve(eqn,lh));
    p=[p;real(solx), imag(solx)];
end
plot(p(:,1),p(:,2), '.');
axis equal;
legend('AB1','AB2','AB3','AB4')
hold off;
figure;

%% RK1
step_size=0.1;
syms lh;
p=[];
for Re=-1:step_size:1;
    Re
    im=sqrt(1-Re^2);
    sgm=Re+im*i;
    lh=sgm-1;
    p=[p;real(lh), imag(lh)];
    hold on;
    im=-sqrt(1-Re^2);
    sgm=Re+im*i;
    lh=sgm-1;
    p=[p;real(lh), imag(lh)];
end
plot(p(:,1),p(:,2), '*');
axis equal;
%% RK2
syms lh;
p=[];
for Re=-1:step_size:1;
    Re
    im=sqrt(1-Re^2);
    sgm=Re+im*i;
    eqn=sgm-1-lh-0.5*lh^2==0;
    solx = double(solve(eqn,lh));
    p=[p;real(solx), imag(solx)];
    hold on;
    im=-sqrt(1-Re^2);
    sgm=Re+im*i;
    eqn=sgm-1-lh-0.5*lh^2==0;
    solx = double(solve(eqn,lh));
    p=[p;real(solx), imag(solx)];
end
plot(p(:,1),p(:,2), 'x');
axis equal;
%% RK3
syms lh;
p=[];
for Re=-1:step_size:1;
    Re
    im=sqrt(1-Re^2);
   sgm=Re+im*i;
    eqn= lh^3/6 + lh^2/2 + lh + 1-sgm==0;
    solx = double(solve(eqn,lh));
    p=[p;real(solx), imag(solx)];
    hold on;
    im=-sqrt(1-Re^2);
    sgm=Re+im*i;
    eqn= lh^3/6 + lh^2/2 + lh + 1-sgm==0;
    solx = double(solve(eqn,lh));
    p=[p;real(solx), imag(solx)];
end
plot(p(:,1),p(:,2), 'x');
axis equal;
%% RK4
syms lh;
p=[];
for Re=-1:step_size:1;
    Re
    im=sqrt(1-Re^2);
    sgm=Re+im*i;
    eqn=sgm-1-lh-0.5*lh^2-1/6*lh^3-1/24*lh^4==0;
    solx = double(solve(eqn,lh));
    p=[p;real(solx), imag(solx)];
    hold on;
    im=-sqrt(1-Re^2);
    sgm=Re+im*i;
    eqn=sgm-1-lh-0.5*lh^2-1/6*lh^3-1/24*lh^4==0;
    solx = double(solve(eqn,lh));
    p=[p;real(solx), imag(solx)];
end
plot(p(:,1),p(:,2), 'x');
axis equal;
legend('RK1','RK2','RK3','RK4')