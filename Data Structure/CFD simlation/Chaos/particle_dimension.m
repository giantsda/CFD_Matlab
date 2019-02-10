tau= 47;
data_embed=[];
for i=1:600%length(particle)
    e=randi([1 length(particle)]);
    if length(particle{e})~=0
        data=particle{e}(:,4);
        data_embed{i}=zeros(1,floor(length(data)/tau));
        j=1;
        for k=1:length(data)
            if mod(k,tau)==0
                data_embed{i}(j)=data(k);
                j=j+1;
            end
        end
    end
end
if  min( cell2mat(data_embed))<=0
    data_embed=data_embed-min( cell2mat(data_embed));
end
 
%%
% clearvars -except data_embed
r_C=[];
for m=4:4 %m is the dimension
    r_s=[];
    r=std(cell2mat(data_embed));
%    r= 0.004011674069106
    for k=1:30  %varing r
        N=sum(cellfun('length',data_embed));
        grid_number=zeros(N-m+1,m);
        kk=1;
        for i=1:length(data_embed)
            N=length(data_embed{i});
            for j=1:N-m+1 
                grid_number(kk,:)=[ceil(data_embed{i}(j:j+m-1)/r)];
                kk=kk+1;
            end
        end
        
        for i=length(grid_number):-1:1
            if  isempty(nonzeros(grid_number(i,:)))==0 % is not empty
                break
            end
        end
        grid_number(i+1:end,:)=[];
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
for i=4:length(r_C)
    %     i=3
    rc_new=[];
    rc=r_C{i};
    rc_log=log(rc);
    p=polyfit(rc_log(1,:),rc_log(2,:),1);
    plot(rc_log(1,:),rc_log(2,:),'o',rc_log(1,:),polyval(p,rc_log(1,:)))
    title(['GP_dimesnsion=' num2str(p(1),18)])
%     dif=abs(rc_log(2,:)-polyval(p,rc_log(1,:)));
%     for j=1:length(rc)
%         if dif(j)<=mean(dif)
%             rc_new=[rc_new rc_log(:,j)];
%         end
%     end
%     p=polyfit(rc_new(1,:),rc_new(2,:),1);
%     plot(rc_new(1,:),rc_new(2,:),'o',rc_new(1,:),polyval(p,rc_new(1,:)))
%     pause()
    p_s=[p_s p(1)];
end
% plot(p_s)