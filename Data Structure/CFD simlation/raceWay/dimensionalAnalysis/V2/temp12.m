%The length of the straight channel does not significantly change the critical velocity,
%thus the critical vertical velocity is redefined as the 20 percent of the vertical velocity
%in the box that is defined as a rectangle of radius and 2*radius.
figure;
set(gcf,'outerposition',get(0,'screensize'));

criticalDistanceS=[];
MainPath='D:\CFD_second_HHD\02212020\130';
% cd (MainPath);

UcriticalS=0.06:0.01:0.28;
% resultsnew={};
for i=1:56
    % i=49
    caseN=i
    if ~isempty(resultsnew{caseN})
        Ucritical=resultsnew{caseN}.UcriticalS;
        percentage=resultsnew{caseN}.percentage;
        plot(Ucritical,percentage,'*-')
        hold on;
    end
end
legend ('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40','41','42','43','44','45','46','47','48','49','50','51','52','53','54','55','56');




