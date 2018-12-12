syms sgm lh;
expr=(lh/3-1)*sgm^2+4/3*lh*sgm+lh/3+1==0;
soln=solve(expr,sgm)
simplify(soln)
taylor(exp(lh)- -(2*lh + 3^(1/2)*(lh^2 + 3)^(1/2))/(lh - 3),lh,'Order',7)


clear;
 step_size=0.1
 syms lh;
p=[];
for Re=-1:step_size:1;
    Re;
    im=sqrt(1-Re^2);
    sgm=Re+im*i;
    eqn=(lh/3-1)*sgm^2+4/3*lh*sgm+lh/3+1==0;
    solx = double(solve(eqn,lh));
     p=[p;real(solx), imag(solx)];
    hold on;
    im=-sqrt(1-Re^2);
%     sgm=Re+im*i;
        eqn=(lh/3-1)*sgm^2+4/3*lh*sgm+lh/3+1==0;
    solx = double(solve(eqn,lh));
    p=[p;real(solx), imag(solx)];
end
plot(p(:,1),p(:,2), 'x');
legend('Stability Contour');
 