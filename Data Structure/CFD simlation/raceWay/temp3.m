Un=linspace(0.039,0.07,100);
Pn=[];
for i=1:length(Un)
    Pn(i)= getP(Un(i),Data,UcriticalPercentage);
end
plot(Un,Pn);
tol=1e-6;
Solution = bisection(@getP,0,1,tol,Data,UcriticalPercentage)

function Percentage=getP(Ucritical,Data,UcriticalPercentage)
% Ucritical
for n=1:length(Data)
    U=Data.U{n};
    P(n)=length(find(U>Ucritical))/length(U);
end
Percentage=(mean(P)-UcriticalPercentage)
fprintf("Tried %0.8f and got %0.8f\n",Ucritical,Percentage);
end


function p = bisection(f,a,b,tol,varargin)
% provide the equation you want to solve with R.H.S = 0 form.
% Write the L.H.S by using inline function
% Give initial guesses.
% Solves it by method of bisection.
% A very simple code. But may come handy
if f(a,varargin{1},varargin{2})*f(b,varargin{1},varargin{2})>0
    disp('Wrong choice bro')
else
    p = (a + b)/2;
    err = abs(a-b);
    while err > tol
        if f(a,varargin{1},varargin{2})*f(p,varargin{1},varargin{2})<0
            b = p;
        else
            a = p;
        end
        p = (a + b)/2;
        err = abs(a-b);
    end
end
end

