e=525;
criticalLightIntensity=500;
p=particle{e};
time=p(1:6300,1);
x_pos=particle{e}(1:6300,3);
y_pos=particle{e}(1:6300,4);
z_pos=particle{e}(1:6300,5);
time=double(time);
timeInterpolate=[min(time):0.01:max(time)].';
y_posInterpolate = interp1(time,y_pos,timeInterpolate,'spline');
y_posInterpolate=0.2-y_posInterpolate;
y_posInterpolate(y_posInterpolate<0)=0;

plot(timeInterpolate,y_posInterpolate);
light_history=1./exp(40*(y_posInterpolate))*2000;
[pks,locs] = findpeaks(light_history,'MinPeakHeight',criticalLightIntensity,'MinPeakProminence',200);

plot(timeInterpolate,light_history);

hold on;
plot(timeInterpolate(locs),light_history(locs),'o')
t1=xlabel('time(second)')
t2=ylabel('light intensity (\mumoles/m2/s)')
set(t1,'FontSize',32);
set(t2,'FontSize',32);

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
plot(timeInterpolate( out(:,3)),light_history( out(:,3)),'*')
plot(timeInterpolate( out(:,4)),light_history( out(:,4)),'*')
index=out(:,3:4);
csvwrite('myFile2.txt',index)