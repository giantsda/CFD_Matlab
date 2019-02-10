function bigger=my_compare(a,b)

if length(a)~=length(b)
    fprinftf('ERROR length are different\n');
    return
end
N=length(a);
if a==b
    bigger=2;
    return
end
for i=1:N
    aa=a(i);
    bb=b(i);
    if aa>bb
        bigger=1;
        break;
    end
    if aa<bb
        bigger=0;
        break;
    end
end

end
