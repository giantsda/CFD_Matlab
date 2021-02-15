Ys=0;
for e=1:111
    fprintf('calculating %0.2f %% \n', e/number*100);
    y_pos=particle{e}(:,5);
    % y_pos=surfaceHeight-y_pos;
    %     max(y_pos)
    time=particle{e}(:,1);
    % plot(time,y_pos);
    % plot(time,light_history);
    
    
    
    light_history=1./exp(40*(y_pos)) *2000;
    Y = fft(y_pos);
    Ys=Ys+abs(Y);
    
    
    
    
    X2=Y;%store the FFT results in another array
    %detect noise (very small numbers (eps)) and ignore them
    threshold = max(abs(Y(2:end)))/100000; %tolerance threshold
    X2(abs(X2)<threshold) = 0; %maskout values that are below the threshold
    phase=atan2(imag(X2),real(X2))*180/pi; %phase information
    stem(phase); %phase vs frequencies
    % histogram(phase,800)
%     plot(Ys(2:end)/e)
    pause();
end
Ys=Ys/e;

plot(Ys);
% Ys(1)=0;
theta=rand(length(Ys),1)*3.14159265358*2;
Ymean=Ys.*sin(theta)+ Ys.*cos(theta)*i;
Ymean(1)=0;
haha=ifft(Ymean);

haha=(haha+0.08)*1.3;
plot(time,haha);
y_pos=surfaceHeight-y_pos;
light_history=1./exp(40*(y_pos)) *2000;
Y = fft(y_pos);

plot(abs(Y(2:end)));



[pks,locs] = findpeaks(light_history,'MinPeakHeight',criticalLightIntensity,'MinPeakProminence',200);


peak_time =time(locs);
peak_time_interval=diff(peak_time);
intervalS=peak_time_interval;
%% light duration
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
    out(:,5:6)=time(out(:,3:4));
    out(:,7)=out(:,6)-out(:,5)+timeStepSize;
    %         out(:,8)= [diff(out(:,5)); NaN]-out(:,7);
    DurationS=out(:,7);
else
    DurationS=[];
end

h1=histogram(intervalS,500,'Normalization','probability','FaceAlpha',0.3);




