function R=Aij(x,y,v,local_i)
J=Jacob(v,x,y);
Jinv=inv(J);
R=(Jinv*(dfi([x y],local_i(3))).').'*(Jinv*(dfi([x y],local_i(4))).')*det(J);

 