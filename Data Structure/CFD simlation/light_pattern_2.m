% filename='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\10212016\29\particle';
% load(filename);
result=[];
critical_depth=15;
for e=1:length(particle)
    e
    yp=particle{e}(:,4)*100;
    time=particle{e}(:,1 );
    above=find(yp>=critical_depth);
    above=[NaN;above];
    %%
%     below=find(yp<critical_depth);
%     plot(time,yp);
%     hold on;
%     yp_above=yp;
%     yp_above(below)=NaN;
%     plot(time,yp_above)
%     hold off;
%     xlabel('time (s)');
%     ylabel('positon(cm)')
    %%
    out=zeros(length(above),7);
    %     j=1;
    %     for i=2:length(above)
    %         if above(i,1)-above(i-1,1)~=1
    %             out(j,1)=i;
    %             j=j+1;
    %         end
    %     end
    %     out(j:end,:)=[];
    %     out(:,2)= [(out(2:end,1)-1); length(above)];
    %     out(:,3:4)=above(out(:,1:2));
    %     out(:,5:6)=time(out(:,3:4));
    %
    %     t=[];
    %     for i=1:size(out,1)-1
    %         if out(i+1,5)-out(i,6)<=1
    %             yp(out(i,4):out(i+1,3)) =Inf;
    %             t=[t i;] ;
    %         end
    %     end
    %     above=find(yp>=critical_depth);
    %     above=[NaN;above];
    %     out=zeros(length(above),7);
    
    
    
    j=1;
    for i=2:length(above)
        if above(i,1)-above(i-1,1)~=1
            out(j,1)=i;
            j=j+1;
        end
    end
    out(j:end,:)=[];
    out(:,2)= [(out(2:end,1)-1); length(above)];
    out(:,3:4)=above(out(:,1:2));
    out(:,5:6)=time(out(:,3:4));
    out(:,7)=out(:,6)-out(:,5);
    out(:,8)= [diff(out(:,5)); NaN]-out(:,7);
    
    %     below=find(yp<15);
    %     plot(time,yp);
    %     hold on;
    %     yp_above=yp;
    %     yp_above(below)=NaN;
    %     plot(time,yp_above,'LineWidth',2)
    %     hold off;
    
    if length(out)~=0
        result{e,1}=out;
    end
    pause(0)
end

result_total=cell2mat(result);
light_duration=result_total(:,7);
% light_duration(find(light_duration>10))=NaN;
subplot 211
hist(light_duration,166)
title('light duration plot')
xlabel('time(s)')
light_interval=result_total(:,8);
% light_interval(find(light_interval>40))=NaN;
subplot 212
hist(light_interval,166)
title('light interval plot')
xlabel('time(s)')
Light_portion=nansum(light_duration)/(time(end)-time(1))/length(particle)
L_D=Light_portion/(1-Light_portion)
mean_light_duration=nanmean(light_duration);
mean_light_interval=nanmean(light_interval);
fprintf('Report: \n This is case %s \n Light portion = %f;\n L/D= %f;\n mean_light_duration=%f;\n mean_light_interval=%f;\n'...
,f,Light_portion,L_D,mean_light_duration,mean_light_interval);