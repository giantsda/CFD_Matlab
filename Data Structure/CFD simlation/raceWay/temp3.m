% RGB = imread('peppers.png');
% imshow(RGB)
% I = rgb2gray(RGB);
% figure
% imshow(I)


% D=D/max(max(D))*256;
% DD=256-D;
% DD=uint8(DD);
% imshow(rot90(DD))
surf(x,y,rot90(D)/max(max(D)),'edgecolor','none');
axis equal;
colorbar;
view(0,-90)

% haha=ones(20)-1;
% imshow(haha)