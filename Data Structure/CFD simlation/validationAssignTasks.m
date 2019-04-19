points=[];
%% 1
for z= 0.05:0.05:0.15
    
    for x=[ -85 -65 65 85]
        for y=[ 5    10    15    20    25    30    35    40    45    48]
            points=[points; 1 x y z];
        end
    end
end
%% 2
for z= 0.05:0.05:0.15
    for x=[ -85 -65 0 65 85]
        for y=[ 5    10    15    20    25    30    35    40    45    48]
            points=[points; 2 x y z];
        end
    end
end
%% 3
for z= 0.05:0.05:0.15
    y=0;
    for x=  5:5:50
        points=[points; 3 x y z];
    end
end
%% 4
for z= 0.05:0.05:0.15
    y=0;
    for x=  5:5:50
        points=[points; 4 x y z];
    end
end








% for i=1:length(A)
%     haha(i)=mean(A(1:i,6));
% end
%
%
% plot (A(:,1),haha)