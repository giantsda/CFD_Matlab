%% connect yp;
yp=[];
for i=1:length(particle)
    i
    e=randi([1 number]);
    ypI=particle{e}(:,4)*100;
    yp=[yp; ypI];
end

% time=i*109; %s
% periods=[];
% periods_new=[];
% yp=double(yp);
% [pks,locs]=findpeaks(yp,'MinPeakProminence',10,'MinPeakHeight',22);
% pksnum_i=length(pks);
% time/pksnum_i
% pksnum=[pksnum pksnum_i];
% pks_ave=mean(pksnum);
 