function q=gauss_q_Aij(v,local_index)
w=[0.1739274226,   0.3260725774, 0.3260725774,  0.1739274226];
p=[0.0694318442, 0.3300094782, 0.6699905218, 0.9305681558];
q=0;
for i=1:4
    for j=1:4
        q=q+w(i)*w(j)*Aij(p(i),p(j),v,local_index);
    end
end
 
