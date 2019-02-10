function [closep, d_small, sita_s,bad,new_dismax]=find_close(embed,box_index,oldp,newp,box_finder,box_neighbour,dismax,dismin,evolve,sita_max,t,dim)
boxs=get_neighbour(oldp,box_index,box_neighbour,box_finder,dim);
d_small=Inf;
val_small=Inf;
sita_s=NaN;
closep=NaN;
bad=0;
new_dismax=dismax;
% if oldp==51
% hhh=1
% end
if newp==0
    for i=1:length(boxs)
        if boxs(i)~=oldp && boxs(i)<=length(embed)-evolve*3
            if  boxs(i)-oldp <=2*t  && boxs(i)-oldp >0
                continue;
            end
            disold=get_distance( boxs(i),oldp,embed);
            if disold<=d_small  && dismin<=disold && disold<=dismax
                d_small=disold;
                closep=boxs(i);
            end
        end
    end
else
    direction1=get_direction(newp,oldp,embed);
    for i=1:length(boxs)
        if boxs(i)~=oldp && boxs(i)<=length(embed)-evolve*3
%             if boxs(i)==14527
%                 i
%             end         
            if  boxs(i)-oldp <=2*t  && boxs(i)-oldp >0
                continue;
            end
            disold=get_distance( boxs(i),oldp,embed);
            if  dismin<=disold && disold<=dismax
                direction2=get_direction(boxs(i),oldp,embed);
                sita=acos(direction1*direction2.')/pi*180;
                if sita>90
                    sita=180-sita;
                end
                if sita<=sita_max && sita*disold^1.76<= val_small
                    val_small=sita*disold^1.76;
                    closep=boxs(i);
                    sita_s=sita;
                end
            end
        end
    end
end

%%
if isnan(closep)==1
    bad=1;
    if newp==0  % will this happen???
        d_small=Inf;
        for i=1:length(boxs)
            if boxs(i)~=oldp && boxs(i)<=length(embed)-evolve*3
                if  boxs(i)-oldp <=2*evolve  && boxs(i)-oldp >0
                    continue;
                end
                disold=get_distance( boxs(i),oldp,embed);
                if disold<=d_small
                    closep=boxs(i);
                    d_small=disold;
                end
            end
        end
    else
        d_small=inf;
        for i=1:length(boxs)
            %         if i==3765
            %             i;
            %         end
            if boxs(i)~=oldp && boxs(i)<=length(embed)-evolve*3
                if  (boxs(i)-oldp <=2*t  && boxs(i)-oldp >-2*t)%%||(boxs(i)==newp)
                    continue;
                end
                disold=get_distance(boxs(i),oldp,embed);
                if dismin<=disold &&  disold<=d_small
                    d_small=disold;
                    closep=boxs(i);
                    direction2=get_direction(boxs(i),oldp,embed);
                    sita=acos(direction1*direction2.')/pi*180;
                    if sita>90
                        sita=180-sita;
                    end
                     if isreal(sita)==0
                        sita=Inf;
                    end
                    sita_s=sita;
                end
            end
        end
    end
end


%%
if isnan(closep)==1
    return;
    % else
    %     if newp~=0 && bad==1
    %         if get_distance(oldp,closep,embed)/get_distance(oldp,newp,embed)>=2
    %             closep=newp;
    %         end
    %     end
end
new_dismax=get_distance(closep,oldp,embed);
d_small=get_distance(closep,oldp,embed);



function boxs=get_neighbour(oldp,box_index,box_neighbour,box_finder,dim)
oldp_index=box_index(oldp,1:end-1);
% dim=4;
boxs=[];
bi=dec2base(0:3^dim-1,3);
[column,row]=size(bi);
h=zeros(column,row);
for ii=1:column
    for jj=1:row
        h(ii,jj)=str2double(bi(ii,jj));
    end
end
h=h-1;
for i=1:length(oldp_index)
    h(:,i)=h(:,i)+oldp_index(i);
end
for i=1:length(h)
    R=bisearch(box_finder,h(i,:));
    boxs=[boxs box_neighbour{R}];
end




% if boxs(i)~=oldp && boxs(i)<=length(embed)-evolve*3
%     if  (boxs(i)-oldp <=2*evolve  && boxs(i)-oldp >-2*evolve)||(boxs(i)==newp)
%         continue;
%     end
%     disold=get_distance( boxs(i),oldp,embed);
%     scale=disold/dismax;
%     if dismin<=disold && scale>=0.3 && scale<=3
%         direction2=get_direction(boxs(i),oldp,embed);
%         sita=acos(direction1*direction2.')/pi*180;
%         if sita>90
%             sita=180-sita;
%         end
%         if  sita*disold<= val_small
%             val_small=sita*disold;
%             closep=boxs(i);
%             sita_s=sita;
%         end
%     end
% end