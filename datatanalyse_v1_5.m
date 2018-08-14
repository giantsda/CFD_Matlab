% v1.5 modified at 01/06 use medium time instead of average. timelimitfactor=0.9;
% v1.4 modified at 01/02 sive 2 figures
% v1.3 modified at 01/01 add the second figure where the solution is small than 0.01 is deleted; add file_path
% v1.2 modified at 11/24 add timefactor
% v1.1 modified at 11/23 because not all the particles have the same time period
% v1.0 modified at 11/23 because I choose to delete gas first and then calcuate
% the average time and introduce timelimit
%%%  %%%  %%   %%%  %%%  %%%  %%   %%%%%%  %%%  %%   %%%%%%  %%%  %%   %%%   read  %%%  %%%  %%   
clc
clear % already use  i,j,a,b,c,d,e,f,g,h,i
timelimitfactor=0.9;
%                                     llll='13000';
%                                     folder_path=['C:\Users\chenshen\Desktop\CFD\Result validation\41\water\' llll '_9.0s'];
%                                     file_name=llll;
folder_path='E:\desktop\CFD\01212016\81';
file_name='81';
filename1 = [folder_path '\' file_name '.his'] 
% filename1='C:\Users\chenshen\Desktop\CFD\Result validation\41\water\5000\5000.txt';
%% read .his file
delimiterIn = '\t'; %read txt file
headerlinesIn = 13;
data = importdata(filename1,delimiterIn,headerlinesIn);
    particletime=data.data(:, 1); %store data into column vecter;
    particleid=data.data(:, 2);
    xposition=data.data(:, 3);
    yposition=data.data(:, 4);
    zposition=data.data(:, 5);
    colour=data.data(:, 6); % 1.0for water, 0.0 for gas
    ber=size(particleid);%find how manys rows do I have ; ber is a vecter
    rownumber=ber(1);
%% find out the number of particle put information into particle
number_m=1; %number of different particle
for i=1:1:rownumber-1
    if particleid(i) ~= particleid(i+1)
        number_m=number_m+1;
    end
end  
particle=cell(1,number_m);  %create number matrixs to store my data,called particle{1}, particle{2}...particle{number}
j=1; %calculate times of jth particle repeating
repeat=ones(1,number_m); %k is a 1*number vector used to record repeat times 
for i=1:1:rownumber-1
    if particleid(i)== particleid(i+1)
        repeat(j)=repeat(j)+1;
    else
        j=j+1;
    end
end
c=0;
for a=1:1:number_m  %for ath partocle
   for b=1:1:repeat(a) %store line data for repeat(a) times 
    particle{a}(b,1)=particletime(c+1);
    particle{a}(b,2)=particleid(c+1);
    particle{a}(b,3)=xposition(c+1);
    particle{a}(b,4)=yposition(c+1);
    particle{a}(b,5)=zposition(c+1);
    particle{a}(b,6)=colour(c+1);
    c=c+1;
   end  
end % here, all data are restored in particle
fprintf('store all data to particle.............. \n');
% %% delete gas
% gas=[];
% for d=1:1:number_m         % creat gas vecter to store particle ID which is gas finally.
%    matrixsize=size(particle{d});
%    matrixsize=matrixsize(1);
%    if matrixsize ~=0 && particle{d}(end) <=0.1
%       gas=[gas particle{d}(1,2)];
%       particle{d}=[];
%    end
% end
% %% generate time vector find out timelimit, delete the small time particles
% timevector=[];
% for d=1:1:number_m         % calcuate the avarage time period
%     matrixsize=size(particle{d});
%       matrixsize=matrixsize(1);
%      if matrixsize ~=0
%             time=particle{d}(:,1);
%             time=time(end);
%             timevector=[timevector time];
%             d=d+1;
%      end
% end
% mediumtime=median(timevector);
% timelimit=timelimitfactor*mediumtime;
% del=0;% how many particles I have deleted
% for d=1:1:number_m % calcuate the avarage time period
%      matrixsize=size(particle{d});
%       matrixsize=matrixsize(1);
%      if matrixsize ~=0
%         time=particle{d}(:,1);
%         time=time(end);
%             if time <timelimit
%                 particle{d}=[];   %delete  the particle if the time period is less than 0.8*average
%                 del=del+1;
%             end
%      end
% end
% %% integrate for light intensity, store the result into light
% light=[];    % initialize result
%  for e=1:1:number_m
%      matrixsize=size(particle{e});
%       matrixsize=matrixsize(1);
%      if matrixsize ~=0
%         id=particle{e}(1,2);
%         lightintegral=0;  %initial interal 
%         f=0;
%             for f=1:1:matrixsize-1
%                   if particle{e}(f,1) <= timelimit
%                         timestep=(particle{e}(f+1,1)-particle{e}(f,1)); % timestep=t2-t1
%                         y1=100*particle{e}(f,4);  %store z position                          
%                         y2=100*particle{e}(f+1,4);%store z position
%                         x1=100*particle{e}(f,3);%convert m to cm
%                         x2=100*particle{e}(f+1,3);%convert m to cm
%                         z1=100*particle{e}(f,5);%convert m to cm
%                         z2=100*particle{e}(f+1,5);%convert m to cm
%                         light1=1.2/(exp(3*(x1)));   %state the light function           
%                         light2=1.2/(exp(3*(x2)));  %state the light function        
% %                             light1=get_light(x1,y1,10);
% %                             light2=get_light(x2,y2,10);
% %                                                             light1=1.2/(exp(3*(z1)));   %state the light function           
% %                                                             light2=1.2/(exp(3*(z2)));  %state the light function  
%                             integral=(light1+light2)*timestep/2;  %integral
%                             lightintegral=lightintegral+integral;
%                   else
%                   break;
%                   end
%               end
%      lightin=[id; lightintegral] ;%create a column vector so I can add it to vector [light]
%      else
%          lightin=[ ];
%      end
%       light=[light lightin]; %store light history into vecter light
%  end
%  %% report
% avetimestep=mediumtime;%(particle{1}(i,1)-particle{1}(1,1))/i;
% gaslenth =size(gas);
% gaslenth=gaslenth(1,2);
% left=size(light);
% left=left(2);
% maxintegral=1.2*timelimit;
% sma=0;      
% for i=1:1:left
%    if light(2,i) <=  maxintegral*0.01
%        sma=sma+1;
%    end
% end
% light_001=[];
% for i=1:1:left
%    if light(2,i) >  maxintegral*0.01
%       light_001=[light_001 light(:,i)];
%    end
% end
% %%
% x=light(1,:);    
% y=light(2,:)/maxintegral;
% average=mean(y); %calcuate average
% variance=var(y); % calcuate variance
%     [ma,g]=max(y); % find the largest one `
%     g=light(1,g);
%     [mi,h]=min(y); % find the smallest one    
%     hh=light(1,h);
% figure(1);
% nbins =300;    %define figure elements
% histfit(y,nbins);  % generate a figure of light distribution
% xlabel('Total light intensity');
% ylabel('repeat times');
% title(['Light distribution of_' file_name]);
%     saveas(gcf,[folder_path '\' 'Light distribution of_' file_name  '.jpg']);
% figure(2);
% x_001=light_001(1,:);    
% y_001=light_001(2,:)/maxintegral;
% histfit(y_001,nbins);  % generate a figure of light distribution
% xlabel('Total light intensity');
% ylabel('repeat times');
% title(['Light distribution of_particles larger than 0.01\_\_' file_name]);
%     saveas(gcf,[folder_path '\' 'Light distribution of_particles larger than 0.01__of ' file_name  '.jpg']);
% %%
% diary([folder_path '\' 'Report of'  file_name  '.txt'])
% report1 = 'In this case %2.0f particles are tracked which %2.0f of them are escaped.Medium time step is %5.6fs  \n';
% fprintf(report1,number_m,gaslenth,avetimestep)
% report2 = '%2.0f particles are deleted because the time period is less than %2.2f *Medium. Total line number is %6.0f \n';
% fprintf(report2,del,timelimitfactor,rownumber)
% report3= 'integration time period is %5.6fs. there are %3.0f particles left \n';
% fprintf(report3,timelimit,left)
% report4 = 'The average of total light intensity is<<%4.5f>>. The variance is %4.5f; \nThe largest one is %4.5f of ID %4.0f; The smallest one is %4.5f of ID %4.0f. \n';
% fprintf(report4,average,variance,ma,g,mi,hh)
% report5 = 'The light intensity function is  __light1=1.2/(exp(300*x))__ maxium integral is%5.6f. \n';
% fprintf(report5,maxintegral)
% report6= 'The average over the maxium integral is<<%4.5f>> and%5.0f particles (%5.2fpercent) are smaill than 0.01*max \n';
% fprintf(report6,average,sma,sma/left*100)
% lightxls=light.';
%  
%                                                 % % x=light(1,:);    
%                                                 % % y=light(2,:)/maxintegral;
%                                                 % % 
%                                                 % % [ns mm] = hist(y, nbins)
%                                                 % % hold on;
%                                                 % % plot (mm,ns);  
% 
% name= [folder_path '\' file_name '.xls'];
% xlswrite (name,lightxls); % generate a column excel file to save ID and Light
% diary off