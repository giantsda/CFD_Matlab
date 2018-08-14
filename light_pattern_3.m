% %% This file will convert particles vertical position to light intesity, and statistial
% %% result will be calculated form the light intensity history.
% a=0.058;
% interval=zeros(1,2000000);
% i=1;
% for e=1:number
%     e
%     y_pos=particle{e}(:,4)*100;
%     y_pos=max(y_pos)-y_pos;
%     time=particle{e}(:,1);
%     
%     light_history=10.^(log10(2000)-a.*y_pos);
%     light_history=double(light_history);
%     time=double(time);
%     
%     [pks,locs] = findpeaks(light_history,'MinPeakHeight',1000,'MinPeakProminence',200);
%     
% %     plot(light_history);
% %     plot(time,light_history);
% %     hold on;
% %     plot(time(locs),light_history(locs),'o')
% %     t1=xlabel('time(second)')
% %     t2=ylabel('light intensity (\mumoles/m2/s)')
% %     set(t1,'FontSize',32);
% %     set(t2,'FontSize',32);
% %     hold off ;
%     
%     peak_time =time(locs)    ;
%     peak_time_interval=diff(peak_time);
%     interval(i:i+length(peak_time_interval)-1)=peak_time_interval;
%     i=i+length(peak_time_interval);
%     %     interval=[interval; peak_time_interval];
%     %     pause(0.001)
% end
% 
% for i=length(interval):-1:1
%     if interval(i)~=0
%         break
%     end
% end
% interval(i:end)=[];
% 
% for i=1:length(interval)
%     if interval(i)>60
%         interval(i)=NaN;
%     end
% end


% for i=400:500
%     i
%     hist(interval,i)
%     pause();
% end

 

[counts,centers] = hist(interval,498);
counts=counts/max(counts);
bar(centers,counts);
t2=xlabel('time of light peak interval (seconds)')
t1=ylabel('percentage');
set(t2,'FontSize',32);
set(t1,'FontSize',32);
set(gca,'FontSize',20)



interval(isnan(interval))=0;
mean(interval)