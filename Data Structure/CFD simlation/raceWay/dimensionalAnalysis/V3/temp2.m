filePath='C:\Users\chenshen.ETS01297\Desktop\18_4R'
 

for i=1:2
   filename=[filePath num2str(i) '.png']
   a=imread(filename);
   imshow(a);
   b=a(2465:3561,2800:13140,:);
   imwrite(b,[filePath num2str(i) 'b.png'])
end