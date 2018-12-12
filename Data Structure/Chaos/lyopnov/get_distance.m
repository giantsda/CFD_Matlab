function dis=get_distance(a,b,embed)
    p1=embed(a,:);
    p2=embed(b,:);
    dis=sqrt(sum((p1-p2).^2));
end