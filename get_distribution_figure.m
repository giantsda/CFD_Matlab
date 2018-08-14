path='C:\Users\chenshen\Desktop\CFD\Result validation\41\water';
fac= importdata('C:\Users\chenshen\Desktop\CFD\Result validation\41\water\water design.xlsx');
factor=fac.data(:,12);
ii=1;
for i=100:100:1000
name=num2str(i)
finame=[path '\' name '_9.0s' '\' name '.xls']
data = importdata(finame);
lig=data(:,2)/factor(ii);
%             hist(lig,300)
%             xlabel('Total light intensity');
%             ylabel('repeat times');
%             title(['Light distribution of\_' name ]);
%             xlim([0 1])
%             saveas(gcf,['C:\Users\chenshen\Desktop\temp\no escape\' num2str(ii)  '.jpg']);
s=size(lig);
s=s(1);
ligh=[];
for j=1:1:s
   if lig(j) >  0.01
     ligh=[ligh lig(j)];
   end
end
hist(ligh,300)
xlabel('Total light intensity');
ylabel('repeat times');
title(['Light distribution of \_particles larger than 0.01\_\_' name]);
xlim([0 1])
saveas(gcf,['C:\Users\chenshen\Desktop\temp\no escape\' num2str(ii)  '_0.01.jpg']);
ii=ii+1;
end
