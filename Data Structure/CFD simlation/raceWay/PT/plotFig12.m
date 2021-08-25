    time=particle{1}(:,1);
    time=double(time);
for e=1:5000
    e
    criticalLightIntensity=500;
    p=particle{e};
    if size(p,1)~=length(time)
        continue;
    end
    x_pos=particle{e}(:,3);
    y_pos=particle{e}(:,4);
    z_pos=particle{e}(:,5);
 
    timeInterpolate=[min(time):0.01:max(time)].';
    x_posInterpolate = interp1(time,x_pos,timeInterpolate,'spline');
    y_posInterpolate = interp1(time,y_pos,timeInterpolate,'spline');
    z_posInterpolate = interp1(time,z_pos,timeInterpolate,'spline');
    % plot(timeInterpolate,y_posInterpolate);
    light_history=1./exp(40*(0.2-y_posInterpolate))*2000;
%     [pks,locs] = findpeaks(light_history,'MinPeakHeight',criticalLightIntensity,'MinPeakProminence',200);
    
 
 
%     t1=xlabel('time(second)')
%     t2=ylabel('light intensity (\mumoles/m2/s)')
%     set(t1,'FontSize',32);
%     set(t2,'FontSize',32);
    
    haha=[timeInterpolate y_posInterpolate light_history];
    above=find(light_history>=criticalLightIntensity);
    out=zeros(length(above),7);
    
    if ~isempty(out)
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
        out(:,5:6)=timeInterpolate(out(:,3:4));
        
        %         out(:,8)= [diff(out(:,5)); NaN]-out(:,7);
        DurationS{e}=out(:,7);
    else
        DurationS{e}=[];
    end
    scatter3(x_posInterpolate(out(:,3)),z_posInterpolate(out(:,3)),y_posInterpolate(out(:,3)),1)
    
    hold on;
    
    axis equal;
end




% plot(timeInterpolate( out(:,3)),light_history( out(:,3)),'*')
% plot(timeInterpolate( out(:,4)),light_history( out(:,4)),'*')
% index=out(:,3:4);
% csvwrite('myFile2.txt',index)