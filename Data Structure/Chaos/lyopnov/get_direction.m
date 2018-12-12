function direnction=get_direction(a,b,embed)
    direnction=embed(a,:)-embed(b,:);
    direnction=direnction/norm(direnction);
end