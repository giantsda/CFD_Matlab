ca0=0.02;
k=0.23;
t=[0 3.7 7.4 11.1 14.8 18.5 22.2 25.9 29.6 33.3 37 40.7 44.4 48.1 51.8];
Et=[0 0.0005 0.012 0.0415 0.0627 0.0604 0.0437 0.0259 0.0133 0.0061 0.0026 0.001 0.0004 0.0001 0];
time=linspace(0,51.8,1000);
Et = interp1(t,Et,time,'spline');
sitaa=[];
pcaa=[];
L=length(time);
for i= 1:1:L
    sita=time(i);
    ca=ca0*exp(-k*sita);
    sitaa=[sitaa sita];
    pca=Et(i)*ca;
    pcaa=[pcaa pca];
end
subplot(1,2,1)
plot(time,Et);
xlabel('time(min)');
ylabel('E_t')
subplot(1,2,2)
plot(sitaa,pcaa)
xlabel('time(min)');
ylabel('p(\theta)c(\theta)')
anss=trapz(sitaa,pcaa);
gtext(['the answer is' num2str(anss)])
