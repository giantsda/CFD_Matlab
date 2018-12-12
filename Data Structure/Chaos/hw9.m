function hw9
lamda=[0,1,2;2,3.2361,3.4986;4,4,4;0,0,0;0,0,0];
lamda_inf_guess=4;
for p=3:10
delta=(lamda(2,end-1)-lamda(2,end-2))/(lamda(2,end)-lamda(2,end-1));
lamda_inf=fsolve(@solve_lamda_inf,lamda_inf_guess,[],lamda,delta);
lamda_guess=(lamda(2,end)-lamda(2,end-1))/delta+lamda(2,end);
x=fsolve(@solve_lamda,lamda_guess,[],p);
x=roundn(x,-(p+2));
lamda=[lamda [p;x;p+2;delta;lamda_inf]];
end
for i=4:length(lamda)
fprintf(['for lamda(%d), delta=%0.4f,  lamda(%d)=%0.' num2str(lamda(3,i)) 'f lamda_inf=%0.6f \n'],lamda(1,i),lamda(4,i),lamda(1,i),lamda(2,i),lamda(5,i));
end
function y=solve_lamda(u,p)
y=1/2;
for i=1:2^p
y=u*y*(1-y);  
end
y=y-0.5;
function y=solve_lamda_inf(x,lamda,delta)
y=(x-lamda(2,end-1))/(x-lamda(2,end))-delta;
 