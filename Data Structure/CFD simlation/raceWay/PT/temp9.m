figure;
set(gcf,'outerposition',get(0,'screensize'));
T = 0.2;
Fs = 1/T;
L = length(particle{1});
t = (0:L-1)*T;
N =L;
Y=0;
frequency=0;
for e=1:5
    e
    time=particle{e}(:,1);
    
    y_pos=particle{e}(:,5);
    y_pos=surfaceHeight-y_pos;
    light_history=1./exp(40*(y_pos)) *2000;
    
%     plot(light_history);
    Y1 = fft(light_history);
%     Y=Y1/N*2;
    Y=Y+Y1;
%     f = Fs/N*(0:1:N-1);
%     A = abs(Y1);
%     %     frequency=A(1:N/2);
%     %     plot(f(1:N/2),frequency)
%     
%     frequency=frequency+A(2:N/2);
% %     plot(f(1:N/2-1),frequency/e);
%     plot(abs(Y(2:end))/e);
%     
%     %       scatter(f(1:N/2),frequency,1.5,'filled')
%     %       hold on;
% %     ylim([0 0.02])
%     pause(0)
end

Y=Y/e;
haha=ifft(Y/e);
plot(time,haha);












