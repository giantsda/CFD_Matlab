Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector
 
f = Fs*(1:L)/L;
S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
Y = fft(S);
% A=abs(Y);
% plot(A);

X2=Y;%store the FFT results in another array
%detect noise (very small numbers (eps)) and ignore them
threshold = max(abs(Y))/10000; %tolerance threshold
X2(abs(X2)<threshold) = 0; %maskout values that are below the threshold
phase=atan2(imag(X2),real(X2))*180/pi; %phase information
plot(f,phase); %phase vs frequencies

  
% y=zeros(1,L);
% % y=y+1e-15i;
% 
% a=abs(Y(76));
% b=Y(181);
% 
% y(76)=a*0.7071+a*0.7071i;
% y(181)=0+b*i;
% y(1321)=y(181);
% y(1426)=y(76);
% B=ifft(y);
% plot( real(B));
% hold on;
% plot(S);
% 
% 
% 
% 
% 
