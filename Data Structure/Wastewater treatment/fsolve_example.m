 function [e1, e2, check] = fsolve_example(T)
    T=600
    params = T;
    x0 = [0.1, 0.1];
    opts = [];
    soln = fsolve(@eqns, x0, opts, params);
    CLOSE_ENOUGH_TO_ZERO = 1E-9;
    check = all(abs(eqns(soln, params)) <= CLOSE_ENOUGH_TO_ZERO);
    e1 = soln(1); 
    e2 = soln(2);
 end
 
function [resid] = eqns(x, params)
    e1 = x(1); e2 = x(2);
    T = params;
    r1 = log(e1*e1/(1-e1-e2))-log(0.1)+60291/8.314*(1/T-1/600); 
    r2 = log(e2/(1-e1-e2))-6401/8.314*(1/T-1/600);
    resid = [r1; r2];
end