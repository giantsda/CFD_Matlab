syms E  l h l mu ;
P=[(exp(mu*h))^(1/3) 0 -(1+h*l/3)  ;-h*l/2*(exp(mu*h))^(1/3)...
    (exp(mu*h))^0.5  -1; 0  -h*l*(exp(mu*h))^0.5  exp(mu*h)-1];
B=simplify(det(P));
Q=P;
Q(:,3)=[h/3;h/2*(exp(mu*h))^(1/3); h*(exp(mu*h))^(1/2)];
eru=det(Q)-det(P)/(mu-l)
taylor(eru,h)

