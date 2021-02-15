% make our noisy function
Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector


S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t)+120;
X = S + 2*randn(size(t));


% plot(t,X)
Y = fft(X);
% plot(real(Y))


P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);


f = Fs*(0:(L/2))/L;
% plot(f,P1) 
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')








y=X;
 
Y = fft(y);

r = 422; % range of frequencies we want to preserve

rectangle = zeros(size(Y));
rectangle(750-r:750+r) = 1;               % preserve low +ve frequencies
rectangle(1) = 1;   
rectangle(end) = 1;    
y_rect = ifft(Y.*rectangle);   % full low-pass filtered signal

hold on;
plot(t,y,'g--'); 
 
plot(t,y_rect,'r','LineWidth',2);
legend('noisy signal','true signal')