% %% This file will convert particles vertical position to light intesity, and statistial
% %% result will be calculated form the light intensity history.
% I believe it first introduce a light intensity function and then use
% findpeaks to find all local peaks with that meets some requirements.
oPath=pwd();
path='D:\CFD_second_HHD\07162021\242\242\800s'
cd(path);
  

result={};

for caseI=[1:40 49:56]
    caseI
    load(['particle_' num2str(caseI) '.mat']);    particle=Data.particle;
    number=Data.number;
    waterDepth=Data.waterDepth;
    residenceTimeI={};
    for e=1:number
        if mod(e,floor(number/100))==0
            fprintf("%d Percent\n",floor(e/floor(number/100)));
        end
        if ~isempty (particle{e})
            x_pos=particle{e}(:,3);
            time=particle{e}(:,1);
            time=double(time);
            y_pos=particle{e}(:,4);
            z_pos=particle{e}(:,5);
                paddleTime=[];
            for i=2:length(x_pos)
                if (y_pos(i)<0&&x_pos(i-1)>0&&x_pos(i)<0)
                    paddleTime=[paddleTime; time(i) ];
                end
            end
            residenceTimeI{e}=diff(paddleTime);   
        end
    end
    
    residenceTime=vertcat(residenceTimeI{:});
    residenceTime(residenceTime<15)=[];
    [counts,centers] = hist(residenceTime,200);
    [m i]=max(counts);
    residenceTimeCase(caseI)=centers(i);
end
 
plot(residenceTimeCase)