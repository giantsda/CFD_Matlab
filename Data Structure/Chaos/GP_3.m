% determine t
% data=a(:,1);
% average=mean(data);
% data_u=data-average;
% N=1000;
% t_s=1:1:100;
% for i=1:length(t_s)
%     t=t_s(i);
%     autocooralation(i)=data_u(1:end-N).'*data_u(t:end-1-N+t);
% end
% plot(t_s,autocooralation)

%% generate embedded data
% t=10;
% data_embed=zeros(1,floor(length(data)/t));
% j=1;
% for i=1:length(data)
%     if mod(i,t)==0
%     data_embed(j)=data(i);
%     j=j+1;
%     end
% end
% 
% if  min(data_embed)<=0
% data_embed=data_embed-min(data_embed);
% end


% for i=1:length(data_embed)-1
%     data_v(i,:)=[data_embed(i:i+1)];
% end
% scatter(data_v(:,1),data_v(:,2),13,'filled')

%% Calculate GP
% p_s=[]; % p_s is used to store for p for plot
% r_study=[];
% r_s=std(data_embed)/5; % r_s is used to store for r 
% t=1; % t is the time delay
% for i=1:7
%     r_s(i+1)=r_s(i)*1.2;    
% end
% m_s=6:10;
% for di=1:length(m_s)
%     m=m_s(di)
%     for n=1:length(r_s)
%         n
%         c=0;
%         r=r_s(1,n);
%         for i=1:length(data_embed)-1
%             for j=i+1:length(data_embed)-m+1
%                 tag=1;
%                 ii=i;
%                 jj=j;
%                 for k=1:m
%                     distance=abs(data_embed(ii)-data_embed(jj));
%                     if distance>r
%                         tag=0;
%                         break;
%                     end
%                     ii=ii+t;
%                     jj=jj+t;
%                 end
%                 if tag==1
%                     c=c+1;
%                 end
%             end
%         end
%         M=length(data_embed);
%         r_s(2,n)=c/(M*(M-1)/2);
%     end
%     cc=log(r_s);
%     p=polyfit(cc(1,:),cc(2,:),1);
%     p_s=[p_s p(1)];
%     plot(cc(1,:),cc(2,:),'o',cc(1,:),polyval(p,cc(1,:)))
%     title(['p=' num2str(p(1))]);
%     r_study=[r_study; r_s];
%     pause(0);
% end
% plot(m_s,p_s)