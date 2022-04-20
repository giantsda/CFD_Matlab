xq=span;
vq2 = interp1(a,b,xq,'spline');
plot(a,b,'o',xq,vq2,':.');
Crate=diff(vq2)./diff(xq);
plot(xq(1:end-1),rate)

interfaceratte=rate*0.47/12+Crate.';
plot(N(1:36000),interfaceratte(1:36000))




