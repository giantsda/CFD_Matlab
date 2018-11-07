 
path='E:\desktop\temp\PIV\0271\grey_00040.bmp';
II = imread(path);
imshow(II);

%% Resize particles
I=im2bw(II);
rp = regionprops(I,'All');
I(:)=0;
sizee=size(I);
partleSize=1;  % 2*partleSize+1 will be the diameter.
for i=1:length(rp)
    x=round(rp(i).Centroid(1));
    y=round(rp(i).Centroid(2));
    if(x>=1+partleSize&& x<=sizee(2)-partleSize)
        if (y>=1+partleSize&& y<=sizee(1)-partleSize)
            I(y-partleSize:y+partleSize,x-partleSize:x+partleSize)=256;
        end
    end
end
figure;
imshow(I)
 