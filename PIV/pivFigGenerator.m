%% this file generate figs of all frame
mov=VideoReader('E:\desktop\temp\PIV\IMG_0271.MOV');
numFrames = mov.NumberOfFrames
path='E:\desktop\temp\PIV\0271\';
j=1;

for i = 1: 1: numFrames
    frame = read(mov,i);
    i
%         imshow(frame);
%         pause();
imwrite(frame,[path 'color_'  num2str(i,'%0.5d')  '.bmp']);
%     I = rgb2gray(frame);
% 
%     haha=1;
    
    
    %% determine highThreshold
    %         for k=1:40
    %             highThreshold=256-5*(k-1)
    %             I2=I;
    %             I2(I2>highThreshold)=0;
    %             imshow(I2);
    %             title(['highThreshold=' num2str(highThreshold)])
    %             pause();
    %         end
    
    %% determine lowThreshold
    %         for k=1:50
    %             lowThreshold=0+5*(k-1)
    %             I2=I;
    %             I(I<lowThreshold)=0;
    %             imshow(I2);
    %             title(['lowThreshold=' num2str(lowThreshold)])
    %             pause();
    %         end
    
%     %% image processing and store
%     lowThreshold=160;
%     highThreshold=230;
%     I(I>highThreshold)=0;
%     I(I<lowThreshold)=0;
%     I(I>=lowThreshold)=256;
%     
%        imshow(I);
%     %% Resize particles
%     I=im2bw(I);
%     rp = regionprops(I,'All');
%     I(:)=0;
%     sizee=size(I);
%     partleSize=1;  % 2*partleSize+1 will be the diameter.
%     for ii=1:length(rp)
%         x=round(rp(ii).Centroid(1));
%         y=round(rp(ii).Centroid(2));
%         if(x>=1+partleSize&& x<=sizee(2)-partleSize)
%             if (y>=1+partleSize&& y<=sizee(1)-partleSize)
%                 I(y-partleSize:y+partleSize,x-partleSize:x+partleSize)=256;
%             end
%         end
%     end
    
    %     I=I(61:847,484:1223);
    %     imshow(I);
    %     pause();
%     I= uint8(255 * I);  % Convert back to gray scale.
%     imwrite(frame,[path 'color_'  num2str(i,'%0.5d')  '.bmp']);
%     j=j+1;
%     disp(num2str(i));
    %     if mod(i,100)==0
    %         disp([num2str(i) ' / ' num2str(numFrames)]);
    %     end
end

