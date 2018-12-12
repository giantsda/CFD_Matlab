function q=gauss_q_rhs(v,local_index)
w=[0.1739274226,   0.3260725774, 0.3260725774,  0.1739274226];
p=[0.0694318442, 0.3300094782, 0.6699905218, 0.9305681558];
q=0;
for i=1:4
    for j=1:4
        q=q+w(i)*w(j)*rhs(p(i),p(j),v,local_index);
    end
end
 
function R=rhs(x,y,v,local_index)
r=shapefun(v,[x y]);
x_r=r(1);
y_r=r(2);
R=fi([x y],local_index(2))*f(x,y)*det(Jacob(v,x,y));

function z=f(x,y)
z=1;
 
