function R=dfi(xx,location)
% location determine which gadientfi to return
%  4   3
%  1   2
x=xx(1);
y=xx(2);
switch location
    case 1
        R=(1-x)*(1-y);
    case 2
        R=(1+x)*(1-y);
    case 3
        R=(1+x)*(1+y);
    case 4
        R=(1-x)*(1+y);
    otherwise
        pause
        location
        error('wrong position');
end