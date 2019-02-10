[T,Res]=lyapunov(3,@lorenz_ext,@ode45,0,0.2,2000,[0 1 0],10);
plot(T,Res);
title('Dynamics of Lyapunov exponents');
xlabel('Time'); ylabel('Lyapunov exponents');

