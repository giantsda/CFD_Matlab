Ha=4;
c1=0.9;
z=linspace(0,1,1000);
lamda=(sinh(Ha*z)*c1+sinh(Ha*(1-z)))./sinh(Ha);
plot(z,lamda)
(lamda(2)-lamda(1))/(z(2)-z(1))
z=0;
G0=Ha*((cosh(Ha*z)*c1-cosh(Ha*(1-z)))./sinh(Ha))
xlabel('z');
ylabel('lambda')

% S=linspace(0,3.8,100)
% umax=1;
% Ks=0.3
% u=umax*(S./(Ks+S));
% plot(S,u)