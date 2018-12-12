% sigma=16;
% beta=4;
% rho=32;

rho = 28.0
sigma = 10.0
beta = 8.0 / 3.0

f = @(t,a) [-sigma*a(1) + sigma*a(2); rho*a(1) - a(2) - a(1)*a(3); -beta*a(3) + a(1)*a(2)];
[t,a] = ode45(f,[0:0.01:20000],[[-8.76726530834437,-13.5065728864191,19.4839922191773]]); 
a=a(10000:end,1);
save('Lorenz_28_more.mat','a');

 fileID = fopen('Lorenz_28_more.txt','w');
fprintf(fileID,'%f\n',a);
fclose(fileID);