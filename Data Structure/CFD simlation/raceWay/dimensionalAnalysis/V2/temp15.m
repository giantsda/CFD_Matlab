%The length of the straight channel does not significantly change the critical velocity,
%thus the critical vertical velocity is redefined as the 20 percent of the vertical velocity
%in the box that is defined as a rectangle of radius and 2*radius.
 

criticalDistanceS=[];
MainPath='D:\CFD_second_HHD\02212020\130';
cd (MainPath);

UcriticalS=0.06:0.01:0.28;
 
for i=1:56
    % i=49
    caseN=i
    
    Ucritical=results{caseN}.UcriticalS;
    percentage=results{caseN}.percentage;
    Ucritical=[0 Ucritical];
    percentage=[1 percentage];
    
    highEndUcritical = interp1(percentage,Ucritical,0,'spline','extrap')*1.3;
    UcriticalS=0.0:0.002:highEndUcritical;
end