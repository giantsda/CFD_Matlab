for i=1:length(resultsnew)
     if ~isempty(resultsnew{i})
 
     Ucritical=resultsnew{i}.UcriticalS;
     percentage=resultsnew{i}.percentage;
%      index=find(percentage==0);
%      resultsnew{i}.UcriticalS(index)=[];
%      resultsnew{i}.percentage(index)=[];
     plot(Ucritical,percentage);
     hold on;
     end
end
