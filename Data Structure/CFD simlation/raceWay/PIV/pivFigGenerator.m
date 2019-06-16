%% this function generate figs of one frame
function pivFigGenerator(movieFile,path,frameI,frameInterval)
%  files=dir(path)
%  filesLength=length(files)-2;
 I=pivFig(movieFile,path,frameI);
 imwrite(I,[path 'bw_'  num2str(frameI,'%0.5d')  '_A.png']);
 I=pivFig(movieFile,path,frameI+frameInterval);
 imwrite(I,[path 'bw_'  num2str(frameI,'%0.5d')  '_B.png']);
 
 
 
 
function I=pivFig(mov,path,frameI)
frame = read(mov,frameI);
frame=frame(27:784,493:1833,:);
% imwrite(frame,[path 'color_'  num2str(frameI,'%0.5d')  '.png']);
I = rgb2gray(frame);

  %% determine highThreshold
%             for k=1:40
%                 highThreshold=256-5*(k-1)
%                 I2=I;
%                 I2(I2>highThreshold)=0;
%                 imshow(I2);
%                 title(['highThreshold=' num2str(highThreshold)])
%                 pause();
%             end
% 
%     %% determine lowThreshold
%             for k=1:50
%                 lowThreshold=0+5*(k-1)
%                 I2=I;
%                 I(I<lowThreshold)=0;
%                 imshow(I2);
%                 title(['lowThreshold=' num2str(lowThreshold)])
%                 pause();
%             end

%% image processing and store
lowThreshold=70;
highThreshold=211;
I(I>highThreshold)=0;
I(I<lowThreshold)=0;
I(I>=lowThreshold)=256;


%% Resize particles
I=im2bw(I);

rp = regionprops(I,'All');
I(:)=0;
sizee=size(I);
partleSize=1;  % 2*partleSize+1 will be the diameter.
for ii=1:length(rp)
    x=round(rp(ii).Centroid(1));
    y=round(rp(ii).Centroid(2));
    if(x>=1+partleSize&& x<=sizee(2)-partleSize)
        if (y>=1+partleSize&& y<=sizee(1)-partleSize)
            I(y-partleSize:y+partleSize,x-partleSize:x+partleSize)=256;
        end
    end
end

%     imshow(I);
%     pause();
I= uint8(255 * I);  % Convert back to gray scale.
 