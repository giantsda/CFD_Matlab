k=1;
for i=1:1:29
ii=519+(i-1)*24;
    if ii<1000
        nu=['00' num2str(ii)];
    else 
          nu=['0' num2str(ii)];          
    end
filepath=['E:\desktop\PIV\piv large\' nu '.jpg'];
fig=imread(filepath);
imshow(fig);
imwrite(fig,['E:\desktop\PIV\combine\real\' num2str(k)  '.jpg']); 
k=k+1;
end     