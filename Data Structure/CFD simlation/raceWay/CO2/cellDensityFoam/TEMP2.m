% %% This file will convert particles vertical position to light intesity, and statistial
% %% result will be calculated form the light intensity history.
% I believe it first introduce a light intensity function and then use
% findpeaks to find all local peaks with that meets some requirements.

% a=0.058;
% interval=zeros(1,2000000);
% i=1;
% for e=1:number
%     e
%     y_pos=particle{e}(:,5);
%     y_pos=max(y_pos)-y_pos;
%     time=particle{e}(:,1);
%
%     light_history=1./exp(40*(y_pos)) *2000;
%
%     time=double(time);
%     timeS=112:0.1:1000;
%     light_historyS=interp1(time,light_history,timeS,'spline');
%     pid=fopen('C:\Users\Chen\Desktop\light.txt','w+');
%     fprintf(pid,'%f, ',light_historyS);
%  fclose(pid);
% end


j=1;
i=1;
a=single(a);
pid=fopen('C:\Users\Chen\Desktop\light2.txt','w');
flag=0;
aaa=1;

while i<=length(a)
    fprintf(pid,'%d:',j);
    for ii=1:300。00
        fprintf(pid,'%f, ',a(i));
        i=i+1;
        if i==length(a)
            flag=1;
            break;
        end
    end
    if flag==1
        break;
    end
    fprintf(pid,'\n'); 
    j=j+1
end
fclose(pid);

