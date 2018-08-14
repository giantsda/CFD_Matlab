figure;
set(gcf,'outerposition',get(0,'screensize'));
critical_distance=10;
time_interval=[];
pksnum=[];
for e=1:1:number
    e
length_particle=length(particle{e});
    if length_particle ~=0
    periods=[];
    periods_new=[];
    length_particle=length(particle{e});
    time=particle{e}(:,1 );
    xp=100*particle{e}(:,3);
    yp=100*particle{e}(:,4);
    yp=double(yp);
    zp=100*particle{e}(:,5);
    yp=double(yp);
    MinPeakProminence=4;
    [pks,locs]=findpeaks(yp,'MinPeakProminence',MinPeakProminence,'MinPeakHeight',20);
    pksnum_i=length(pks);
    pksnum=[pksnum pksnum_i];
    pks_ave=mean(pksnum);
    plot(time,yp);
    hold on;
    plot(time(locs),yp(locs),'o')
     hold off;
% time_interval=[time_interval;haha];
    end
    pause( )
end
pksnum=pksnum/106*60*10;
hist(pksnum,30);
mean(pksnum)


