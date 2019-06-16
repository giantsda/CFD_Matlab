%% this file combine figs to generate a Movie by getframe
folder_path='C:\Users\chenshen\Desktop\temp\no escape\';
begin=1;
middle=1;
endd=130;
i=1;
for rere=begin:middle:endd
    if rere>=1 && rere<10
     file_name=['PIVlab_out_00' num2str(rere)];
    else if  rere>=10 && rere<100
     file_name=['PIVlab_out_0' num2str(rere)];
        else
             file_name=['PIVlab_out_' num2str(rere)];
        end
    end
     filename1 = [folder_path   file_name '.jpg'] ;
im(:,:,:,i)=imread( filename1); 
imshow(im(:,:,:,i))
M(i) = getframe; 
i=i+1;
end 
movie2avi(M,'out3.avi','FPS',30,'quality',100) 

