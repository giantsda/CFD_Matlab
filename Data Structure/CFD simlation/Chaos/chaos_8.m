N=10;
a=linspace(0,1,N+1);
interval=a(2)-a(1);
P=zeros(N);
for i=1:N
    i;
    if mod(i,1000)==0
        i
    end
    i1=a(i);
    i2=a(i+1);
    s1=(4-sqrt(16-4*4*i1))/8;
    s2=(4-sqrt(16-4*4*i2))/8;
    s3=(4+sqrt(16-4*4*i2))/8;
    s4=(4+sqrt(16-4*4*i1))/8;
    t1=ceil((s1)/interval);
    t2=ceil((s2)/interval);
    t3=ceil((s3)/interval); 
    t4=ceil((s4)/interval);
    if t1==0
        t1=1;
    end
    fprintf('s1=%f s2=%f s3=%f s4=%f   s1 in %d, s2 in %d, s3 in %d, s4 in %d \n',s1,s2,s3,s4,t1,t2,t3,t4);
    intesect=zeros(1,N);
    if (s2<s3)
        if t1==t2
            intesect(t1)=abs(s1-s2);
        else
            intesect(t1)=a(1+t1)-s1;
            intesect(t2)=s2-a(t2);
            intesect(t1+1:t2-1)=0;
        end
        if t3==t4
            intesect(t3)=abs(s3-s4);
        else
            intesect(t3)=a(1+t3)-s3;
            intesect(t4)=s4-a(t4);
            intesect(t3+1:t4-1)=0;
        end
    else
            intesect(t1)=a(1+t1)-s1;
            intesect(t4)=s4-a(t4);
            intesect(t1+1:t4-1)=1/N;    
    end
        intesect=intesect*N;
        P(i,:)=intesect;
end
for i=1:10
    fprintf('%0.5f ' ,P(i,:).' );
     fprintf('\n');
end
[V,D] = eig(P);
sum1=sum(V(:,1));
v=V(:,1)/sum1;
fprintf('%0.4f ',v);
p0=ones(N,1)/N;
clc
for i=1:20
     if mod(i,100)==0
        i;
    end
    p0=P*p0;
         fprintf('iteration %d ',i );
     fprintf('%0.4f ' ,p0 );
     fprintf('\n' );
end
 sum1=sum(p0);
 p0=p0/sum1;
 plot(p0,'-*')
% bar(p0)
% bar(p0(1:end),0.2)