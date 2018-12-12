% t=600;
% data_embed=zeros(1,floor(length(data)/t));
% j=1;
% for i=1:length(data)
%     if mod(i,600)==0
%     data_embed(j)=data(i);
%     j=j+1;
%     end
% end

p_s=[];
r_stu=[];
r_s=std(data_embed);
t=1;
for i=1:18
    r_s(i+1)=r_s(i)*1.2;
end

for m=23:23
    m
    for n=1:length(r_s)
        n
        c=0;
        r=r_s(1,n);
        for i=1:length(data_embed)-1
            for j=i+1:length(data_embed)-m+1
                tag=1;
                ii=i;
                jj=j;
                for k=m:m
                    distance=abs(data_embed(ii)-data_embed(jj));
                    if distance>r
                        tag=0;
                        break;
                    end
                    ii=ii+t;
                    jj=jj+t;
                end
                if tag==1
                    c=c+1;
                end
            end
        end
        r_s(2,n)=c;
    end
    cc=log(r_s);
    p=polyfit(cc(1,:),cc(2,:),1);
    p_s=[p_s p(1)];
    plot(cc(1,:),cc(2,:),'o',cc(1,:),polyval(p,cc(1,:)))
    r_stu=[r_stu; r_s];
    % pause();
end
p_s