figure;
set(gcf,'outerposition',get(0,'screensize'));
T = 0.2;
Fs = 1/T;
L = length(particle{1});
t = (0:L-1)*T;
N =L;

frequency=0;
for i=1:length(particle)
    i
    yp=particle{i}(:,4);
    yp=yp-mean(yp);
    Y1 = fft(yp,N);
    Y=Y1/N*2;
    f = Fs/N*(0:1:N-1);
    A = abs(Y);
%     frequency=A(1:N/2);
%     plot(f(1:N/2),frequency)

    frequency=frequency+A(1:N/2);
    plot(f(1:N/2),frequency/i)
    %       scatter(f(1:N/2),frequency,1.5,'filled')
    %       hold on;
    ylim([0 0.02])
    pause(0 )
end