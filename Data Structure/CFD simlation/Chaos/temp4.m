a=[];
k=1;
for e=1:length(particle)
    a=[a; particle{e}(:,4)];
    k=k+1;
    if k==200
        break;
    end
end