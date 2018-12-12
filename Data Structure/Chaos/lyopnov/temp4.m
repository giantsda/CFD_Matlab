cc=find(out(:,2)>0.3);
bad=out(cc,5);
bad(:,3)=out(cc,6);
boxs=1:length(embed);
for j=1:length(bad)
    dis_s=zeros(1,length(embed));
    j
    dsmall=Inf;
    for i=1:length(boxs)
        if boxs(i)~=bad(j) && boxs(i)<=length(embed)-evolve*3
            dis=get_distance(bad(j),boxs(i),embed);
            if dis>0 && dis<=dsmall
                dsmall=dis;
                smallest=boxs(i);
            end
        end
    end
    %      smallest=min(dis_s);
    bad(j,2)=smallest;
end

find(bad(:,2)~=bad(:,3))