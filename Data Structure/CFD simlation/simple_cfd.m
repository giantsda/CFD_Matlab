%% 1D problem
clear all;
low=0;
high=100;
M=1000;
v=0.5;
dx=(high-low)/(M-1);
out.data=zeros(100,M);
out.data(1,:)=1:M;
u=zeros(1,M);
pos=(high-low)/(M-1)*([1:M]);
dt=0.2;
%% set IC
for i=1:M-1
    if pos(i)>=0&& pos(i)<=700
        u(i)=5*pos(i);
    end
end
u(M)=u(M-1);
out.data(2,:)=u;
k=3;
%% time martching
for t=1:100
%     ut(1)=u(1)-v*dt/dx*(u(2)-u(1));
    for i=1:M-1
        ut(i)=u(i)-v*dt/dx*(u(i+1)-u(i));
    end
    ut(M)=ut(M-1);
    u=ut;
    out.data(k,:)=ut;
    k=k+1;
     out.time(t)=t*dt;
end

for i=1:100
    plot(out.data(i+1,:))
    pause()
end


% %% 2D Laplase
% low=0;
% high=1;
% M=1000; %nodes in x
% N=1000; % nodes in y
% %%
% bc_matrix=zeros(N+2,M+2);
% bc_matrix(1,1)=9;
% bc_matrix(1,end)=9;
% bc_matrix(end,1)=6.1;
% bc_matrix(end,end)=10;
% for j=[1 M+2]
%     for i=1:N+2
%         bc_matrix(i,j)=bc_matrix(1,j)+(bc_matrix(end,j)-bc_matrix(1,j))/(N+1)*(i-1)*sin(i/50);
%     end
% end
% for i=[1 N+2]
%     for j=1:M+2
%         bc_matrix(i,j)=bc_matrix(i,1)+(bc_matrix(i,end)-bc_matrix(i,1))/(M+1)*(j-1)*cos(i/50);
%     end
% end
% dx=(high-low)/(M+1);
% dy=(high-low)/(N+1);
% 
% % A=zeros(M*N);
% % for i=1:M*N
% %     A(i,i)=-2*(dx^2+dy^2);
% % end
% % for i=1:M*N-1
% %     if mod(i,M)~=0
% %         A(i,i+1)=dx^2;
% %         A(i+1,i)=dx^2;
% %     end
% % end
% % j=1;
% % for i=M+1:M*N
% %     A(i,j)=dy^2;
% %     A(j,i)=dy^2;
% %     j=j+1;
% % end
% 
% %% sparse matrix
% w=1;
% leng=3*M*N-2*(N-1)+M*(N-1);
% leng=10;
% row=[];
% col=[];
% val=[];
% row(w:w+M*(N-1)-1,1)=[1:M*(N-1)];
% col(w:w+M*(N-1)-1,1)=[1+M:M*N];
% val(w:w+M*(N-1)-1,1)=dy^2;
% haha=zeros((M-1)*N,1);
% k=1;
% l=1;
% for i=1:N
%     for j=1:M-1
%         haha(l)=k;
%         if j~=M-1
%             k=k+1;
%         else
%             k=k+2;           
%         end
%         l=l+1;
%     end
% end
% row=[row;haha];
% col=[col; haha+1];
% val=[val ; ones(N*(M-1),1)*dx^2];
% ss=sparse(row,col,val);
% temp=row;
% row=[row;col];
% col=[col;temp];
% val=[val;val];
% row=[row; (1:M*N).'];
% col=[col; (1:M*N).'];
% val=[val ; ones(N*M,1)*-2*(dx^2+dy^2);];
% A=sparse(row,col,val);
% b=zeros(M*N,1);
% k=1;
% for i=1:N
%     for j=1:M
%         switch( j)
%             case 1
%                 b(k,1)=dx^2*bc_matrix(i+1,j-1+1);
%                 %                 b{k,1}=[num2str(i) num2str(j-1)];
%             case M
%                 b(k,1)=dx^2*bc_matrix(i+1,j+1+1);
%                 %                 b{k,1}=[num2str(i) num2str(j+1)];
%         end
%         k=k+1;
%     end
% end
% for i=[1 N]
%     for j=1:M
%         switch( i)
%             case 1
%                 b(M*(i-1)+j,1)=b(M*(i-1)+j,1)+dy^2*bc_matrix(i-1+1,j+1);
%                 %                 b{M*(i-1)+j,1}=[b{M*(i-1)+j,1} num2str(i-1) num2str(j) ];
%             case N
%                 b(M*(i-1)+j,1)=b(M*(i-1)+j,1)+dy^2*bc_matrix(i+1+1,j+1);
%                 %                  b{M*(i-1)+j,1}=[b{M*(i-1)+j,1} num2str(i+1) num2str(j) ];
%         end
%     end
% end
% h=1;
% x=A\(-b);
% solution=zeros(N,M);
% k=1
% for i=1:N
%     for j=1:M
%         solution(i,j)=x(k);
%         k=k+1;
%     end
% end
% xx=linspace(low,high,M);
% yy=linspace(low,high,N);
% [X,Y] = meshgrid(xx,yy);
% surf(X,Y,solution,'edgecolor', 'none')
% h=1;


