%  [closep, d_small, sita_s,bad,new_dismax]=find_close2(embed,box_index,989,15543,box_finder,box_neighbour,dismax,dismin,t,forward,sita_max);
%  closep
oldp=211;
newp=80276;
boxs=get_neighbour(oldp,box_index,box_neighbour,box_finder);
d_small=Inf;
sita_small=Inf;
closep=NaN;
bad=0;
new_dismax=NaN;
direction1=get_direction(newp,oldp,embed);
haha=73473;
if haha~=oldp && haha<=length(embed)-evolve*3
    disold=get_distance( haha,oldp,embed)
    direction2=get_direction(haha,oldp,embed);
    sita=acos(direction1*direction2.')/pi*180;
end
if sita>90
    sita=180-sita;
end
sita
