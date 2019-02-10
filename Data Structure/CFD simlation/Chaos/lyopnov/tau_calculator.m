tau_s=[]; % tau_save
for i=1:500
    i
    e=randi([1 length(particle)]);
    autocooralation=[];
    if length(particle{e})~=0
        data=particle{e}(:,4);
        average=mean(data);
        data_u=data-average;
        N=500;
        t_s=1:1:N;
        for j=1:length(t_s)
            t=t_s(j);
            autocooralation(j)=data_u(1:end-N).'*data_u(t:end-1-N+t);
        end
        ac=abs(autocooralation-autocooralation(1)/exp(1));
        [ac tau]=min(ac);
        tau_s=[tau_s tau];
        plot(t_s,autocooralation)
%         pause()
    end
end
hist(tau_s,5000)
mean(tau_s)