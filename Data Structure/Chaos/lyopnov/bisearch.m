function R=bisearch (data,want)
N=length(data);
d=size(data);
d=d(2);
want=want(1:d);
low=1;
high=N;
R=[];
while low<=high
    middle = round((low + high)/2);
    middle_val=data(middle,:);
    middle_val=middle_val(1:d);
    if my_compare(middle_val,want,d)==2
        R=middle;
        break;
    elseif my_compare(middle_val,want,d)==0   % x(mid) < want
        low=middle+1;
    else              % x(mid) > want
        high=middle-1;
    end
end
end

function bigger=my_compare(a,b,d)
if  isequal(a,b)
    bigger=2;
    return
end
for i=1:d
    if a(i)>b(i)
        bigger=1; % is bigger, bigger==1
        return;
    end
    if a(i)<b(i)
        bigger=0; % is not bigger, bigger==0
        return;
    end
end
end
