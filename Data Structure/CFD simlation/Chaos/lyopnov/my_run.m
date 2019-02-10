% clc; clear all; close all; format compact;
%[99970,0.0512494864064608,0.0201798184312819,1.93184344823590,99961,93600]
load('Lorenz_32_more.mat');
% load('Lorenz_28_more.mat');
% a=a(1:3000);
data=a;
dismax_s = 0.3;
dismin = 0.001;
sita_max=30;
dt=0.01;
t=10;
evolve=10;
dim=4;
haha=[];
badd=0;
tag=0;
[embed,box_finder,box_neighbour,box_index]=data_generator(data,t,dim,dismax_s);
out=zeros(2*length(embed),6);
SUM=0;
j=1;
for oldp=1:1
    newp=0;
    dismax=dismax_s;
    [closep, d_small, sita_s]=find_close(embed,box_index,oldp,newp,box_finder,box_neighbour,dismax,dismin,evolve,sita_max,t,dim);
    newp=closep;
    disold = get_distance(newp,oldp,embed);
    disnew=get_distance(newp+evolve,oldp+evolve,embed);
    while oldp<=length(embed)-evolve*2
        while(dismin<=disold && disold<=dismax)
            dismax=dismax_s;
            SUM = SUM+log(disnew/disold);
            zlyap = SUM/(j*evolve*dt);
            out(j,:) =[j*evolve, disold, disnew, zlyap,oldp,newp];
%             if j==251
%                 j
%             end
            j=j+1;
            if mod(j,100)==1
                clc
                fprintf('%% %f \n',100*j/length(embed)*evolve);
            end
            oldp=oldp+evolve;
            newp=newp+evolve;
            if oldp>=length(embed)-evolve || newp>=length(embed)-evolve
                break;
            end
            disold = get_distance(newp,oldp,embed);
            disnew=get_distance(newp+evolve,oldp+evolve,embed);
        end
        %%
        if oldp>=length(embed)-evolve*2
            break;
        end
        [closep, d_small, sita_s,bad,new_dismax]=find_close(embed,box_index,oldp,newp,box_finder,box_neighbour,dismax,dismin,evolve,sita_max,t,dim);
        if bad==1
            haha=[haha;[oldp closep, d_small, sita_s]];
            dismax= new_dismax;
        else
            dismax=dismax_s;tag=0;
        end
        if isnan(closep)~=1
            newp=closep;
        else
            while isnan(closep)==1
                oldp=oldp+evolve;
                if oldp>=length(embed)-2*evolve
                    break;
                end
                newp=0;
                [closep, d_small, sita_s,bad,new_dismax]=find_close(embed,box_index,oldp,newp,box_finder,box_neighbour,dismax,dismin,evolve,sita_max,t,dim);
            end
            haha=[haha ; [oldp closep, d_small, sita_s]];
            newp=closep;
            dismax= new_dismax;
        end
        if isnan(newp)==1
            break;  % closep is always NaN until oldp is too large
        end
        disold = get_distance(newp,oldp,embed);
        disnew=get_distance(newp+evolve,oldp+evolve,embed);
    end
end

%%
for i=length(out):-1:1
    if  isempty(nonzeros(out(i,:)))==0 % is not empty
        break
    end
end
out(i+1:end,:)=[];
plot(out(:,4))
out(end,4)
out_mine=out;

% ylim([1 2]);
% haha=out(:,3)./out(:,2);
% hist(haha,300);
