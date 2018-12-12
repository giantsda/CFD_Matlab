    S_corr_s=[];
for t=10:1:3000
    t
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
    
    %%
    STD=std(data_embed);
    r_C=[];
    S_s=0;
    for m=2:5 %m is the dimension
        r=std(data_embed);
        r_s=[0.5*STD STD 1.5*STD 2*STD ];
        for k=1:length(r_s)  %varing r
%                     fprintf('m=%d,r=%d\n',m,k)
            r=r_s(1,k);
            pairs=get_C(data_embed,m,r);
            if pairs==0
                break;
            end
            r_s(2,k)=pairs;
            S_s=S_s+pairs;
        end
        r_C{m}=r_s;
    end
    S=S_s/16;
    
    %%
    dS=[];
    for m=2:5 %m is the dimension
        r=std(data_embed)/10;
        %     r=2.230350300593645e-04
        r_s=[];
        for k=1:1000 %varing r
%             fprintf('m=%d,r=%d\n',m,k)
            pairs=get_C(data_embed,m,r);
            if pairs==0
                break;
            end
            if k==1
                pair_old=pairs;
            else
                if  pairs==pair_old
                    break;
                end
                pair_old=pairs;
            end
            r_s=[r_s [r; pairs]];
            r=r/1.1;
        end
        
        r=std(data_embed)/10;
        for k=1:1000 %varing r
%             fprintf('m=%d,r=%d\n',m,k)
            pairs=get_C(data_embed,m,r);
%             if pairs==0
%                 break;
%             end
            if k==1
                pair_old=pairs;
            else
                if  pairs==pair_old
                    break;
                end
                pair_old=pairs;
            end
            r_s=[r_s [r; pairs]];
            r=r*1.1;
        end
        dS=[dS max(r_s(2,:))-min(r_s(2,:))];
        r_C{m}=r_s;
    end
    dS=mean(dS);
    S_corr=S+dS;
    S_corr_s=[S_corr_s [t;S_corr]];
end
plot(S_corr_s(1,:),S_corr_s(2,:))

