%% RK2
for N=1:1000
    T=-log(0.25);
    h=T/N;
    l=-1;
    sgm=1+l*h+(l*h)^2/2;
    err_l=exp(l*T)-sgm^N;
    if abs(err_l/exp(l*T))<=0.005
        break;
    end
end
fprintf('N=%d  h=%0.5f   sgm1=%0.7f  Fev=%d  err=%0.7f \n ',N,h,sgm,N*2,err_l)


%% RK3
for N=1:1000
    T=-log(0.25);
    h=T/N;
    l=-1;
    sgm=1+l*h+(l*h)^2/2+1/6*(l*h)^3;
    err_l=exp(l*T)-sgm^N;
    if abs(err_l/exp(l*T))<=0.005
        break;
    end
end
fprintf('N=%d  h=%0.5f   sgm1=%0.7f  Fev=%d  err=%0.7f \n ',N,h,sgm,N*3,err_l) 


%% Convection
clear i;
%% RK2 K=100
T=10;
h1=0.1;
K=100;
k=2;
N=K/k;
h1=T/N;
lamda=i;
w=1;
l=i;
sgm1=1+l*h1+(l*h1)^2/2;
Amp=(abs(sgm1))^(N);
N*atan(imag(sgm1)/real(sgm1));
Erw=(w*T-N*atan(imag(sgm1)/real(sgm1)))/pi*180;
fprintf('Amp=%0.5f   Erw=%0.3f \n ',Amp,Erw);

%% RK2 K=50
T=10;
h1=0.1;
K=50;
k=2;
N=K/k;
h1=T/N;
lamda=i;
w=1;
l=i;
sgm1=1+l*h1+(l*h1)^2/2;
Amp=(abs(sgm1))^(N);
N*atan(imag(sgm1)/real(sgm1));
Erw=(w*T-N*atan(imag(sgm1)/real(sgm1)))/pi*180;
fprintf('Amp=%0.5f   Erw=%0.3f \n ',Amp,Erw);

%% RK3 K=100
T=10;
h1=0.1;
K=100;
k=3;
N=K/k;
h1=T/N;
lamda=i;
w=1;
l=i;
sgm1=1+l*h1+(l*h1)^2/2+1/6*(l*h1)^3;
Amp=(abs(sgm1))^(N);
N*atan(imag(sgm1)/real(sgm1));
Erw=(w*T-N*atan(imag(sgm1)/real(sgm1)))/pi*180;
fprintf('Amp=%0.5f   Erw=%0.3f \n ',Amp,Erw)


%% RK3 K=50 
T=10;
h1=0.1;
K=50;
k=3;
N=K/k;
h1=T/N;
lamda=i;
w=1;
l=i;
sgm1=1+l*h1+(l*h1)^2/2+1/6*(l*h1)^3;
Amp=(abs(sgm1))^(N);
N*atan(imag(sgm1)/real(sgm1));
Erw=(w*T-N*atan(imag(sgm1)/real(sgm1)))/pi*180;
fprintf('Amp=%0.5f   Erw=%0.3f \n ',Amp,Erw)