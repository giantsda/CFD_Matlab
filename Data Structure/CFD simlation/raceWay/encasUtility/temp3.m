
plot(linspace(1.00218e+02,1.72218e+02,481),absVz,'ko-')

xlabel('flow time (s)');
ylabel('volume percentage');
hold on;
plot(linspace(1.00218e+02,1.72218e+02,481),magU,'kX-')
legend('volume percentage of abs(Uz)>0.1 m/s','volume percentage of mag(U)<0.1 m/s')