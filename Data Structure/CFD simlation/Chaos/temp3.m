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
