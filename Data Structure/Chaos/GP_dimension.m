%% determine t
data=a(:,1);
% data_try=data(1:1000000);
% data_try=data;
% average=mean(data_try);
% data_u=data_try-average;
% N=1000;
% t_s=1:1:500;
% for i=1:length(t_s)
%     t=t_s(i);
%     autocooralation(i)=data_u(1:end-N).'*data_u(t:end-1-N+t);
% end
% plot(t_s,autocooralation)

%% generate embedded data
t=94;
data_embed=zeros(1,floor(length(data)/t));
j=1;
for i=1:length(data)
    if mod(i,t)==0
        data_embed(j)=data(i);
        j=j+1;
    end
end
%
if  min(data_embed)<=0
    data_embed=data_embed-min(data_embed);
end

%% plot
% data_v=zeros(length(data_embed)-1,2);
% for i=1:length(data_embed)-1
%     data_v(i,:)=[data_embed(i:i+1)];
%         if i==5000
%             break;
%         end
% end
% scatter(data_v(:,1),data_v(:,2),3,'filled')


%%
% clearvars -except data_embed
r_C=[];
for m=3:10 %m is the dimension
    N=length(data_embed);
    r=std(data_embed);
    r_s=[];
    for k=1:300  %varing r
        grid_number=zeros(N-m+1,m);
        for i=1:N-m+1
            grid_number(i,:)=[ceil(data_embed(i:i+m-1)/r)];
        end
        fprintf('now computing dimension=%d r=%d \n',m,k)
        pairs=get_C(grid_number,m,r,N);
        if pairs==0
            break;
        end
        if k>1 && pairs==r_s(2,k-1)
            break;
        end
        r_s=[r_s [r; pairs]];
        r=r/1.1;
    end
    r_C{m}=r_s;
end

%% Analyze
p_s=[];
for i=2:length(r_C)
    %     i=3
    rc_new=[];
    rc=r_C{i};
    rc_log=log(rc);
    p=polyfit(rc_log(1,:),rc_log(2,:),1);
    plot(rc_log(1,:),rc_log(2,:),'o',rc_log(1,:),polyval(p,rc_log(1,:)))
    dif=abs(rc_log(2,:)-polyval(p,rc_log(1,:)));
    for j=1:length(rc)
        if dif(j)<=mean(dif)
            rc_new=[rc_new rc_log(:,j)];
        end
    end
    p=polyfit(rc_new(1,:),rc_new(2,:),1);
    plot(rc_new(1,:),rc_new(2,:),'o',rc_new(1,:),polyval(p,rc_new(1,:)))
    pause()
    p_s=[p_s p(1)];
end
plot(p_s)
