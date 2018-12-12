path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\01222017\32\data';
high_files = dir([ path '\high*']);
low_files = dir([ path '\low*']);
power_i=[];
time_i=[];
length_1=length(high_files(1).name);
special_index=[];
for i=1:length(high_files)   % sort the file name for reading and plot
    name=high_files(i).name;
    index=find(name(:)=='-'); % index is the position of the cha '-'
    time=name(index+1:end);
    time_i(i,:)=[i str2num(time)];
end   
time_i=sortrows(time_i,2);
last_name=high_files(time_i(end,1)).name;   
 for i =1:length(time_i)
        i=time_i(i);
        torque_high=[];
        torque_low=[];
        high = importdata([path '\' high_files(i).name],',');
        disp([high_files(i).name '   /    ' last_name]);
        high=high.data;
    for j=1:length(high)
            xp=high(j,2);
            yp=high(j,3);
            zp=high(j,4);
            a_vof=high(j,7);
            cell_face=high(j,6);
            total_pressure=high(j,5);
                if a_vof<=0.05
                L=(xp^2+(yp-0.3735)^2)^0.5;
                torque_high=[ torque_high total_pressure*cell_face*L];
                end
    end
    torque_hign_sum=sum(torque_high);
    low = importdata([path '\' low_files(i).name],',');
    low=low.data;
      for j=1:length(low)
        xp=low(j,2);
        yp=low(j,3);
        zp=low(j,4);
        a_vof=low(j,7);
        cell_face=low(j,6);
        total_pressure=low(j,5);
            if a_vof<=0.05
            L=(xp^2+(yp-0.3735)^2)^0.5;
            torque_low=[ torque_low total_pressure*cell_face*L];
            end
      end
    torque_low_sum=sum(torque_low);
    power_i=[power_i (torque_hign_sum-torque_low_sum)*1.428];
 end
power=mean(power_i);
plot(time_i(:,2),power_i)
title('Power vs time')
xlabel('time(s)')
ylabel('power(Watt)');
     