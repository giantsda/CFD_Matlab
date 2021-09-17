folder='C:\Users\chenshen.ETS01297\Desktop\Papers\Vortex generator\Figures\Case*.png';
files=dir(folder);
for i=1:length(files)
    file=files(i).name
    fig=imread(['C:\Users\chenshen.ETS01297\Desktop\Papers\Vortex generator\Figures\' file]);
%     imshow(fig);
    haha=fig(2733:3551,906:15060,:);
%     imshow(haha);
    imwrite(haha,['C:\Users\chenshen.ETS01297\Desktop\Papers\Vortex generator\Figures\' file]);
end

 
% print(gcf,['D:\CFD_second_HHD\06232021\204\Data\Case_' num2str(caseN) '_Ucritical=' num2str(Ucritical) '.png'],'-dpng','-r800'); 