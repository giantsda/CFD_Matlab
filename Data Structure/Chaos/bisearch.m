function R=bisearch (data,want,m)
N=length(data);
d=size(data);
d=d(2);
low=1;
high=N;
R=[];
while low<=high
    middle = round((low + high)/2);
    middle_val=data(middle,:);
    middle_val=middle_val(1:d-1);
    if my_compare(middle_val,want,m)==2
        R=middle;
        break;
    elseif my_compare(middle_val,want,m)==0   % x(mid) < want
        low=middle+1;
    else              % x(mid) > want
        high=middle-1;
    end
end
end

function bigger=my_compare(a,b,m)
% aa= a>=b;
% bb=a<=b;
% k=1;
% c=0;
% d=0;
% for i=length(aa):-1:1
%     c=c+aa(i)*k;
%     d=d+bb(i)*k;
%     k=k*10;
% end
% c= str2num(strrep(num2str(a>=b),' ',''));
% d= str2num(strrep(num2str(a<=b),' ',''));
% if c>d
%     bigger=1;
% elseif c==d
%     bigger=2;
% else
%     bigger=0;
% end

if  isequal(a,b)
    bigger=2;
    return
end
for i=1:m
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
