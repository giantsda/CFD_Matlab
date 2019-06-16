%% connect yp;
%use Peers_connect.m 
surfaceDepth=25;
lightZone=6; % cm
darkZone=6;% cm
yp=connected_particle(:,1);
yp=double(yp);
yp_s=yp;
time=connected_particle(:,2);
hold on;
plot(time,yp);
a=find (yp>=surfaceDepth-lightZone);
b=find (yp<=(surfaceDepth-lightZone)&yp>=(surfaceDepth-darkZone));
c=find (yp<=surfaceDepth-darkZone);
yp(a)=2;
yp(b)=1;
yp(c)=0;
plot(time,yp);
hold on;
[pks,locs]=findpeaks(yp,'MinPeakHeight',1.5);
locs=[1;locs];
localPeakNum=0;
localPeak=[];
for i=1:length(locs)-1
    t=find(yp(locs(i):locs(i+1))==0);
    if  ~isempty(t)
        localPeak=[localPeak locs(i+1)];
        localPeakNum=localPeakNum+1;
    end
end
localPeakNum
plot(time(localPeak),yp(localPeak),'o');
plot(time(localPeak),yp_s(localPeak),'o');
xlim([0 100])
legend('particle Vertical Position (from bottom)','Trinary vertical history (2: light,1:middle,0:dark)')
timePeriod=connected_particle(end,2)/localPeakNum
% find(yp(202:2317)==0)

