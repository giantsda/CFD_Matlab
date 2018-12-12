%  plot3(a(:,1),a(:,2),a(:,3), '.', 'MarkerSize', 3)
figure;
set(gcf,'outerposition',get(0,'screensize'));
%  haha=a;
%  a=a(:,1);
a=data;
 d=3;
 em= zeros(length(a)-d,d);
 for w=1:100000
 for i=1:length(a)-333
     em(i,:)=[a(i)  a(i+w)  a(i+2*w)];
 end
     plot3(em(:,1),em(:,2),em(:,3), '.', 'MarkerSize', 0.3)
     pause(0.01)
%      saveas(gcf,['E:\desktop\temp\a\' num2str(w)  '.jpg']);
 end