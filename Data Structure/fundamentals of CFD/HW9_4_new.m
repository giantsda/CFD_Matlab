N=39;
B=zeros(N);
dx=1/(N+1);
for i=2:N-1
    B(i,i-1:i+1)=[1 -2 1];
end
B(1,1:2)=[ -2 1];
B(N,end-1:end)=[ 1  -2];
f=(6*dx*dx*[1:39]/40).';
f(end)=f(end)-1;
%%  point Jacobi method
un=zeros(N,1);
beta=0;
w=1;
H=zeros(N);
for i=2:N-1
    H(i,i-1:i+1)=[-beta 2/w 0];
end
H(1,1:2)=[2/w 0];
H(N,end-1:end)=[ -beta 2/w];
H_inv=inv(H);
r1=norm(B*un-f);
rn=Inf;
iter=0;
sav=[];
G=eye(N)+H_inv*B;
while(rn>=r1/10^2)
    unp1=G*un-H_inv*f;
    un=unp1;
    iter=iter+1;
    rn=norm(B*unp1-f);
    sav=[sav [iter;rn]];
    pause(0);
end
plot([1:39]/40,unp1,'-')
hold on;
while(rn>=r1/10^3)
    unp1=G*un-H_inv*f;
    un=unp1;
    iter=iter+1;
    rn=norm(B*unp1-f);
    sav=[sav [iter;rn]];
    pause(0);
end
plot([1:39]/40,unp1,'*')
hold on;
while(rn>=r1/10^4)
    unp1=G*un-H_inv*f;
    un=unp1;
    iter=iter+1;
    rn=norm(B*unp1-f);
    sav=[sav [iter;rn]];
    pause(0);
end
plot([1:39]/40,unp1,'o')
title('point Jacobi method');
legend('Order 2','Order 3','Order 4')
hold off;
figure
plot(sav(1,:),log(sav(2,:)))
ylabel('log(rn)')
xlabel('iteration')
[V,D] = eig(G);
D = diag(D);
ans_con_rate=max(D)
Theoretical_con_rate=cos(pi/(N+1))

%%  Gauss Seidel method
figure;
un=zeros(N,1);
beta=1;
w=1;
H=zeros(N);
for i=2:N-1
    H(i,i-1:i+1)=[-beta 2/w 0];
end
H(1,1:2)=[2/w 0];
H(N,end-1:end)=[ -beta 2/w];
H_inv=inv(H);
r1=norm(B*un-f);
rn=Inf;
iter=0;
sav=[];
G=eye(N)+H_inv*B;
while(rn>=r1/10^2)
    unp1=G*un-H_inv*f;
    un=unp1;
    iter=iter+1;
    rn=norm(B*unp1-f);
    sav=[sav [iter;rn]];
    pause(0);
end
plot([1:39]/40,unp1,'-')
hold on;
while(rn>=r1/10^3)
    unp1=G*un-H_inv*f;
    un=unp1;
    iter=iter+1;
    rn=norm(B*unp1-f);
    sav=[sav [iter;rn]];
    pause(0);
end
plot([1:39]/40,unp1,'*')
hold on;
while(rn>=r1/10^4)
    unp1=G*un-H_inv*f;
    un=unp1;
    iter=iter+1;
    rn=norm(B*unp1-f);
    sav=[sav [iter;rn]];
    pause(0);
end
plot([1:39]/40,unp1,'o')
title('Gauss Seidel method');
legend('Order 2','Order 3','Order 4')
hold off;
figure
plot(sav(1,:),log(sav(2,:)))
ylabel('log(rn)')
xlabel('iteration')
[V,D] = eig(G);
D = diag(D);
ans_con_rate=max(D)
Theoretical_con_rate=(cos(pi/(N+1)))^2

%% SOR method
figure;
un=zeros(N,1);
beta=1;
w=2/(1+sin(pi/(N+1)));
H=zeros(N);
for i=2:N-1
    H(i,i-1:i+1)=[-beta 2/w 0];
end
H(1,1:2)=[2/w 0];
H(N,end-1:end)=[ -beta 2/w];
H_inv=inv(H);
r1=norm(B*un-f);
rn=Inf;
iter=0;
sav=[];
G=eye(N)+H_inv*B;
while(rn>=r1/10^2)
    unp1=G*un-H_inv*f;
    un=unp1;
    iter=iter+1;
    rn=norm(B*unp1-f);
    sav=[sav [iter;rn]];
    pause(0);
end
plot([1:39]/40,unp1,'-')
hold on;
while(rn>=r1/10^3)
    unp1=G*un-H_inv*f;
    un=unp1;
    iter=iter+1;
    rn=norm(B*unp1-f);
    sav=[sav [iter;rn]];
    pause(0);
end
plot([1:39]/40,unp1,'*')
hold on;
while(rn>=r1/10^4)
    unp1=G*un-H_inv*f;
    un=unp1;
    iter=iter+1;
    rn=norm(B*unp1-f);
    sav=[sav [iter;rn]];
    pause(0);
end
plot([1:39]/40,unp1,'o')
title('SOR method');
legend('Order 2','Order 3','Order 4')
hold off;
figure
plot(sav(1,:),log(sav(2,:)))
ylabel('log(rn)')
xlabel('iteration')
[V,D] = eig(G);
D = diag(D);
ans_con_rate=max(D)
w_opt=2/(1+sin(pi/(N+1)));
Theoretical_con_rate=(w_opt-1)
%% 3 step Richadson
h1=4/(6-sqrt(3));
h2=4/6;
h3=4/(6+sqrt(3));
figure;
un=zeros(N,1);
beta=0;
w=1;
H=zeros(N);
for i=2:N-1
    H(i,i-1:i+1)=[-beta 2/w 0];
end
H(1,1:2)=[2/w 0];
H(N,end-1:end)=[ -beta 2/w];
H_inv=inv(H);
h1=4/(6-sqrt(3));
h2=4/6;
h3=4/(6+sqrt(3));
r1=norm(B*un-f);
rn=Inf;
iter=0;
sav=[];
G=eye(N)+H_inv*B;
while(rn>=r1/10^2)
    unp1_1=(eye(N)+inv(H/h1)*B)*un - inv(H/h1)*f;
    unp1_2=(eye(N)+inv(H/h2)*B)*unp1_1 - inv(H/h2)*f;
    unp1=(eye(N)+inv(H/h3)*B)*unp1_2 - inv(H/h3)*f;
    un=unp1;
    iter=iter+1;
    rn=norm(B*unp1-f);
    sav=[sav [iter;rn]];
end
plot([1:39]/40,unp1,'-')
hold on;
while(rn>=r1/10^3)
    unp1_1=(eye(N)+inv(H/h1)*B)*un - inv(H/h1)*f;
    unp1_2=(eye(N)+inv(H/h2)*B)*unp1_1 - inv(H/h2)*f;
    unp1=(eye(N)+inv(H/h3)*B)*unp1_2 - inv(H/h3)*f;
    un=unp1;
    iter=iter+1;
    rn=norm(B*unp1-f);
    sav=[sav [iter;rn]];
end
plot([1:39]/40,unp1,'*')
hold on;
while(rn>=r1/10^4)
    unp1_1=(eye(N)+inv(H/h1)*B)*un - inv(H/h1)*f;
    unp1_2=(eye(N)+inv(H/h2)*B)*unp1_1 - inv(H/h2)*f;
    unp1=(eye(N)+inv(H/h3)*B)*unp1_2 - inv(H/h3)*f;
    un=unp1;
    iter=iter+1;
    rn=norm(B*unp1-f);
    sav=[sav [iter;rn]];
end
plot([1:39]/40,unp1,'o')
hold off;
title(' 3 step Richadson');
legend('Order 2','Order 3','Order 4')
hold off;
figure
plot(sav(1,:),log(sav(2,:)))
ylabel('log(rn)')
xlabel('iteration')
[V,D] = eig(G);
D = diag(D);
ans_con_rate=max(D)
w_opt=2/(1+sin(pi/(N+1)));
Theoretical_con_rate=cos(pi/(N+1))*h1
