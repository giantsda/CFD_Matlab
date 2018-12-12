%% shape fun
function out=shapefun(v,in)
out=f1(in,v)+f2(in,v)+f3(in,v)+f4(in,v);

function out=f1(in, v)
v1=v(1,:);
x=in(1);
y=in(2);
out=v1*(1-x)*(1-y);

function out=f2(in, v)
v2=v(2,:);
x=in(1);
y=in(2);
out=v2*x*(1-y);

function out=f3(in, v)
v3=v(3,:);
x=in(1);
y=in(2);
out=v3*x*y;

function out=f4(in, v)
v4=v(4,:);
x=in(1);
y=in(2);
out=v4*(1-x)*y;


