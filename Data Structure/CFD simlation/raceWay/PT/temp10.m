figure;
set(gcf,'outerposition',get(0,'screensize'));
T = 0.2;
Fs = 1/T;
L = length(particle{1});
t = (0:L-1)*T;
N =L;
 
frequency=0;
Y1=0;

for e=1:1

time=particle{e}(:,1);

y_pos=particle{e}(:,5);
y_pos=surfaceHeight-y_pos;
light_history=1./exp(40*(y_pos)) *2000;
Y=fft(light_history);
Y1  =Y1+abs(Y);
 
p = pspectrum(light_history)
plot(p);

end
Y1=Y1/5;
Y1(2:end)=Y1(2:end)* 0.7071+Y1(2:end)* 0.7071i;
%     Y=Y+Y1;
%
% % end
%
% Y=Y/e;
haha=ifft(Y1);
plot(time,haha);

