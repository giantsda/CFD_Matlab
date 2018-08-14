function unsteady_report (light,number,del,timelimit,folder_path,file_name,line_vector);
left=size(light);
left=left(2);
maxintegral=2000*timelimit;
sma=0;      
for i=1:1:left
   if light(2,i) <  maxintegral*0.01
       sma=sma+1;
   end
end
light_001=[];
for i=1:1:left
   if light(2,i) >  maxintegral*0.01
      light_001=[light_001 light(:,i)];
   end
end 
y=light(2,:)/maxintegral; %nomolize the result
average=mean(y); %calcuate average
variance=var(y); % calcuate variance
[ma,g]=max(y); % find the largest one ` 
g=light(1,g);
[mi,h]=min(y); % find the smallest one    
hh=light(1,h);
%%
figure(1);
nbins = 300;    %define figure elements
hist(y,nbins);  % generate a figure of light distribution
xlabel('Nomorlized total light intensity');
ylabel('repeat times');
title(['Nomorlized Light distribution of ___' file_name ]);
xlim([0 1])
saveas(gcf,[folder_path '\' 'Nomorlized Light distribution of_' file_name  '.jpg']);
%%
% figure(2); 
% y_001=light_001(2,:)/maxintegral;%nomolize the result
% hist(y_001,nbins);  % generate a figure of light distribution
% xlabel('Total light intensity');
% ylabel('repeat times');
% title(['Nomorlized Light distribution of particles larger than 0.01___' file_name ]);
% xlim([0 1])
% saveas(gcf,[folder_path '\' 'Light distribution of_particles larger than 0.01__of ' file_name  '.jpg']);
%%
diary([folder_path '\' 'Report of_'  file_name  '.txt'])
report1 = '>>>>>This is the report of unsteady particle tracking.<<<<< \nIn this case %2.0f particles are tracked.Medium time step is %5.6fs  \n';
fprintf(report1,number,timelimit)
report2 = '%2.0f particles are deleted because they are lost. Total line number is %6.0f \n';
fprintf(report2,del,sum(line_vector))
report3= 'integration time period is %5.6fs. there are %3.0f particles left \n';
fprintf(report3,timelimit,left)
report4 = 'The average of total light intensity is<<%4.5f>>. The variance is %4.5f; \nThe largest one is %4.5f of ID %4.0f; The smallest one is %4.5f of ID %4.0f. \n';
fprintf(report4,average,variance,ma,g,mi,hh)
report5 = 'The light intensity function is  __lightz=10.^(log10(2000)-0.0496*yp)__ maxium integral is%5.6f. \n';
fprintf(report5,maxintegral)
report6= 'The average over the maxium integral is<<%4.5f>> %5.0f particles (%5.2fpercent) are smaill than 0.01*max \n';
fprintf(report6,average,sma,sma/left*100)
lightxls=light.';
%%                                       
name= [folder_path '\' 'light result of_' file_name '.xls'];
xlswrite (name,lightxls); 
diary off
