N=39;
BB=zeros(N);
dx=1/(N+1);
for i=2:N-1
    BB(i,i-1:i+1)=[1 -2 1];
end
BB(1,1:2)=[ -2 1];
BB(N,end-1:end)=[ 1  -2];
f=(6*dx*dx*[1:39]/40).';
f(end)=f(end)-1;
%%  Gauss Seidel method
HH=zeros(N);
beta=1;
w=1;
for i=2:N-1
    HH(i,i-1:i+1)=[-beta 2/w 0];
end
HH(1,1:2)=[2/w 0];
HH(N,end-1:end)=[ -beta 2/w];
N=[39 19 9 4];
for i=1:length(N)
    B{i}=(1/4)^(i-1)*BB(1:N(i),1:N(i));
    H{i}=HH(1:N(i),1:N(i));
    G{i}=eye(N(i))+H{i}\B{i};
end

for i=1:1:length(N)-1
    R{i}=zeros(N(i+1),N(i));
    I{i}=zeros(N(i),N(i+1));
end

for i=1:length(R)
    for j=1:size(R{i},2)
        if mod(j,2)==0
            R{i}(j/2,j)=1;
            I{i}(j-1:j+1,j/2)=[0.5; 1;0.5];
        end
    end
end

%%
for i=length(N)-1:-1:1
    if  i==3
        basic_iters_matrix{i}=(eye(N(i))-I{i}*1*inv(B{i+1})*R{i}*B{i})*G{i};
    else
        basic_iters_matrix{i}=(eye(N(i))-I{i}*(eye(N(i+1))-basic_iters_matrix{i+1})*inv(B{i+1})*R{i}*B{i})*G{i};
    end
end
basic_iters=basic_iters_matrix{1};
un=zeros(N(1),1);
r1=norm(B{1}*un-f);
rn=Inf;
iter=0;
sav=[];
while(rn>=r1/10^2)
    unp1=basic_iters*un-basic_iters*inv(B{1})*f+inv(B{1})*f;
    un=unp1;
    iter=iter+1;
    rn=norm(B{1}*unp1-f);
    sav=[sav [iter;rn]];
end
plot([1:39]/40,unp1,'-')
hold on;
while(rn>=r1/10^3)
    unp1=basic_iters*un-basic_iters*inv(B{1})*f+inv(B{1})*f;
    un=unp1;
    iter=iter+1;
    rn=norm(B{1}*unp1-f);
    sav=[sav [iter;rn]];
end
plot([1:39]/40,unp1,'*')
hold on;
while(rn>=r1/10^4)
    unp1=basic_iters*un-basic_iters*inv(B{1})*f+inv(B{1})*f;
    un=unp1;
    iter=iter+1;
    rn=norm(B{1}*unp1-f);
    sav=[sav [iter;rn]];
end
plot([1:39]/40,unp1,'o')
title('  Gauss Seidel method');
legend('Order 2','Order 3','Order 4')
hold off;
figure
plot(sav(1,:),log(sav(2,:)))
ylabel('log(rn)')
xlabel('iteration')
[V,D] = eig(basic_iters);
D = real(diag(D));
ans_con_rate=max(D)
Theoretical_con_rate=(cos(pi/(N(1)+1)))^2






