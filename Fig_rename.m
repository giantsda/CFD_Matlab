for i=1:1:54
    path='E:\desktop\temp\1\';
   s=num2str(i);
   if i<10
       s=['00000' s];
   else if i>=10 && i<100
       s=['0000' s];
        else if i>=100 && i<1000
       s=['000' s];
            else if i>=1000 && i<10000
         s=['00' s];
          else 
            s=s;
                end
            end
       end
   end
oldfile=[path 'AnimationFrame' s '.jpg']
newfile=[path num2str(i) '.jpg']
movefile(oldfile,newfile);
end
