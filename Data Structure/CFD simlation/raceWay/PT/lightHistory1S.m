%% Very kike light_pattern_3, it calculates the distribution of light duration and
%% light intervals for each particle so that we can confirm that after a long time
%% of particle tracking the particles trajectoreies show a very similar pattern.
% clear all;
% load ('D:\CFD_second_HHD\01272021\172\1\particle.mat')
number=length(particle);
timeStepSize=0.2; % seconds
intervalS=cell(1,number);
DurationS=cell(1,number);
peakS=cell(1,number);
criticalLightIntensity=1000;
%% determine the surface hieght by defining it as 98% of the mean(max(verticalPos))
for e=1:number
    y_pos=particle{e}(:,5);
    surfaceHeightS(e)=max(y_pos);
end
surfaceHeight=mean(surfaceHeightS)*0.98


resolution=100;
for e=1:number
    %     if e==2126
    %         e
    %     end
    fprintf('calculating %0.2f %% \n', e/number*100);
    y_pos=particle{e}(:,5);
    y_pos=surfaceHeight-y_pos;
    
    time=particle{e}(:,1);
    time=double(time);
    timeInterpolate=[min(time):0.01:max(time)].';
    y_posInterpolate = interp1(time,y_pos,timeInterpolate,'spline');
    y_posInterpolate(y_posInterpolate<0)=0;
    light_history=1./exp(40*(y_posInterpolate)) *2000;
    plot(timeInterpolate,light_history);
    for j=1:resolution:length(timeInterpolate)-30
        light=trapz(timeInterpolate(j:j+resolution),light_history(j:j+resolution));
        light1S(j:j+resolution)=light;
    end
    hold on;
    plot(timeInterpolate,light1S);
end



